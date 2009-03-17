From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default, was Re: What's cooking in git.git (Mar 2009, #04;
 Sat, 14)
Date: Tue, 17 Mar 2009 16:47:20 -0700
Message-ID: <7vab7jpv93.fsf@gitster.siamese.dyndns.org>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903171125420.6393@intel-tinevez-2-302>
 <20090318063053.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0903172350270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 00:49:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljj1q-0001oi-Us
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 00:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZCQXr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 19:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbZCQXr2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 19:47:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbZCQXr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 19:47:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A9E37E9B;
	Tue, 17 Mar 2009 19:47:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 29C4E7E99; Tue,
 17 Mar 2009 19:47:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903172350270.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 17 Mar 2009 23:53:38 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7E8EEEA-134D-11DE-9033-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113539>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 18 Mar 2009, Nanako Shiraishi wrote:
>
>> Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> 
>> > On Sat, 14 Mar 2009, Junio C Hamano wrote:
>> >
>> >> * fg/push-default (Wed Mar 11 23:01:45 2009 +0100) 1 commit
>> >>  - New config push.default to decide default behavior for push
>> >> 
>> >> Replaced the old series with the first step to allow a smooth 
>> >> transition. Some might argue that this should not give any warning 
>> >> but just give users this new configuration to play with first, and 
>> >> after we know we are going to switch default some day, start the 
>> >> warning.
>> >
>> > IIRC Steffen posted a patch series earlier, where he initialized 
>> > remote.origin.push upon clone (I am not sure if he provided a 
>> > corresponding patch for checkout --track), but personally, I think 
>> > that would be nicer than having a push.default.
>> 
>> Isn't recent trend to avoid such inconsistency between behavior in an 
>> existing repository and behavior in a newly created repository? For 
>> example, Jeff calls such inconsistency in
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/100339/focus=100433
>> 
>> as "this breaks in my repo, but when I make a test repo it works". Junio 
>> even called it 'madness' (^_^;)
>
> My point is that it is _not_ an inconsistency.
>
> It has a default setting.  One that already is well established.  Push the 
> matching refs.
>
> But you can override it by setting the config variable.  Which is also 
> well established.
>
> The only thing Steffen's patches would have changed would be to set the 
> default differently now.
>
> Which is not that much of a 'madness'.
>
> Especially if you think about changing the default, which _will_ make for 
> angry users ("why did you change the default?  I _liked_ it!  Please 
> revert _now_!").

I cloned my old project to my new machine with a recent git and it behaves
differently.  Why did you change the default "git clone" creates, without
telling me?

Sounds like a huge inconsistency to me.
