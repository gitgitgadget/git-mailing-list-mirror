From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Sat, 24 Mar 2012 11:43:46 +0700
Message-ID: <CACsJy8Ctyujq+F0qSe_=ddHxWLUaD6xAtwCZBvySFi275_P2Cg@mail.gmail.com>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Hitoshi Mitake <h.mitake@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 05:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBIq0-00074I-Hs
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 05:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab2CXEoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 00:44:19 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49930 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab2CXEoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 00:44:18 -0400
Received: by wibhj6 with SMTP id hj6so2614218wib.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2P6sdAOnitV/zvPm6UALAw0lsiRjpPblAA9m04F8Cv4=;
        b=C5L+KUac47u07Iv02Yj1q4/Y16V5JgqIWWBm6/E1zxTw7m4cyA0PUZ3mD7BROtOokz
         unLb3NeWXvAXXzQ8JaT+vWxmPwkpMDa0DGnCBkjvlJ08zB4qwFZPfvjdDWP7xTiizn1l
         Pqp9vt5AMQ4I6y6PRmKa6G7RBXQaIMwRH2FqFBMlYKTioQx7XDNypXCYaWvP2sY5D0m6
         PMqOxLwwoKaaA3koEKuOFBSR9UQRXukXDCNPn/EFtMFXEtbvBCOzcNV3y1yS/hKppecB
         BnVmmAz9XYKeRwPtmVH3xKHXbHOKV0Dpb12tF3GaLgHi9e9Oys9kRfItAKuuLlM5WzxS
         Qiew==
Received: by 10.180.107.101 with SMTP id hb5mr2472943wib.7.1332564256852; Fri,
 23 Mar 2012 21:44:16 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Fri, 23 Mar 2012 21:43:46 -0700 (PDT)
In-Reply-To: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193816>

On Fri, Mar 23, 2012 at 1:42 AM, Hitoshi Mitake <h.mitake@gmail.com> wrote:
> Hi Junio C Hamano and git people,
>
> I'd like to post this patch series for adding a pager program for git-log,
> named "git-less". It seems that less is today's the most popular pager for
> git-log. But I don't think that less is confortable pager when its input is come
> from git-log. Because less treats its input as a simple text. So less cannot
> recognize the end of each commit.

How does it compare to tig?
-- 
Duy
