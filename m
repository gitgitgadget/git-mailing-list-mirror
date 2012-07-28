From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extract remaining classes from git-svn
Date: Fri, 27 Jul 2012 21:25:01 -0700
Message-ID: <7vboj0y0ki.fsf@alter.siamese.dyndns.org>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
 <20120728004026.GA5363@dcvr.yhbt.net>
 <7vfw8cy1gv.fsf@alter.siamese.dyndns.org>
 <20120728041223.GB6129@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 06:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuybF-0004uC-0l
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 06:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427Ab2G1EZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 00:25:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab2G1EZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 00:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766B88826;
	Sat, 28 Jul 2012 00:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4J2JjafjH7hAscwAnJW0GlxXuyI=; b=nq+JL8
	odd0Vgzwloyar6doLCSgJ4oTWVmUV4em76ItFSTxnZiEa4BsGgdIKvYmJMzxk4Mq
	AZ25hILiwm+sJ4X95oFmxqgH9bDhrOZWFiEE7YSG1ZTCMkU0rPbjAWt6G4YR1RWK
	z2GPoViJLbGlXO+zl4j/VgVctnI0Rk2oUVvBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTh8YgCc8aIKZep34N47UtHkofC3UxFV
	VNQunBQPBUGVJWsH4TwSf+q/N+IhWXp5OB6Lmop6NK2+GPczcWJH9Mpy67XZ4z0X
	c0CJxJcRojvi96RKYaxSbugzQRUVJHBCWlPZyIgHovP7aw0IufJzLtX++m4XCAed
	3OvIR5C+pDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 464758825;
	Sat, 28 Jul 2012 00:25:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDD0B8824; Sat, 28 Jul 2012
 00:25:02 -0400 (EDT)
In-Reply-To: <20120728041223.GB6129@dcvr.yhbt.net> (Eric Wong's message of
 "Sat, 28 Jul 2012 04:12:23 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 336AC3EE-D86C-11E1-8AE4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202403>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > "Michael G. Schwern" <schwern@pobox.com> wrote:
>> >> This series of patches extracts the remaining classes from git-svn.  They're
>> >> all simple extractions and functionally have no change.
>> >
>> > I've also pushed this to the "extract-remaining" series which
>> > also includes everything that's currently in my master.
>> 
>> Do you mean this should go in 1.7.12-rc1, or your master is for
>> 1.7.12 and this is for post 1.7.12 but you are pushing it out to
>> help other developers who are working on git-svn as a preview?
>
> I'm comfortable with this series so far, so going into 1.7.12 is fine.

OK.  Thanks.
