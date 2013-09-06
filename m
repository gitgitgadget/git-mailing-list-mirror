From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3] check-ignore: Add option to ignore index contents
Date: Fri, 06 Sep 2013 09:30:04 -0700
Message-ID: <xmqqmwnpzzeb.fsf@gitster.dls.corp.google.com>
References: <20130905160801.GA22710@opensourcesolutions.co.uk>
	<xmqqbo46hpk7.fsf@gitster.dls.corp.google.com>
	<20130906055955.GA12622@opensourcesolutions.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Dave Williams <dave@opensourcesolutions.co.uk>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHyvN-0008Hk-6e
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab3IFQaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:30:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756575Ab3IFQaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 12:30:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B383D5A0;
	Fri,  6 Sep 2013 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jz3wdXc3rdXux2BOphjII5nNKzk=; b=cBpJlq
	yCHeLxMXsCcscIZJz6BW6Xxk4qSQ+WRw2mPHHUmApE4NffK8r4avpngav13oufR/
	OcL21aeii1aqkmvG/00y6sTBucyhhwCW4pzTXid9OGABiNK0FrH3sTEVYudn9+Ch
	XshYaMnK7ZqihHnOc3Vb4cg8rAJWebHea9zrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sjznSIzJNVdKVFd0Sm3Ro/x32rIlTQkU
	BsNwI9s77ii1Avdj3q+Fmml7zF58J0/HUGBaiKeZDvWcuYvDAiYTCg+HOqchaBH2
	ckXA4Z+KBilwK18NUpObHLRmbrzgnKHYYRBINlo411g4B+3Wswltoq6S6vDXr6us
	Op5g5R0FCpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB3833D59E;
	Fri,  6 Sep 2013 16:30:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42BCC3D57F;
	Fri,  6 Sep 2013 16:30:08 +0000 (UTC)
In-Reply-To: <20130906055955.GA12622@opensourcesolutions.co.uk> (Dave
	Williams's message of "Fri, 6 Sep 2013 06:59:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98294A82-1711-11E3-8E52-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234058>

Dave Williams <dave@opensourcesolutions.co.uk> writes:

> On 15:27, Thu 05 Sep 13, Junio C Hamano wrote:
>> Now the long option name is "--no-index", it makes me wonder if "-i"
>> is a good synonym for it, and the longer I stare at it, the more
>> certain I become convinced that it is a bad choice.
>> 
> I had originally called it "--ignore-index" at which point "-i" made
> more sense!

I know, but with --no-index it no longer does.
