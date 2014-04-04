From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Fri, 04 Apr 2014 15:33:33 -0700
Message-ID: <xmqqob0gohc2.fsf@gitster.dls.corp.google.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.34477.chriscool@tuxfamily.org>
	<20140402003938.GE6851@google.com>
	<CAP8UFD1hrXDdwKokLH_j=vwWoViC9sSJHf0gTFubh-oFQao4MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 00:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWCgB-0006bJ-VM
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 00:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbaDDWdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 18:33:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024AbaDDWdg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 18:33:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9E8279158;
	Fri,  4 Apr 2014 18:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mW4ADyFxf5T3Hi3AGCM2UYTDC7E=; b=JCcUTo
	wb2szKgyCXjgRMS5N9q0Adl+m9fT4Tba63l47eXz5fgxEfYpqauNrACnwMTr4NSz
	5DGA2Uab5fLvOgVSRZtOMvb6DNHtWlPrTja/FSgWzxPbtRONcOCooHGMeTjyqtXI
	LpcvPbcbRCjIfW/uZKSIge51SvKq90SPU8enM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sPlU5cGMM0/WAslGODMvCbBlHecBzpeu
	jZwwMYJDVk0fJ4m86r/P0XJIoWSPIBwNcGHBVpR8OswM/UVCwmOiw2iFMXny9b34
	n25c5jpEEEYXNkRHfUnWe7/mQfmB3WJs1eEUVfnSFhykcSHe+giPsDWIG8WY3RW4
	FZxMc3eRvaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A4F79157;
	Fri,  4 Apr 2014 18:33:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0595379151;
	Fri,  4 Apr 2014 18:33:34 -0400 (EDT)
In-Reply-To: <CAP8UFD1hrXDdwKokLH_j=vwWoViC9sSJHf0gTFubh-oFQao4MA@mail.gmail.com>
	(Christian Couder's message of "Wed, 2 Apr 2014 08:01:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 288EEBAE-BC49-11E3-A874-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245775>

Christian Couder <christian.couder@gmail.com> writes:

> "The following features are planned but not yet implemented:
>         - add more tests related to commands
>         - add examples in documentation
>         - integration with "git commit""

I was planning to merge the series to 'next', but perhaps we should
wait at least for the first two items (I do not think the third one
is necessary to block the series).

>>> +By default, a 'token=value' or 'token:value' argument will be added
>>> +only if
>>
>> Why support both '=' and ':'?  Using just one would make it easier to
>> grep through scripts to see who is adding signoffs.
>
> That was already discussed previously.

I do recall it was discussed previously, but given that a new reader
posed the same question, I am not sure if the end result in this
patch under discussion sufficiently answers the question in a
satisfactory way.

Thanks.
