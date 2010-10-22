From: Junio C Hamano <gitster@pobox.com>
Subject: Re: should Documentation/howto/setup-git-server-over-http.txt be
 marked obsolete?
Date: Fri, 22 Oct 2010 11:36:38 -0700
Message-ID: <7viq0um5vt.fsf@alter.siamese.dyndns.org>
References: <AANLkTimJe9vEUwWM482NLmfHGYjnsKD5RAryQO=Zyqjj@mail.gmail.com>
 <7vsjzyrh2w.fsf@alter.siamese.dyndns.org>
 <AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:37:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MUV-0008T7-DE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab0JVSg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:36:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0JVSgr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:36:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70F4CE12AF;
	Fri, 22 Oct 2010 14:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fxVXVKvoy1+uH5jf+qbiG4gojng=; b=fJnljD
	NTj9JTXtdEn6KCnFAIu9GpOYL8a75p3rKsi72iZxbY5L6F030MUqYsPV1YgLcmmM
	+9WHJsl8eCugQiusbkMZ6YqfdkEIjFA/P9k6gd61nok46m6MQapOy7mUJWhLJ6xb
	ZJzGGzIPvNheS6xmcMkkGEohSG3tCRaCf5zDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZDVaSI8xJmCJo6AReLIKOX+ZC7x7r3N4
	pX/suG6TvsoUb3sGs9T7gzUUlAXYfB8zqfH4RirXNnh+Pm8N9Zso5yzv9CbGHJoo
	PAyXpe6sib5uG18M1RVdlsvr9KciF1zOs2TA5Gr/iFsqPR04O71cHH7wP+kzJH06
	FWmN4mW5MPg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4799CE12AE;
	Fri, 22 Oct 2010 14:36:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 848D9E12AB; Fri, 22 Oct
 2010 14:36:39 -0400 (EDT)
In-Reply-To: <AANLkTinv3kzvtC_Pq4F0cM_JqU7-Q2a=sWs8YSxbMiPs@mail.gmail.com>
 (Sitaram Chamarty's message of "Fri\, 22 Oct 2010 19\:25\:31 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 513219A2-DE0B-11DF-8404-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159726>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>> Not everybody uses gitolite, and I do not think we have broken the dumb
>> HTTP support (however broken the original was ;-) to render the document
>> obsolete.
>
> My apologies; I didn't realise my mail would come across like that.

Oh no need for that; I didn't realise -my- response would, either ;-)

> I just followed "man git-http-backend" and it all worked.  Should there be more?

No; that would mean the next step would be (as you suggested)...

>>  - When the above two is done, insert one line "This describes an older
>>   way; see <<insert the name of the other document here>> for insn to set
>>   up an experimental smart HTTP server" at the beginning of the original
>>   document.

... this one.

I trust you can take care of the gitolite documentation side ;-)

Thanks.
