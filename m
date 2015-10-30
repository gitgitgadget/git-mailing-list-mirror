From: Balaco Baco <balacobaco@imap.cc>
Subject: Re: [Savannah-users] Anonymous commit (empty Author and Committer)
Date: Fri, 30 Oct 2015 12:39:42 -0300
Message-ID: <1446219582.3019364.424715177.39046D65@webmail.messagingengine.com>
References: <56337DF8.5050802@gmail.com> <56338C30.6010302@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: The development of GRUB 2 <grub-devel@gnu.org>,
	git@vger.kernel.org, savannah-users@gnu.org
X-From: git-owner@vger.kernel.org Fri Oct 30 16:39:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsBmN-0004lQ-MN
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 16:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbbJ3Pjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 11:39:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43841 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758707AbbJ3Pjn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2015 11:39:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A8E7208A5
	for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:39:42 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute1.internal (MEProxy); Fri, 30 Oct 2015 11:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=imap.cc; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=+oeZgqP9aGHmanwVwHeBOK8FCDU=; b=NHRH1/
	JES0k3RWs38rP0RcpJ+BUzMPhyj7qgkAY9T7BQmad9aO7+/ulPO3lEfECqzNebm9
	xxFMEN6rRQA41iDb37ImtqkBxBzr6yr7osrAinlRZ1K3R6P8sKoIMKwI9eFv7qLL
	E+ZBTk9r+prjGy3yMHtlhqdWb2W2l1J47xN14=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+oeZgqP9aGHmanw
	VwHeBOK8FCDU=; b=DD6rphR64+S4tlh25i7zPjQ6X+SEQjs/WY8Q89onJBSOfFO
	HupJrH9m3Eci++oMQ6rvlv+rVaOLuYHvfwSxCHenVO9zbPV9D3A9gs3kS8tz8fKO
	jOQBY98tgQRewBXgFMX0sGk8RKWclA3jie7GnMiKVLtgkK+eOsyFoUuMOtoA=
Received: by web2.nyi.internal (Postfix, from userid 99)
	id 2A0495402D6; Fri, 30 Oct 2015 11:39:42 -0400 (EDT)
X-Sasl-Enc: 3T/dkC+KLbBn6cTU4ia2F0R7dCyYR9/zrEWXEYoh5X5g 1446219582
X-Mailer: MessagingEngine.com Webmail Interface - html
In-Reply-To: <56338C30.6010302@riseup.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280489>


> > See 
> > http://git.savannah.gnu.org/cgit/grub.git/commit/?id=206676601eb853fc3
> 19df14cd3398fbdfde665ac
> >
> >
> > 
> > 
> > I was not even aware that this is possible. Is there anything on 
> > server side that can prevent it?
> > 
> > Would be good if commit were amended and force pushed to fix it.
> > 
> > 
> 
> Is this even a problem? I'm pretty sure Git warns you if you try to
> commit something before user.name and user.email are defined, and if
> someone wants to do so, I don't see why you should try to stop them.
> It wouldn't work, anyway; they would just write some simple name like
> "anonymous" and some nonsense email if they really want to be anonymous.
> 

This commit just removed a line from the README:

"Please look at the GRUB Wiki <http://grub.enbug.org> for
testing-procedures."

Is this change something that may justify that it's-not-me-there action?
I agree that it should not be prevented to avoid some pressure
situations that might be (eventually) present. Bogus random data there
would be harder to track. The empty fields are easy, and if it
guarantees some safety to whoever does it, should be the choice.


-- 
http://www.fastmail.com - mmm... Fastmail...
