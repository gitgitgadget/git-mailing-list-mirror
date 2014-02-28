From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branch Name Case Sensitivity
Date: Fri, 28 Feb 2014 15:28:58 -0800
Message-ID: <xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net> <5310959D.709@gmail.com>
	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Lee Hopkins <leerhop@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:29:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJWrd-0001Do-Px
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 00:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaB1X3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 18:29:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32999 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaB1X3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 18:29:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0DB06EC86;
	Fri, 28 Feb 2014 18:29:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Li9ECkbK41X0VeTAKRLMJXYTeuM=; b=e+fib9
	1uKAWWv+eE12rsT42AHgKC8an34HeZHFMM88gyy37mS8kGz4+d5Va6sRypwVx7W4
	s+wZXKV9ZwijO5n5rj52HeETsOQ40MCWEhnyZ7K5zL4iMmo3XoBURDdoPOqSqhZS
	MxGga6c0rOmFaV8/Zu2qwVz4moGKE28K70S2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cd39SMxKQACDSuv523DLXU2OH1cjTXTq
	1tSwBKQWoGwS9e1WJxneh0mTP4OissRsS73D0bOPqtJgJnXodA7mVpda9B5ZDYNB
	6wOMhKoYYuonxSnKhHf5aDnDowzv0T5QXo1ajnGdW2vhGVRvGTbPGCT9komDl2ah
	R4TBeGWjOvY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9984A6EC82;
	Fri, 28 Feb 2014 18:29:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D3D66EC7F;
	Fri, 28 Feb 2014 18:29:01 -0500 (EST)
In-Reply-To: <CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 1 Mar 2014 06:22:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1AF7BAF0-A0D0-11E3-9F8D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243027>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 1, 2014 at 1:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>>> If you are on a case-insensitive filesystem, or work on a cross-platform
>>>> project, ensure that you avoid ambiguous refs. Problem solved.
>>>>
>>>
>>> So its OK to lose data if you accidentally use an ambiguous ref? I
>>> cannot believe you actually meant that.
>>
>> I think he meant what he said: "you avoid ambiguous refs".  He did
>> not say "it is not Git's business to help you doing so".
>>
>> I think it is prudent to warn in the end-user facing layer (read: do
>> not touch refs.c to implement something like that) when the user
>> creates "refs/heads/Next" when there already is "refs/heads/next",
>> and I further think it would make sense to do so even on case
>> sensitive platforms.
>
> That does not help when the user creates "next" and pulls "Next" from
> elsewhere, does it?

That depends on what the project policy would be.  At that point,
that user needs to talk with the "elsewhere" person and resolve the
issue (if there is one) according to the policy of their project,
and it is not Git's business to _solve_ it for them.  Warning I
suggested was a way to help avoiding without getting in a way of
projects whose policy is to allow these.
