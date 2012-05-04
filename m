From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 10:39:51 -0700
Message-ID: <7vsjffalqw.fsf@alter.siamese.dyndns.org>
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
 <7vehr0c852.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>,
	Nathan Gray <n8gray@n8gray.org>,
	Illia Bobyr <ibobyr@blizzard.com>
X-From: git-owner@vger.kernel.org Fri May 04 19:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQMU2-0000Pj-Uj
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 19:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094Ab2EDRjy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 13:39:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab2EDRjx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 13:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7BD6050;
	Fri,  4 May 2012 13:39:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QKzJ6MIdD237
	LmU8F5MFrlZO9TE=; b=ZDpCRIwoHbTNalujZ5VjfwJrxJKPBivlGtVw4MLEyrzK
	JEGyW6lxGf8A73M8qnuK0S2iFDzKFI1trKewbf90kBgUuyGouZb9fNtzvGJoEyTy
	98jAn75eqMHd4P/7WXNve3WtcakixRnPTgHvG88qkfIad+HZS19Pz/YghnEMukI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c7sytZ
	x/TT0mFGHiGMDu4Fz3DbYtMXYO+zqrwnpD6p8DBzfF6NmKCW8biUPe79w1IGYaeC
	xl8VuUMa6LHonlwid9IoPw3yoFSCz8O+CTnNfv62uW3SoPsIUslNhR1HcsQTT3/8
	rEHJ+YwM5mYB77ufUXDM4+0gkvcVKCqbxerJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 048F7604F;
	Fri,  4 May 2012 13:39:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D53C604C; Fri,  4 May 2012
 13:39:52 -0400 (EDT)
In-Reply-To: <7vehr0c852.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 04 May 2012 07:50:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27942B1C-9610-11E1-98EA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197041>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>>> Didn't somebody recently rework these messages quite extensively?
>>
>> If you're thinking of me,...
>
> No, I was referring to f25950f (push: Provide situational hints for
> non-fast-forward errors, 2012-03-20).

If anybody wants to further discuss possible rephrasing of the advice
messages, please do not base your discussion without what was discussed
already in the previous round and what issues need to be taken into
account.

A good text to use as the starting point of your discussion is the advi=
ce
messages in 'master'; use c5da24a (Merge branch 'ct/advise-push-default=
',
2012-04-20) or anything more recent.  Also see

    http://thread.gmane.org/gmane.comp.version-control.git/193079

for the discussion that led to the current text.
