From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/1] gc --auto: warn gc will soon run, give users a chance
 to run manually
Date: Sun, 6 Nov 2011 09:47:54 +0700
Message-ID: <CACsJy8DusGtKYWANPFkn9eAp42oe-2uS5b7Rp2oAaNzfUZAB1A@mail.gmail.com>
References: <1320489212-524-1-git-send-email-pclouds@gmail.com>
 <20111105140529.3A6CE9004A@inscatolati.net> <20111105151225.EE3869004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fernando Vezzosi <buccia@repnz.net>
X-From: git-owner@vger.kernel.org Sun Nov 06 03:48:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMsme-0005Rj-Io
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 03:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab1KFCs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 22:48:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53266 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab1KFCs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 22:48:26 -0400
Received: by bke11 with SMTP id 11so2876680bke.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ck05A3J6hfpoeGfAxrKXrRhCrOimufI+yelDkDsEHa4=;
        b=mYcnsRq+U6XxCU70jGT2ol9tT5HDEYzrNEYzZlkbEAsrZZqeBayooED0c4Y0WXv/Ry
         ZODj4YV+rTdJ3ikERgMacPVNqE6E2/h0acng45/ZNxWgTFb6s6PA4EGHA2ujoI45bTkj
         PnTUSMrvDWWOCnUMjfAX0mqIWX/ogE+qMme3Q=
Received: by 10.204.16.67 with SMTP id n3mr15634941bka.6.1320547705214; Sat,
 05 Nov 2011 19:48:25 -0700 (PDT)
Received: by 10.205.134.1 with HTTP; Sat, 5 Nov 2011 19:47:54 -0700 (PDT)
In-Reply-To: <20111105151225.EE3869004A@inscatolati.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184894>

On Sat, Nov 5, 2011 at 5:33 PM, Fernando Vezzosi <buccia@repnz.net> wro=
te:
> Signed-off-by: Fernando Vezzosi <buccia@repnz.net>
> ---
>
> Rebased Nguy=E1=BB=85n's patch on top of mine.

I think when gc.autowarnonly is true, my patch should be no-op because
you'll get warnings eventually when you hit the thresholds.
--=20
Duy
