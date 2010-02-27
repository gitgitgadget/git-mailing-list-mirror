From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] git-push: make git push --dry-run --porcelain exit 
	with status 0 even if updates will be rejected
Date: Sat, 27 Feb 2010 10:44:14 +0800
Message-ID: <be6fef0d1002261844u5082b5bv90d46852218f632e@mail.gmail.com>
References: <cover.1267216808.git.larry@elder-gods.org>
	 <6d253d15b5174c3982bcc434b7c2b361712d20cb.1267216808.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Feb 27 03:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlCfE-00061e-CV
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 03:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967547Ab0B0CoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 21:44:16 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:42992 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759532Ab0B0CoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 21:44:14 -0500
Received: by iwn12 with SMTP id 12so790626iwn.21
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 18:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O6u7RgHn+Dy4Ufk7wuSYGxxU3QQNPjldqqlS9NYsaD8=;
        b=KbXbdS/EeWofz4ayEWwAc7IlyLWv32/1qnlowipdlrD5A45izm3ayMhbr2FuOMxUTi
         Kk4XHIkHTBz9TbJVbO8t1bwbTzWRJyV/+QQ/+9o6w3Zvp4wfp/HbwIWfBaXV+vDURo/x
         w/yCKIMfUQC80O3nGc1ZyJUzWPoypje3X1dzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SGHeJl61qLfCUZ48Gzqltp1YQfyKweAS/at3UCVMMjKmjx6lv6MrcemIHdDaq0ujIQ
         WKyymn3Ic1f2AHnCnE1JI+yEMYXoSY5rBzvP8SaX7bbCMOOLgG9BPaevcLLCQrArRtm/
         ng/lTy+1n9ZjbfsDgpkW5kX9YDxZUPNr1EONU=
Received: by 10.231.144.207 with SMTP id a15mr337169ibv.94.1267238654265; Fri, 
	26 Feb 2010 18:44:14 -0800 (PST)
In-Reply-To: <6d253d15b5174c3982bcc434b7c2b361712d20cb.1267216808.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141167>

Hi,

On Sat, Feb 27, 2010 at 4:44 AM, Larry D'Anna <larry@elder-gods.org> wr=
ote:
> The script calling git push --dry-run --porcelain can see clearly fro=
m the
> output that the updates will be rejected. =A0However, it will probabl=
y need to
> distinguish this condition from the push failing for other reasons, s=
uch as the
> remote not being reachable.
>
> Signed-off-by: Larry D'Anna <larry@elder-gods.org>

I thought that in the previous iteration, the status won't be touched
anymore? You agreed too:

  <20100210055529.GA1566@cthulhu>

--=20
Cheers,
Ray Chuan
