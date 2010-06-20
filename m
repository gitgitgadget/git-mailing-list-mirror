From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Deleting remote branches
Date: Sun, 20 Jun 2010 14:49:54 +1000
Message-ID: <AANLkTimjVoRBDxRyfOcDc2SGacSReL9VdN8vhPGIdZ5b@mail.gmail.com>
References: <1276971471250-5199192.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: jhapk <pradeep.kumar.jha@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 06:56:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQCZt-0007Yp-OJ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 06:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab0FTEt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jun 2010 00:49:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:65362 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0FTEtz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jun 2010 00:49:55 -0400
Received: by qyk1 with SMTP id 1so764700qyk.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 21:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=niS8x/nUmV6TBSw/av/jI2JPeX0LOzM5CPKK6WpUj1w=;
        b=k4hj2pPUx+/xcv6/ruAPcXlB+kxKm/jC4feIQ7URLlG/V2FXGk3wWC8jQi4XA0m5y2
         qrhJGTctHRNZK/0ESDEMSbGVg09wTdDyYr4DpDlH0ZjmaEn7P53BSd7SauezHvqFXKnd
         FPHcTDZtx9Wh9Uz3MoJYbt2ituWK/9tj4dIIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D9lgjKKVnLjn+TlTu6VWrzdihRdtYr/kLWtDNiAOIjdg+G0+aaghoogrGGKglG1D79
         nLn8UQmgTCr7nIRaxHUAIt7nD45ooGpMxZEjSAW5G1w8MNua0RBhqnA/3yv77IAImrmK
         sU0DJrk5g2LMSElI3sKYSeBKWPiNiB6fjGNUg=
Received: by 10.229.213.136 with SMTP id gw8mr1725002qcb.193.1277009394748; 
	Sat, 19 Jun 2010 21:49:54 -0700 (PDT)
Received: by 10.229.104.194 with HTTP; Sat, 19 Jun 2010 21:49:54 -0700 (PDT)
In-Reply-To: <1276971471250-5199192.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149389>

You probably should have used git remote rm PCM which will maintain
the consistency between .git/config and .git/refs/remotes

Probably easiest thing to do would be to add a remote called PCM back,
then remove it with git remote rm PCM.

jon.

On Sun, Jun 20, 2010 at 4:17 AM, jhapk <pradeep.kumar.jha@gmail.com> wr=
ote:
>
> Hi,
>
> I added a remote called PCM to my repository. So when I do a
> $git branch -a
>
> It shows me all the branches of the remote. I decided I don't want th=
e
> remote anymore, so I deleted it from my .git/config file and did
> $git remote update
>
> The first command verified that PCM is not a remote anymore, but stil=
l when
> I do a $git branch -a, =C2=A0I see all the branches of PCM.
>
> How do I get rid of it?
>
> Thanks
>
> --
> View this message in context: http://git.661346.n2.nabble.com/Deletin=
g-remote-branches-tp5199192p5199192.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
