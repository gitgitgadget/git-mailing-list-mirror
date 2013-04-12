From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-bzr: portable shell and utf-8 strings for Mac OS
Date: Fri, 12 Apr 2013 15:40:19 -0700
Message-ID: <7vy5cnbcfg.fsf@alter.siamese.dyndns.org>
References: <201304122318.20780.tboegi@web.de>
 <CAMP44s1UqCNKHFMcN0pJo_tJ1UeHDET7vxFJhqj8X=YibgDt0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	christophe@kn.gl, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 00:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQme0-0004GL-0N
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab3DLWkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 18:40:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120Ab3DLWkW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 18:40:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D185816A17;
	Fri, 12 Apr 2013 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=reEcjR23bhGG
	pt9ytoW4C3jF2/8=; b=yL93XyUoWjPKwtXzCyr1SzLrJKS4leVqekbAM/6E8HDN
	/eU+ceh28exOhpMDRhEnCkPBebHpzVipLji9opE0ZtuYKmpwYxBkdOx32xlL+pg3
	kPAedzVlXQHtSvMGJsURWh1tM3Y1hYERB1+Yo0EDHur6wTzsbzK7aRIJACpEogY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VN3HPd
	9agiDUCqvV2MwUiACrRWICGrRxf8IyT5zKFrH7blwml6pT6ChP0DdrWbx7mBaSmX
	k+TbaA8RkT3YpQclOTJh9r3Byg6RywpsvbTTowAKVaHNsXL3UpQirIflfyPV/Pz0
	kQF/+sY2M8GWJl04SNXzfj3e7jEqKRv7auTs4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C752916A16;
	Fri, 12 Apr 2013 22:40:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EEDC16A15; Fri, 12 Apr
 2013 22:40:21 +0000 (UTC)
In-Reply-To: <CAMP44s1UqCNKHFMcN0pJo_tJ1UeHDET7vxFJhqj8X=YibgDt0Q@mail.gmail.com> (Felipe
 Contreras's message of "Fri, 12 Apr 2013 16:27:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F543076C-A3C1-11E2-B1D0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221035>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Apr 12, 2013 at 4:18 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> Make the shell script more portable:
>> - Split export X=3DY into 2 lines
>> - Use printf instead of echo -e
>>
>> Use UTF-8 code points which are not decomposed by the filesystem:
>>  Code points like "=C3=A1" will be decomposed by Mac OS X.
>>  bzr is unable to find the file "=C3=A1" on disk.
>>  Use code points from unicode which can not be decomposed.
>>  In other words, the precompsed form use the same bytes as decompose=
d.
>
> Looks good to me.

Thanks, both. Applied.
