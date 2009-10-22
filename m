From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 21:58:03 +0100
Message-ID: <26ae428a0910221358r47434b4uf7ec71f9376b9f75@mail.gmail.com>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
	 <19168.49405.775024.649626@lisa.zopyra.com>
	 <19168.50232.47935.864407@lisa.zopyra.com>
	 <8c9a060910221351w12e6c610kb842263e1c02ea63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 22:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14ji-0003eu-T2
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbZJVU6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756480AbZJVU6I
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:58:08 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54833 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951AbZJVU6H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 16:58:07 -0400
Received: by ewy4 with SMTP id 4so1035930ewy.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=TTnj8wK7FmX7Zhi7Kp25Eyf4WtUzzTzsKSDWkfB4/Ek=;
        b=SFwuoxbMprWychs0XJ7GV8Vf2KwreFNBbcG8lhQaR4py3zFp0ERIrWw1hD9YZhQsm6
         CI3rp+ujKmtcGjF+iR94qRY+stHFIz1K7t8+0XwWPAGd0puYo6XyAPoST9Mb3lwluOI2
         S2KYrmL1zNpJNXx8/JSRncAN2AIwnyvKQ6C+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=DLG1lBe8VYEpyhoy1n0HeNT1OJYe3VZLT+mRAhubUyDIlvvBN6zPMv4QFx32y/d3iu
         3WETUTVOmT7a4twbw6u9KjnFuECzD3wJcHRLQImF4sHqGJGMjO0fr3YYF2EJ56l4qSXr
         pj/ACBuxmIRNQvoIjXvEP/J1vqTz1FutT18KM=
Received: by 10.216.91.13 with SMTP id g13mr3494589wef.36.1256245083666; Thu, 
	22 Oct 2009 13:58:03 -0700 (PDT)
In-Reply-To: <8c9a060910221351w12e6c610kb842263e1c02ea63@mail.gmail.com>
X-Google-Sender-Auth: e77d06da828f9872
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131059>

>
> Alternatively, you could use git merge --squash
>
> git checkout master
> git merge --squash topic
>
> See git-merge(1) for details.
>
> rebase --interactive it excellent for cleaning up history, especially
> if you want to end up with more than one commit at the end. =A0merge
> --squash is usually sufficient if all you need is one commit at the
> end.
>

Brilliant, thanks everybody!! I'll go and back up my database and have
a play with these options.
