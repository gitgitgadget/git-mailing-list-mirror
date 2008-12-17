From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo with git protocol?
Date: Wed, 17 Dec 2008 21:37:36 +0800
Message-ID: <856bfe0e0812170537n78abbd57pfe33b3829941ebb9@mail.gmail.com>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
	 <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
	 <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
	 <bd6139dc0812170353y5d78f03ao1c0619c9bd68f309@mail.gmail.com>
	 <856bfe0e0812170435t32fce496q41f825c01ee7045c@mail.gmail.com>
	 <bd6139dc0812170447h7546cbf0v3151166668ad1248@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 14:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCwc6-0003YX-Ir
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 14:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbYLQNhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 08:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYLQNhk
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 08:37:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:21954 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYLQNhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 08:37:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1761406wah.21
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 05:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Gnqaos6uzMndqMmw3P2ByWJZKDYkQIKOv2MU07NmwD0=;
        b=HEzhRMRtfbE3PmVajZe8i0u1q1pGernBjhEbXMAzKs4Ev++xiMWkTVdoRAI3aLfK0V
         gaT4QA3fTgtblmZW9F9ULsR3V4XD4ePgfJGu2vaJ5Td/Xx2h6xeN3Og492WkryWePNsk
         FdG8HghV3kM6Vf0yi/+wk5E7uOUrSIIixeqlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O+ceL63DsgOrq4WAkXqEqYIYZfuXSDVIAMHbhxOgP/h+e0YPToNZHDuRvOI2efGOYU
         IfhUPDQrNj+X6XYwfQ7zvmSRuojhQ8pmi+/4uNR8m0IcTFc2cCk34YG6/vpN3GWeQPof
         oDM8zDcLI9n4LSToD1AHxT7zCn2g0LoCpWMww=
Received: by 10.114.24.5 with SMTP id 5mr350111wax.106.1229521056918;
        Wed, 17 Dec 2008 05:37:36 -0800 (PST)
Received: by 10.114.25.10 with HTTP; Wed, 17 Dec 2008 05:37:36 -0800 (PST)
In-Reply-To: <bd6139dc0812170447h7546cbf0v3151166668ad1248@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103349>

Sverre, Johannes,

Thank you very much for sharing your good idea ! Yes, maintaining two
separate rep maybe best.

Johannes,
Does your second suggestion mean that I need to write a script and use
git hook to enable it ?

Thanks,
Emily


On Wed, Dec 17, 2008 at 8:47 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> [It is common not to top-post on this list :)]
>
> On Wed, Dec 17, 2008 at 13:35, Emily Ren <lingyan.ren@gmail.com> wrote:
>> As far as I know, gitosis can control someone readonly/writable to
>> some repo, it has no access control on branch/tag level. Am I right ?
>
> Ah, sorry, I meant to control access to different repo's for different groups.
>
>> I'll look at github and gitorious, are they free software ?
>
> IIRC gitorious is open source, but I just checked and I don't see any
> access control there; which leaves github, which is not free software
> I'm afraid.
>
> I think, as Johannes said, keeping two seperate repo's and using some
> form of access control on those would be best.
>
> --
> Cheers,
>
> Sverre Rabbelier
>
