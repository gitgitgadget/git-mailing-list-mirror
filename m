From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Thu, 04 Oct 2012 09:27:05 -0700
Message-ID: <7vwqz619uu.fsf@alter.siamese.dyndns.org>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
 <A4A111D1488E49FFA4D71D85DD6B87A4@rr-dav.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtbN-00033L-D0
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933427Ab2JDQ1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 12:27:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933406Ab2JDQ1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 12:27:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC2B8521;
	Thu,  4 Oct 2012 12:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DNAL15UdIWzf+0licFA5tRdWjXo=; b=em5VUY
	RKicLX7eA1yTb/88Q9d4fkQZUM98V7JdUda+ujvx6HDfTmYepfNUPYhWZed5/tA3
	wvpDMDo1v9qqdlHVuau50T3XNPMptFaTLibSFaMVOpoO29p1sx9SX4Bs7eDZIR3K
	MKVUoCK3cB8He7+hnVfQRCaYIbLt3f5AnxEdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YlHWl4yNmMBK+yzwIAXC6d00/3x7u8xw
	zLcvR7t70AekfXMAkkjAZ/HxylUlGUU52bj3UE/dJ03SueIGgohUABrD4RuwQpVu
	S4SQbjVjlZ29OYcK7nL1d9pgrUulR5khO8i5/YO+MPzeMf4h7iIL7f+Y+x6TvYGN
	O74PscGHPyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE598520;
	Thu,  4 Oct 2012 12:27:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63F80851F; Thu,  4 Oct 2012
 12:27:07 -0400 (EDT)
In-Reply-To: <A4A111D1488E49FFA4D71D85DD6B87A4@rr-dav.id.au> (David Michael
 Barr's message of "Thu, 4 Oct 2012 18:17:52 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56F9B6DA-0E40-11E2-85F6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206984>

David Michael Barr <b@rr-dav.id.au> writes:

> On Wednesday, 3 October 2012 at 9:20 AM, Junio C Hamano wrote: 
>> 
>> * fa/remote-svn (2012-09-19) 16 commits
>> ...
>> 
>> A GSoC project.
>> Waiting for comments from mentors and stakeholders.
>
> I have reviewed this topic and am happy with the design and implementation.
> I support this topic for inclusion.
>
> Acked-by: David Michael Barr <b@rr-dav.id.au>
>> 
>> * fa/vcs-svn (2012-09-19) 4 commits
>> ...
>
> This follow-on topic I'm not so sure on, some of the design
> decisions make me uncomfortable and I need some convincing before
> I can get behind this topic.

Thanks for a feedback.
