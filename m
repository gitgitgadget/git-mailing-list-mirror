From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.7.7.5
Date: Mon, 19 Dec 2011 12:22:36 -0800
Message-ID: <7vbor4mhv7.fsf@alter.siamese.dyndns.org>
References: <20111216105757.GA11174@elie.hsd1.il.comcast.net>
 <201112191041.07629.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 21:22:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcjjP-00056f-IM
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 21:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1LSUWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 15:22:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752930Ab1LSUWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 15:22:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FE44513D;
	Mon, 19 Dec 2011 15:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V3qp7dK4HD4IOaSugX+kZMBq2ek=; b=iibDZ+
	Co8bmorSd/UCXItAgdfaSo+RynLlOZFPh66pmkIJWW853F8lNWOhJalAcxgv0bpm
	GEShHiVZnz09+qoweqytEasVgddBaZYP0Xp+21brltqIjveQyQzYkFjuUPnATSso
	DEU95zc1dBpvk4I+XxUGvcscU99WwPAyFnrzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VTRe0ca1GZ88CgIUhx53mF7twG4JE6yf
	EigK4t3kM8+0zhwKN74MG1s6YBVCGX90Jv+kVe0T6DfOJW0IFIpSVTGLyvsF/Bq5
	7W1uh5xhQsJG+9sWFqjaPIKhsw7iWVTPFQs8Url552cSIMT5stVfLlOWEvad3jhr
	gWZ8WhNP/ek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16FA8513C;
	Mon, 19 Dec 2011 15:22:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FA6F513B; Mon, 19 Dec 2011
 15:22:37 -0500 (EST)
In-Reply-To: <201112191041.07629.thomas.jarosch@intra2net.com> (Thomas
 Jarosch's message of "Mon, 19 Dec 2011 10:41:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3172CCC6-2A7F-11E1-8EC5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187469>

Thomas Jarosch <thomas.jarosch@intra2net.com> writes:

> On Friday, 16. December 2011 11:57:58 Jonathan Nieder wrote:
>> I noticed that v1.7.7.5 was tagged a few days ago (b36dcd72), but
>> there is no corresponding tarball at
>> 
>>  http://code.google.com/p/git-core/downloads/list
>> 
>> Will there be an official tarball?
>> 
>> I don't mind either way, but it would be useful to know whether
>> distributors should make their own or just wait.
>
> Looks like a bug, the front page of "git-scm.com" also shows 1.7.7.5
> as latest stable release and leads to a dead link.

There actually is no bug; I just haven't got around to generating signed
tarballs yet.

I tend to agree that after 1.7.8 was released, showing 1.7.7.5 as the
latest stable indeed a bug (1.7.8 is still the latest stable and the next
latest stable will be 1.7.8.1), but that site is not under my direct
control, so...
