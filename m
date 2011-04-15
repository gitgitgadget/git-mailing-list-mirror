From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/resend] Documentation: update to git-merge-base --octopus
Date: Fri, 15 Apr 2011 10:18:06 -0700
Message-ID: <7v39lje8mp.fsf@alter.siamese.dyndns.org>
References: <4DA47A4D.80909@lyx.org> <20110412194558.GB1209@elie>
 <4DA80549.5040600@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:18:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAmf3-0004CK-7A
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 19:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab1DORSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 13:18:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab1DORST (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 13:18:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D81F4ED2;
	Fri, 15 Apr 2011 13:20:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PO9yaUxruj+kHb8nVY41S+orJbw=; b=Pz/Pyr
	G2hmunC2utJ/T2Mf02ikDuNq6DKEyYG7o83RKkVS5rIL2U9dFQzALiPRmENEh7by
	ZKvoUxEXokrwohicO61w9z2crCva86lDZCm6m565cvUvxYmyEYRhz3mycV8uom++
	vsf3kNsADT/PNzfFdApF7OCCNRqgFsdSANDqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sYxwLg+j5VihRF/GHRe05JsobUql26eI
	u2HiHrBDYKfcGpS53bruUD/oLtBAvVqe+9eY0HKl8ANOfqZ5vc5N+h+be3Uc0vR+
	F7YYic7n0mDN+PxmfU45RGp68IQV6hInqlFUBF7L3NnKIS8N45Kvo9ESFislnhPC
	CvDqyCriTws=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A9674ED0;
	Fri, 15 Apr 2011 13:20:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E74194ECF; Fri, 15 Apr 2011
 13:20:06 -0400 (EDT)
In-Reply-To: <4DA80549.5040600@lyx.org> (Vincent van Ravesteijn's message of
 "Fri, 15 Apr 2011 10:43:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E422D74-6784-11E0-A685-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171619>

Vincent van Ravesteijn <vfr@lyx.org> writes:

>>> +When the option `--octopus` is given, the result of `git merge-base A B C`
>>> > +will be '2', because '2' is the common ancestor of all branches.
>> 
>> Wouldn't it be easier to read if you had the option in the command line, i.e.
>> 
>>     The result of `git merge-base --octopus A B C` is '2' because...
>> 
>> without "When ... given" that now become noisewords?
>
> Yes, that's much better. I included it in the rerolled patch series.

Makes sense.  Will queue both patches.

Thanks, both.
