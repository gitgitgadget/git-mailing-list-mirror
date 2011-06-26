From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: git push in a git-init without --bare option?
Date: Sun, 26 Jun 2011 13:35:56 +0200
Message-ID: <BANLkTikWz81GM5mouzOHwi4eAGvg1BG8XQ@mail.gmail.com>
References: <201106261142.28142.psdc1978@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Pedro Sa Costa <psdc1978@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 13:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QandD-0006gd-Gp
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 13:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab1FZLf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 07:35:59 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44323 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab1FZLf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 07:35:57 -0400
Received: by qyk9 with SMTP id 9so2260519qyk.19
        for <git@vger.kernel.org>; Sun, 26 Jun 2011 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=KMTsFioc0PTkputZskqIcqcFbXUIhTSiaIBO2pOdtKA=;
        b=CmVwosAc3YD6KgVUHBzeC82IDSV3LBr2Kf1Z9/WLabaKMJkkfqzDqcdiSoTtIHwLiW
         8xzM2wV2wM7htwlndpYQUXRFLJU4bhAqCHssYzvnEbzx9htqMtjSIVuR9p/6zdaWyQtv
         8h+/q0ya1lY/DRm0zsISk//xkkpjqsy+yJu6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=OJYbkhYJvqEuaouKohTL+aZOCq+lDZZzUObtQgGXJnc9jDBd8i6E/OeVIB+72s+S4v
         AVxVvJCJHOYVwU3BaoRlEC82tWGh4XW91YwXhuMnRTS+ORravbf9OUli4T1iAuqqUFZV
         c+3Ktk3TSUQ+LNbjN1GCKQGctPQFTOeeMcewY=
Received: by 10.229.45.65 with SMTP id d1mr3838253qcf.288.1309088156605; Sun,
 26 Jun 2011 04:35:56 -0700 (PDT)
Received: by 10.229.97.204 with HTTP; Sun, 26 Jun 2011 04:35:56 -0700 (PDT)
In-Reply-To: <201106261142.28142.psdc1978@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176323>

Git doesn't keep track on the remote repo if someone change the
checkout file. So it was always a bad habit to push to a not bare
repo, you could lost commit. From 1.7 git don't permit, by default, to
push to a non bare repo. Best regards

2011/6/26, Pedro Sa Costa <psdc1978@gmail.com>:
> Hi,
>
> I'm newbie in git and I'm trying to understand how git works.
>
> - I see that in git, I can't do git-push to a repository that wasn't created
> with git-init --bare. Why?
>
> - But doing git-pull and git-checkout to the same repository is possible.
> I'm
> really confused. Any help?
>
> --
> Best regards,
>
> -----------------------
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile
