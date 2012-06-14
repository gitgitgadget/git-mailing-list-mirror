From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Thu, 14 Jun 2012 10:22:17 -0700
Message-ID: <7vtxyderli.fsf@alter.siamese.dyndns.org>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
 <m2sjdynqlf.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: perryh@pluto.rain.com, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfDkW-0005rt-AX
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab2FNRWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:22:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab2FNRWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 13:22:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88706842E;
	Thu, 14 Jun 2012 13:22:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B+/3d+kBbQFbx84OE2cq58GdvnQ=; b=ovB8Qc
	gP1ZBcgoKhsA+1v8r58ptEDGXT/4qYMVoexVRjbCFhrOI6ZLdkGrlHQA1ZVTw7rh
	ZQOwvcuhWlQpGwCLLTYyilwJPVUYPmOYXveSuLI1lqenI7EGs1M1F72Z96XsYFZD
	/27JYnkzGX6E0z2TMLi/TPax4UkXUuZbkjiwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zf/CRgUXOpf680gkWHeyenC3ShAyvHRM
	LE1WQ3ul/z9eG93TyKbIWdpxpkMoENzZDXS/Yj1doy0RxzzvKmL91uVamUjFD4vp
	d7yhoG/zDwzF9N+EBklpWpLHtowJwQGn5b7IAt/L6Qie3aDBc7hVuwhXvTrx0k3J
	Oko+ZokHmcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FDE0842D;
	Thu, 14 Jun 2012 13:22:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB945842C; Thu, 14 Jun 2012
 13:22:18 -0400 (EDT)
In-Reply-To: <m2sjdynqlf.fsf@igel.home> (Andreas Schwab's message of "Thu, 14
 Jun 2012 12:19:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E896202-B645-11E1-944A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200022>

Andreas Schwab <schwab@linux-m68k.org> writes:

> perryh@pluto.rain.com writes:
>
>> How do I get "git blame" to operate "as of" a particular date in
>> the past, without having to manually look up the corresponding
>> SHA1 using "git rev-list"?  For example, I can get a report as of
>> 2011-12-29 by doing something like:
>>
>>   $ git rev-list --all --date-order --format="%h %ai" .
>>   ...
>>   7c69106 2012-01-03 ...
>>   b4227af 2011-12-27 ...
>>   ...
>>
>>   $ git blame <file> b4227af
>
> You can use any rev-list option, so --until=2011-12-27 should work.

News to me.
