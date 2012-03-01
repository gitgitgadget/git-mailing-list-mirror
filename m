From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 29 Feb 2012 17:05:35 -0800
Message-ID: <7vaa41qgf4.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com>
 <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Troxel <gdt@ir.bbn.com>, Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:05:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2uSt-0005JN-9E
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966143Ab2CABFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:05:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab2CABFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:05:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 981496221;
	Wed, 29 Feb 2012 20:05:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NzlmK/cP7OU3XyoDr+Yh0oTG0Lk=; b=tDeBX2
	Rj4/+ywyr6UoUejVrruyAwjF4+iPEF7np37+p6Gxfd532OkC2/bU3kO3z4iTbfG9
	62egYShZwcXxJEN1G/RNPmraX32t4M/wZdkj/+ck6wXk5rPfOAXaliZogqA65fq8
	ZttJhJPLtAweUWqqmxagq1DEYk4yRN3C8H/LA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vYKKpPXf98oIchvi7pykkUfQ8IcaJF3Y
	REQpHkMOAkUQfDffChBLVVL9oVDtW7R2kgn+DEFZuidcxN949rhw58LLUq+HJu6h
	kxHuYIOJ0A/d5soVGzbNeBLqlC2W6bmKnH85hlwkrWBUcZ9HSN6P0CvFDwVTJ7qn
	Ac2apkQYU4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0C16220;
	Wed, 29 Feb 2012 20:05:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5FF2621E; Wed, 29 Feb 2012
 20:05:36 -0500 (EST)
In-Reply-To: <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 1 Mar 2012 11:45:52 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A798B0CA-633A-11E1-AE37-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191870>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 1 March 2012 11:37, Greg Troxel <gdt@ir.bbn.com> wrote:
>>
>> Do people really think it's reasonable to use non-Free tools to develop
>> git? That seems surprising to me.
>
> Maybe not, and if that is the case I am more than happy to let this die.

I won't speculate how big or small part of the Git community you would be
repelling by using a closed/commertial offering. It may not be such a big
deal, or it may be. I simply do not know.

But we will never find out until we try. The same thing can be said for
the usefulness of having a bug tracker and feasibility of keeping it
reasonably clean and useful over time with volunteer effort.  I commend
you for finally stepping up and biting the bullet to start an experiment.

One request I may have is to give read/browse-only access to unregistered
users without any account (I hate having to maintain credentials to random
websites, and I imagine so do many other people), but I am not the target
audience, so please do not bend backwards to implement such if it is too
much trouble with the system.

Thanks.
