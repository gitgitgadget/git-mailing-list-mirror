From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo with git protocol?
Date: Wed, 17 Dec 2008 13:47:19 +0100
Message-ID: <bd6139dc0812170447h7546cbf0v3151166668ad1248@mail.gmail.com>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
	 <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
	 <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
	 <bd6139dc0812170353y5d78f03ao1c0619c9bd68f309@mail.gmail.com>
	 <856bfe0e0812170435t32fce496q41f825c01ee7045c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Emily Ren" <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:48:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvpP-0001Hs-G2
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYLQMrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbYLQMrV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:47:21 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:23221 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYLQMrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:47:20 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1532028ywe.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 04:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=2Rg+ctYp2B4i0GmsnL6Z/Sj9yv221rprmrSt/7MI1yY=;
        b=prgJ3FJ5f33pTXPXi9p8mlphQo/X+3Soe2z/gtiApbuo4yoIyy74YV18Dve82lFlfK
         TQ7Ie72/QZxcJNk0Tc/MCtcTE0jhbNL8gwjNVkkJB6rWbN5xDWYaVBQtRpROBZBvkFtW
         xsmKssZkh0LYv/3E4GflFqtaPwHBLiVQkebkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=yEwpbL0GGUOdnnV6Io23M0KP3ZV5zzT8tThZK/rEdI0s4WYiwXCie51zIBtd1Kx1NA
         lGxu1Ho4KY9tixjwLbv+DAj2VKkfEVB2Cl2xDEfApu65eUijs/Bce2Ug78TokPfBXjD/
         BvBfitgfXkH1W8TnxvR72iSMn2rdeOjrX73nU=
Received: by 10.151.15.9 with SMTP id s9mr1331475ybi.87.1229518039237;
        Wed, 17 Dec 2008 04:47:19 -0800 (PST)
Received: by 10.151.13.13 with HTTP; Wed, 17 Dec 2008 04:47:19 -0800 (PST)
In-Reply-To: <856bfe0e0812170435t32fce496q41f825c01ee7045c@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: acb0f34068290976
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103348>

[It is common not to top-post on this list :)]

On Wed, Dec 17, 2008 at 13:35, Emily Ren <lingyan.ren@gmail.com> wrote:
> As far as I know, gitosis can control someone readonly/writable to
> some repo, it has no access control on branch/tag level. Am I right ?

Ah, sorry, I meant to control access to different repo's for different groups.

> I'll look at github and gitorious, are they free software ?

IIRC gitorious is open source, but I just checked and I don't see any
access control there; which leaves github, which is not free software
I'm afraid.

I think, as Johannes said, keeping two seperate repo's and using some
form of access control on those would be best.

-- 
Cheers,

Sverre Rabbelier
