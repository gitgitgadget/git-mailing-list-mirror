From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Make git-svn Use accessors for paths and urls
Date: Sat, 28 Jul 2012 00:40:05 -0700
Message-ID: <50139755.7020105@pobox.com>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <20120728030959.GA3020@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv1dS-0007jL-Pw
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 09:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab2G1HkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 03:40:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab2G1HkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 03:40:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E54765612;
	Sat, 28 Jul 2012 03:40:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=4sWI4JFRw4Oz
	OO3Cwd4cs6qvaOk=; b=wQVkWopZ76VQrdbdVWUAxUPA+HAz4Z9QuqjbOj1v2AUS
	HhPN2j4blARPoOGsTXYVIURjvUxjiX6Noa9da0JhX6Axa9Idqq839ZyQwXqbJjIj
	xQRFVe/0oyLnutpYeXOohj0uE6GkcADLycfCiGopu5AfWNjAlmbhQQ2Bv7PXkj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RoY/7p
	DflSdRBqE3giUu4j4YHiHH/EOMuD8aLZA4Obww8PGtsC832gXm3NmPdDzp3wVHhY
	98yUiKInTCZme51EAcjSbNxp+qDrpkQAX3mACs4qK+EB0FcRoRMR3Z/KSQnEgBJQ
	vQoAgiVSUvxISVlIQcw4MHjAagDSoJ8nVyuNs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D17DB5611;
	Sat, 28 Jul 2012 03:40:14 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE278560F; Sat, 28 Jul
 2012 03:40:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728030959.GA3020@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 781BE2BE-D887-11E1-A61F-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202409>

On 2012.7.27 8:10 PM, Jonathan Nieder wrote:
>> This is the last refactoring patch series.  After this bugs, start
>> getting fixed.
> 
> I just wanted to say thanks for your thoughtful presentation of this
> code.  I was worried before, but these have been pleasantly submitted.

You're welcome.  I've gained at least three levels in rebasing in the process.


> If you have a chance at some point to offer advice, I'd love to add
> the information to Documentation/SubmittingPatches that was missing.
> Proposed text is ideal, but outline form or a list of missing aspects
> and confusing existing coverage would be fine, too.

Remind me when I'm done with the 1.7 fix please?


-- 
You are wicked and wrong to have broken inside and peeked at the
implementation and then relied upon it.
	-- tchrist in <31832.969261130@chthon>
