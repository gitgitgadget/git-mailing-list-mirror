From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sun, 11 Mar 2012 12:22:41 -0700
Message-ID: <7vzkbnvt6m.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
 <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de>
 <4F5CC08C.90703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 20:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6oLx-0001CC-JH
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 20:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab2CKTWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 15:22:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733Ab2CKTWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 15:22:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E265C678D;
	Sun, 11 Mar 2012 15:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ttC3RJiTBosJ
	J15d9+mNytdH55o=; b=En3blFM2A+0F2VxDjIKhR2RLnHH4cDTy6JQ7KmtubZFp
	d95dOwGp4N8cWO7wnPLzJvG4DuwJBlehxgtYT4vVJFMQmhb37ADrOIo5t9AGvpgt
	oKU5EEYCDs7UjkC2zqPjocrU8WslzpEzRfZZMqDIeEb67m2ZA373E/cwyc9viM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V7zLs5
	Kd8GeF1jHveHsFbtyx82QxxBDOcMo0RL+3cg9n4y5M4hgkd5Dwouztsmq7ZyExE5
	nuQqenpw08KcuoBQlbE0cx5R2TtzXWPsDILz4OLiIzEhBPQAxD0D/HPEmJXjFQ34
	GcJXHGQhxnhVMQK5VE2BtyER5D6Y4eAfFcN6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D91DB678C;
	Sun, 11 Mar 2012 15:22:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 680C9678B; Sun, 11 Mar 2012
 15:22:43 -0400 (EDT)
In-Reply-To: <4F5CC08C.90703@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Sun, 11 Mar 2012 16:11:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93687D06-6BAF-11E1-A028-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192823>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Here the results of my investigations:
> a) git-sh-i18n is used by the test suite, not git-sh-i18n.sh
>    git-sh-i18n is generated from git-sh-i18n.sh when running make

Yeah, that is the correct behaviour.

> b) When running
>    make clean && make USE_GETTEXT_SCHEME=3Dgnu && (cd t && make)
>   the log of t0204 looks like this:
> ...
> Summary: test OK,

Now, the last remaining issues appear to be these:

 * Is USE_GETTEXT_SCHEME=3Dgnu the right thing for Mac OS X?  It may
   make this test pass, but does it not break other things?  Does
   Mac OS X come with a working gettext.sh to help i18n of shell
   scripts?  Does it also give eval_gettext?

 * If so, Mac OS X users shouldn't have to say that from the command
   line of "make". Do we need a Makefile update?

 * If not, what is the appropriate value for USE_GETTEXT_SCHEME on
   Mac OS X?  If the answer is not "fallthrough", do we need a
   Makefile update?

Thanks.
