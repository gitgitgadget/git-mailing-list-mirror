From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 07:50:49 -0700
Message-ID: <7vehr0c852.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
 <201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
 <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
 <7vehr1dl2z.fsf@alter.siamese.dyndns.org> <4FA307C5.102@palm.com>
 <4FA3090D.5080406@palm.com> <4FA32A6A.4070007@blizzard.com>
 <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
 <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
 <7vmx5ocyc3.fsf@alter.siamese.dyndns.org>
 <1336126182.3490.28.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>,
	Nathan Gray <n8gray@n8gray.org>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri May 04 16:51:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQJqT-00008G-4W
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 16:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab2EDOux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 10:50:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650Ab2EDOuw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 10:50:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 424E77446;
	Fri,  4 May 2012 10:50:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=00toAsE362wN
	8o35JPrHq6X4KdA=; b=hn/ZynZ6Ai3RSxtE9tQj6N6YLR+Jr6ofCFkttH0AO/tA
	H/vZAgYG1nIzWHipkxCvfatR0i0A7aCP4t4QTM3UBGoz9T5Svqisv+Uc6hOSWrbb
	eXI91MX2CKjMXnp7sjKryVacxbiOi/lWZWvQfPpOZE55JA5+Taw4oMb2tDDxv9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G5vk+k
	xl+BkauR2r6cyFVbo/lRGTxmbjq7dBI4c2f4zSesOxs4iscu76X26/q4qyLcnZVm
	s1EKc158uKwBtouNTWrgDUc2hulZYt8XSP3kAzYqgcdQ1KVQNLr+HQhfOf6AFPbT
	kENQUMkMG55fqJshlvNSbGgaIaFPMMimL4bCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A407445;
	Fri,  4 May 2012 10:50:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D9B67444; Fri,  4 May 2012
 10:50:50 -0400 (EDT)
In-Reply-To: <1336126182.3490.28.camel@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 04 May 2012 12:09:42
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A83ED60-95F8-11E1-BB0A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197025>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Thu, 2012-05-03 at 22:25 -0700, Junio C Hamano wrote:
>> Michael Witten <mfwitten@gmail.com> writes:
>>=20
>> > As for a seemingly conservative suggestion, how about using a litt=
le
>> > more structural white space:
>> >
>> >   To $uri_for_central_repo
>> >    ! [rejected]        HEAD -> feature_0 (non-fast-forward)
>> >
>> >   error: failed to push some refs to '$uri_for_central_repo'
>> >
>> >   To prevent you from losing history, non-fast-forward updates wer=
e rejected
>> >   Merge the remote changes (e.g. 'git pull') before pushing again.=
  See the
>> >   'Note about fast-forwards' section of 'git push --help' for deta=
ils.
>> >
>> > Alas! Error output like this is constructed in the code in a way t=
hat
>> > potentially makes adding such white space non-trivial.
>> >
>> > Perhaps the error message system needs an overhall; rather than sp=
itting
>> > out error messages from anywhere, they ought to be corralled and c=
ollated
>> > by a dedicated subsystem.
>>=20
>> Didn't somebody recently rework these messages quite extensively?
>
> If you're thinking of me,...

No, I was referring to f25950f (push: Provide situational hints for
non-fast-forward errors, 2012-03-20).
