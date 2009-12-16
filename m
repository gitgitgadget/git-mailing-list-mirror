From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Tue, 15 Dec 2009 17:22:42 -0800
Message-ID: <7v8wd3ww4d.fsf@alter.siamese.dyndns.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
 <m3ljh9cy3b.fsf@localhost.localdomain> <4B226C0F.2070407@kernel.org>
 <200912112353.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J.H." <warthog9@kernel.org>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:23:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKibe-0005pO-PB
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 02:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbZLPBXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 20:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756729AbZLPBXB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 20:23:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbZLPBW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 20:22:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8ED29A7B6A;
	Tue, 15 Dec 2009 20:22:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yandlPLI3pHFBS/CLER035K50rY=; b=SaCmd3
	l5COQlP6HpXbripgZ03bn+ivR96/pcC+kHRecBq/fgYW6vS2femmZzoiMGbA90ue
	PcasYrf92DGmKJMjWPvtj0IE7lXyF8T1RgkEjzsevIaoXMtNV47F6mPRRZxi1ta9
	B18mRtnRNKplTxMmlEhf+1KVnG9tHOMlwG2yU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hCyfakzbMJKy28ZIHrx22fXu1dghovfJ
	5G1xNiGHhZvy2dXmNdRLvbm+K+RixidJ7iO4D9o+TEcWyt+D04P6qJg1qlQ+SQrM
	Rxr+4m9xbCp40znOk5QH8tVhRK6iAS0BvNUEgSZeUONYCNRCoRE8797xoIQq/F1Q
	FTleMo+9gtE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E96EA7B68;
	Tue, 15 Dec 2009 20:22:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9765CA7B66; Tue, 15 Dec 2009
 20:22:44 -0500 (EST)
In-Reply-To: <200912112353.11034.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri\, 11 Dec 2009 23\:53\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8698B638-E9E1-11DE-8E8E-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135313>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 11 Dec 2009, J.H. wrote:
>
>>>> This is also a not-so-subtle start of trying to break up gitweb into
>>>> separate files for easier maintainability, having everything in a
>>>> single file is just a mess and makes the whole thing more complicated
>>>> than it needs to be.  This is a bit of a baby step towards breaking it
>>>> up for easier maintenance.
>>> 
>>> The question is if easier maintenance and development by spliting
>>> gitweb for developers offsets ease of install for users.
>> 
>> This would just get dropped into the same location that gitweb.cgi 
>> exists in, there is no real difference in installation, and thus I can't 
>> see this as an issue for users.
>
> To be more exact you have to know that you have to drop _generated files_,
> which means (for this version of patch) gitweb.cgi and gitweb_defaults.pl
> (or whatever the generated file with config variables would be named).
>
>
> ATTENTION!

You didn't have to shout.

Any progress on this front?

Not that I am anxious to queue new topics to 'next' right now (we are
frozen for 1.6.6), but I think having what is proven to work well at a
real site like k.org is much better than waiting for an unproven
reimplementation using somebody else's framework only for your theoretical
cleanliness.  John has better things to do than doing such a rewrite
himself, and even if you helped the process by producing a competing
caching scheme based on existing web caching engines, the aggregated
result (not just the web caching engine you base your work on) needs to
get a similar field exposure to prove itself that it can scale to the load
k.org sees, which would be quite a lot of work, no?
