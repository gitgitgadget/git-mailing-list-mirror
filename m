From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule 
 working directory in git gui and gitk
Date: Wed, 06 Jan 2010 09:55:38 -0800
Message-ID: <7vljgbw21x.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
 <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
 <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
 <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org>
 <4B4498BC.5040400@web.de> <7vbph7181x.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSa79-0007Wk-3j
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485Ab0AFR4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426Ab0AFR4F
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:56:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410Ab0AFR4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:56:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0AD18E0DF;
	Wed,  6 Jan 2010 12:55:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iKhY8eAxe/aPjTqb/8leRhlVfyg=; b=hNdbju
	0JWSbb8yKP6P4Dq45KkCc6vxLQVVWnVJ16/gqloaTj7cZys/Er0MqCjF8vkch1PC
	YqEWpItxVrWcxySjCS+1qoGgz/9QagjmxiH8UmEOCB9m1WhOMQ6UtJgjtmz/3BpV
	Gi/mPdT2n8qiqIGw7y2xVbqtdD7DyyvQGUzWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b/Sk8Qxj4/qygWcIMk7wlvo/H/2735TQ
	/YvIDH+H+aYIcYKPeUT/T6UVG2UI/rN13H7yzGzQMP6hMsI9NVxVbVzS8CVhjqMB
	8B+fm7V8mUnZHznOVqyrO7wfh7LHmhuAC0woe8L1JTV8TKL37xOT/vrjdewx5KrX
	2y5Z8FOh158=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D2598E0DA;
	Wed,  6 Jan 2010 12:55:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67A7B8E0D4; Wed,  6 Jan
 2010 12:55:39 -0500 (EST)
In-Reply-To: <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu\, 7 Jan 2010 00\:23\:35 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B990CC58-FAEC-11DE-A5B1-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136279>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>
>> > Am 06.01.2010 02:04, schrieb Junio C Hamano:
>>  >> After all we _were_ in agreement.  We both think the user should be told
>>  >> about untracked files in submodule directory when inspecting the status to
>>  >> make a commit in the superproject.
>>  >
>>  > Thanks. So i'll take a closer look at the diff core (but i suspect i'll
>>  > need some time until i can come up with some patches because i don't know
>>  > this part of git very well).
>>
>>
>> I don't see a direct connection between "the user should be told about
>>  untracked in the submodule before committing" and diffcore.  It is just
>>  the matter of "git status" and "git commit" running another instance of
>>  "git status" via run_command() interface in the submodule directory, no?
>
> You would need to rewrite file paths so that files in submodules are
> also relative to the same directory as files in supermodule (I tried
> to do that with GIT_WORK_TREE and needed to change a bit). Or you
> could show each "git status" output separately, which does not look as
> nice as the former in my opinion.

You could show output separately if you want, but I think that is a
separate issue.

I was envisioning that the "git status" in submodule will be run with its
recent --porcelain option, and "git status" or "git commit" would read it
to postprocess and incorporate into its own output.
