From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Wed, 13 Jun 2012 10:19:54 -0700
Message-ID: <7v8vfri0xx.fsf@alter.siamese.dyndns.org>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
 <CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
 <7vbokwmifp.fsf@alter.siamese.dyndns.org>
 <CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
 <7vmx4baaqc.fsf@alter.siamese.dyndns.org>
 <CAMP44s2US+PoxfboZSML84GEvUwiHV4eQBOQSp6zhruT8xrKdg@mail.gmail.com>
 <7v7gvdaogr.fsf@alter.siamese.dyndns.org>
 <CAMP44s1SOOBHRD7=u78S0dyRMdY0Q=zzkULxoz72ZzBaGC8Fyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:20:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerEf-0003Ye-W1
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 19:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab2FMRT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 13:19:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab2FMRT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 13:19:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 222218097;
	Wed, 13 Jun 2012 13:19:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xtOAMFYPmAzcpPiOLJlCMxZ2Dk4=; b=sorNnF
	KTsZsOiRhHAXq/nLVsJVITvhpSikIQAjql1Rm/Cg/V+3O5u92+lFJrfMQvly68kA
	YSINahR5zpgbX/CiPKSLRuWC4H/2HquBoPj5bgUxhN0MBa+vtP/pFKgxMaAoiu9I
	v9sChxc82D3DcCQY2Z2Jef8WmFxF/h+PxRVCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XdlFPoKo9Z4byujkTnMoRftpoAXdWtNW
	1teX2GQaTfNTdzK4O+t3VgCfeu/3obHWMs1nc8LTfU0/wJBwydd9wr6QO8Aepo4n
	Lt8Jfa7VU+GR2G1Db+G4SwQaDbbj3cD2uWb4jVJTdKGpsATEDXowISJiPrVnjrc7
	iKc2oGBysvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18F2D8096;
	Wed, 13 Jun 2012 13:19:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93CAB8095; Wed, 13 Jun 2012
 13:19:55 -0400 (EDT)
In-Reply-To: <CAMP44s1SOOBHRD7=u78S0dyRMdY0Q=zzkULxoz72ZzBaGC8Fyg@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 13 Jun 2012 16:55:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEAC9F0A-B57B-11E1-9A89-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199907>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Jun 11, 2012 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> You say I'm being irresponsible, I say you are being preoccupied by a
>>> theoretical problem that will not occur, and would not cause any
>>> problems if it does.
>>
>> See how the two implementations are different
>
> They are not.
>
> http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/completion/git-completion.bash;h=13690eaecb4d8fafa67b79d33e804e6f8c64d742;hb=refs/heads/pu#l37
>
> http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/completion/git-prompt.sh;h=29b1ec9eb1797e0f2c3c9f7067222432150ba85f;hb=refs/heads/pu#l54
>
> Where is the difference?

Look at your patch that introduces the separate file af31a45
(completion: split __git_ps1 into a separate script, 2012-05-22)
instead.  The extra $GIT_DIR one in git-completion.sh bba88ea
(completion: respect $GIT_DIR, 2012-05-09) is on another topic that
is stalled and waiting for a reroll.

And your message brings things back to my exact point. 

Unlike the other topic, the topic fc/git-prompt-script we have been
discussing is almost ready except for this nit.  If we make it
graduate to 'master' without doing anything about the other commit,
we will have two different versions from day one.

And the worst part of the story is that you are not just placing the
burden of noticing and having to worry about these things on other
people (in this case, me), but are actively sabotaging the effort to
make future mistakes less likely to happen by endlessly bitching and
refusing to admit that there is a problem.  It seems that it is too
difficult for you to admit that you were wrong and say "Yes there is
a problem, and among the three approaches you suggested, this is the
least intrusive one" or "Yes there is a problem, but I do not like
any of the approaches you suggested, so I propose this alternative
that is much less intrusive than any of them", and until that
happens I do not see a point in talking with you at all.
