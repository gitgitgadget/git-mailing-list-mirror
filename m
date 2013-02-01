From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] fixup! fixup! fixup! Change 'git' to 'Git' whenever
 the whole system is referred to #1
Date: Fri, 01 Feb 2013 12:16:35 -0800
Message-ID: <7v622baixo.fsf@alter.siamese.dyndns.org>
References: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <242116275.1090080.1359742076320.JavaMail.ngmail@webmail18.arcor-online.net>
 <20130201194308.GC12368@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org,
	davvid@gmail.com, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 21:17:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1N2i-00084k-T2
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 21:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab3BAUQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 15:16:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757125Ab3BAUQi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 15:16:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0B17B9F4;
	Fri,  1 Feb 2013 15:16:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZXOwJfJ6BEtQuH5FZHgWW7lq2ec=; b=AT/322
	ficMgKWHQ12N+4EG53WtS0znPq+AUxAEdBWBK9MQjr2Fstezg6C+2a+6foQtX+A6
	7xsLi5izHKYfszi4fuI+ExMHB3VC2kjjH8fvvhcHadpOiTxFc5APkBS+M6ohCDzn
	PkoF+twg+nIHs/ST1AiQ5vl0+TwR3VoL3bIds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LXNyZChB0mxNuFMc2iPGMouK2i3bET0V
	28XUClOn3WPcysJpa0tIK3/6YVYzZx9QwsEBu4PWTNiYvYaC1TIsO3JRMi7HQiBh
	PnH82wBkhy+vCVx9LD6LugBq7Y43R8Eaz4vhWfqbuLrihhrEfcArsPxxRwsl9lap
	8qS0pD5V/RA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E35EEB9E6;
	Fri,  1 Feb 2013 15:16:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56D9DB958; Fri,  1 Feb 2013
 15:16:37 -0500 (EST)
In-Reply-To: <20130201194308.GC12368@google.com> (Jonathan Nieder's message
 of "Fri, 1 Feb 2013 11:43:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48124C70-6CAC-11E2-AED9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215266>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
>> index c743469..14386ed 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -187,9 +187,9 @@ print a message to stderr and exit with nonzero status.
>>  	Flags and parameters to be parsed.
>>  
>>  --resolve-git-dir <path>::
>> -	Check if <path> is a valid git-dir or a git-file pointing to a valid
>> -	git-dir. If <path> is a valid git-dir the resolved path to git-dir will
>> -	be printed.
>> +	Check if <path> is a valid `$GIT_DIR` or a gitfile pointing to a valid
>> +	`$GIT_DIR`. If <path> is a valid `$GIT_DIR` the resolved path to `$GIT_DIR`
>> +	will be printed.
>
> Hm, I don't find the old or the new version very easy to understand.  Perhaps the
> idea is something like this?
>
> 	Check if <path> is a valid git repository (.git or <project>.git
> 	directory) or "gitdir:" file.  If <path> is a "gitdir:" file
> 	then the resolved path to the corresponding real git repository
> 	will be printed.

Yeah, sounds much better.
