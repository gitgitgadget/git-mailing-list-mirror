From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: long fsck time
Date: Wed, 2 Nov 2011 19:10:26 +0700
Message-ID: <CACsJy8B=5mEWoOBkrTfmJ+p7HxqJM97zdG-k71oW81-3XxuO_Q@mail.gmail.com>
References: <CACsJy8D04Hw0_OoV01g2xtNK2d6fmZD_+YNEOR3A8aMUTpG5Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 02 13:11:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLZep-0004RG-3o
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 13:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab1KBMK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 08:10:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32994 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab1KBMK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 08:10:58 -0400
Received: by bke11 with SMTP id 11so73485bke.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=Af/ooIJzN63ocbDJVXQc6kkNXomFgey1CGMzYYCO6e4=;
        b=hBdFFsgjdcq/fGbVsqfVQT9OFgYUXPr+EnVKKe2NYN69I+kSZwnyLOtVjrbEIVLk94
         jfIiz5Hjd9iZgYeB8YK5qENDK1BJ8mup3CqulDiMCiiTu8OP131kCctxv41FVFnjR4L4
         H6aesfSJ64ajEVmyBJKgqdVapdFEfry47SUik=
Received: by 10.204.16.67 with SMTP id n3mr3528437bka.6.1320235857192; Wed, 02
 Nov 2011 05:10:57 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Wed, 2 Nov 2011 05:10:26 -0700 (PDT)
In-Reply-To: <CACsJy8D04Hw0_OoV01g2xtNK2d6fmZD_+YNEOR3A8aMUTpG5Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184630>

On Wed, Nov 2, 2011 at 7:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On git.git
>
> $ /usr/bin/time git fsck
> 333.25user 4.28system 5:37.59elapsed 99%CPU (0avgtext+0avgdata
> 420080maxresident)k
> 0inputs+0outputs (0major+726560minor)pagefaults 0swaps
>
> That's really long time, perhaps we should print progress so users
> know it's still running?


Ahh.. --verbose. Sorry for the noise. Still good to show the number of
checked objects though.
-- 
Duy
