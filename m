From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Feb 2011, #04; Wed, 16)
Date: Thu, 17 Feb 2011 13:20:28 +0100
Message-ID: <4D5D128C.1080808@drmicha.warpmail.net>
References: <7vk4gzh8cd.fsf@alter.siamese.dyndns.org> <m3aahu987n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2tc-00086R-CV
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab1BQMXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:23:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34886 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753645Ab1BQMXg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 07:23:36 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 060B920664;
	Thu, 17 Feb 2011 07:23:36 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 17 Feb 2011 07:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=eo9NDjFXH1xT/z69iS0+vvGVB18=; b=uuRQf7QyeuMLUrYFVPx7sseEaxH31lhU+Ra1qUh20zR5LdyScD7GAjtRd4hUlIsqF5KQqMkKZW77RKEFsRHx+TppckYj+jgptTACFdilaXgUHHSBC6FN2O/lrWWl1zUiaUXHIlQMol/iJ8VhVXEROC85wGuM0YuXCasShlGnllA=
X-Sasl-enc: 8xJfo1qXI9bBqB/TcevEHmz/w/2aNqsYQwlVDoHAqxzh 1297945415
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 63985445023;
	Thu, 17 Feb 2011 07:23:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <m3aahu987n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167075>

Jakub Narebski venit, vidit, dixit 17.02.2011 13:06:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> * mg/placeholders-are-lowercase (2011-02-15) 4 commits
>>  - Make <identifier> lowercase as per CodingGuidelines
>>  - Make <identifier> lowercase as per CodingGuidelines
>>  - Make <identifier> lowercase as per CodingGuidelines
>>  - CodingGuidelines: downcase placeholders in usage messages
>>
>> Will merge to 'next'.
> 
> Hmmm... three different commits with the _same_ subject?

How would you even know they are different, since you neither read the
commit messages nor looked up the thread? Thomas Rast's work makes the
latter even simpler these days.

Just to save everyone else the pain:

For easier review, the commits are split by the grep expression which
was used to identify candidates for the substitution. They may be
squashed, of course. (Adding "part 1" etc. wouldn't have clarified
anything, and our subjects are length limited.)

Michael
