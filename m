From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header
 files
Date: Fri, 19 Aug 2011 15:42:46 -0700
Message-ID: <7vk4a910rd.fsf@alter.siamese.dyndns.org>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com>
 <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com>
 <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com>
 <201108200012.17580.trast@student.ethz.ch>
 <6LbwaepC5kIygT8uWl1Wf2A7S_AD1YkTya7FLCpDK4LOS7CNxjOveFLpzZtHv0dg_JJ8l78oW6XVugLUDAHkvBFItwH2yzYH6BgRAAZkFuM@cipher.nrlssc.navy.mil> <CAGDPfJpSVknybUjUsHkb1Mb8_SqQxJB2idRTxxfsT8eRSA91CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	David Aguilar <davvid@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Sorin Sbarnea <sorin.sbarnea@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 00:42:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXmA-0004M2-T5
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1HSWmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 18:42:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab1HSWmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 18:42:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E07B4C01;
	Fri, 19 Aug 2011 18:42:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EWLGAAToxP1d
	TrO7H3aCePWR4u4=; b=BHbox2+j/WLCnHI+C1SJzJ6b6mmL+AwFlmQVNuSAB9IK
	I3fZuVoBU9xoOMTvGK6DM49CTbLI0nlpVncpm6q5EGs/kvJCGBcAuzpzcwNVTtJx
	jqjp1G6/I/mz4nVkWY29n1+cWwwLBjVzvnLAgglD6qB4ZU7XapmKcXVz5NYwiuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i87Vvr
	czosKkf9HSAro13IwirrSLU6cZylCAfCkHWGN9RQmzTBSISwNcp/fzSWqj04jswD
	aPjRxhMmeq9wxr+NaEz+Z+gKKu46sDOHXkyLTTEqha4qBkWY1CwgaCVlviOnR07v
	1rJ5MFtl8SnOgrkMQ58CLyZdZJRfblm4ms1FQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 638D74C00;
	Fri, 19 Aug 2011 18:42:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E31EA4BFF; Fri, 19 Aug 2011
 18:42:47 -0400 (EDT)
In-Reply-To: <CAGDPfJpSVknybUjUsHkb1Mb8_SqQxJB2idRTxxfsT8eRSA91CQ@mail.gmail.com> (Sorin
 Sbarnea's message of "Fri, 19 Aug 2011 23:27:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FFB528E-CAB4-11E0-871E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179738>

Sorin Sbarnea <sorin.sbarnea@gmail.com> writes:

> On Fri, Aug 19, 2011 at 23:19, Brandon Casey
>> Probably MakeMaker.
>>
>> Setting NO_PERL_MAKEMAKER may help:
>>
>> =C2=A0 rm perl/perl.mak
>> =C2=A0 make NO_PERL_MAKEMAKER=3D1
>>
> I confirm that this workaround solved the problem. Now the question i=
s
> what should be changed so git will be installed (and build) without
> problems by homebrew?

If the user's distro does not have packaged makemaker, or if the user
chooses not to install it, then the build procedure of git can be told =
to
avoid using it, which is what you did. So there is nothing to fix there=
=2E

If you are not going to tell git to avoid makemaker, in other words, if
you want to use makemaker, then installing it before starting the build
procedure would help, too. But that is outside the scope of git project=
=2E

Please do not top post.
