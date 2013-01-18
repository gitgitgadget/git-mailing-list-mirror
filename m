From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question re. git remote repository
Date: Fri, 18 Jan 2013 13:20:14 -0800
Message-ID: <7v622uqjch.fsf@alter.siamese.dyndns.org>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
 <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com> <201301181833.r0IIXNGb027544@smtpb02.one-mail.on.ca> <alpine.DEB.2.02.1301181127590.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Lang\, David" <David.Lang@uhn.ca>,
	"'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:20:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwJMe-000275-5G
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 22:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab3ARVUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 16:20:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754787Ab3ARVUR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 16:20:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15307B460;
	Fri, 18 Jan 2013 16:20:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o6351W3Po/ytk978YnAYezi1sjk=; b=g6DHA/
	lJNpz5C5MzYzsay5GErz4ryseYo0/feOsij5NUmepupgDDOBnOFlbmTYd3q3gjiv
	RQ2LZWLdEuFqkrfCX484HviuqIlkDknbIBOdREFwiNAQfTGJdxhVFuw16mpt9sAY
	WFRvuSXd5B0qxPCUwWZGT3oG2ASxRaiw6A8Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/fPg2zYJTqYd8xhs6HP68282kqEpYAn
	i+kXKdJmBxEABzZ7+Aq0Qe+HH70Ex+E7I/fncV3i0pzN/xfPyj1AY1385spSu8CS
	yQj2lZnG/V6h0kIElzvg4qqbtTnBN1DxyZyk7Jr7bzuHcZ7V3EFxDGqLVayHwSuR
	jCoOoo69V9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09B1EB45F;
	Fri, 18 Jan 2013 16:20:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77502B45A; Fri, 18 Jan 2013
 16:20:16 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1301181127590.21503@nftneq.ynat.uz> (David
 Lang's message of "Fri, 18 Jan 2013 12:27:51 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAA7CEFA-61B4-11E2-97E7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213938>

David Lang <david@lang.hm> writes:

> What I would do is to have each developer have their own local copy
> that they are working on.
>
> I would then find a machine that is going to be on all the time (which
> could be a developer's desktop), and create a master repository
> there. Note that if this is on a developers desktop, this needs to be
> a different repository ... from
> what they use to do their work.
>
> developers then do their work locally, and after a change has been
> reviewed, pull it into the master repository.

s/pull it into/push it into/; I think.
