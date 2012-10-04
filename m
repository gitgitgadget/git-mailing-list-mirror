From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --amen
Date: Thu, 04 Oct 2012 09:52:43 -0700
Message-ID: <7v626q18o4.fsf@alter.siamese.dyndns.org>
References: <0d559e3191a392841124d96870a67735@rom1v.com>
 <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
 <ace0aa63d5e822c6cdd5d9a3d20bd675@rom1v.com>
 <CABPQNSYZkAax1iav_qS=0j8=XNDHPsWH_V4BMkpQi63iLb1rtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Romain_Vimont_=28=C2=AEom=29?= <rom@rom1v.com>,
	Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 05 00:49:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtds-00033L-F2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867Ab2JDQwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 12:52:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774Ab2JDQwp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2012 12:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7754D8CAC;
	Thu,  4 Oct 2012 12:52:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DgdzFHfuc/5i
	LcK9zJ6tXFyao+g=; b=Tu6AeD/CXm61lw7OQ3l9LN9YVO4FmGu7Qdk+hodCnth6
	/nMf+7CKMRGA9D1RmpcJBnWNbJU5/FtB0OqomwvMwTBhylR0KrxSaSsiZZNtRSvB
	BXNRKnXG8P2yAo2DW9Fx7KzwXL5q2gM5Z6d4yqE90oCnqGL3M6Blisc5jH3RMVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dmTLH0
	kHYabjE5UIyU+Z7QMn2sMJhydKGJLbQv0GIVUbsGegS/qr/52lYmf9uGQ3lWun0l
	WyuEeLFNrUJD/ERZOCEtS+h4Erd5rYy0g0i7dynrEEIq2OSN6jm+DKctvPMSM4o/
	EplnbGPuZL7yhhTJiIxrtYmjhrbSlzik/2YKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64E3F8CAB;
	Thu,  4 Oct 2012 12:52:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D60D58CAA; Thu,  4 Oct 2012
 12:52:44 -0400 (EDT)
In-Reply-To: <CABPQNSYZkAax1iav_qS=0j8=XNDHPsWH_V4BMkpQi63iLb1rtQ@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 4 Oct 2012 16:57:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB5C8372-0E43-11E2-9752-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207027>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Oct 4, 2012 at 4:38 PM, Romain Vimont (=C2=AEom) <rom@rom1v.c=
om> wrote:
>> Great !
>> Thank you for your answer ;-)
>>
>> It does not seem to work with git diff:
>> git diff --cache     #missing d
>> git diff --cumulativ #missing e
>
> This is because git-diff doesn't yet use the parse-options API,...

That is more like "it predates parse-options".
