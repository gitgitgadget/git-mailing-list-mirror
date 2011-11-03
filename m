From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Wed, 02 Nov 2011 18:30:28 -0700
Message-ID: <7vobwugfgr.fsf@alter.siamese.dyndns.org>
References: <4E417CB4.50007@ramsay1.demon.co.uk>
 <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
 <7vpqjgyvn1.fsf@alter.siamese.dyndns.org>
 <4E68FE73.4000005@ramsay1.demon.co.uk>
 <20110908182055.GA16500@sigill.intra.peff.net>
 <4E6D089C.4090006@ramsay1.demon.co.uk>
 <CALxABCbnZp-y0Fqzoa=Ab92P+hsT7hs3nXZsnA=ph3yGfkXhdA@mail.gmail.com>
 <7vfwi7lc54.fsf@alter.siamese.dyndns.org>
 <CALxABCbKSi-aHezjyn5wJ0-BPW1PvvaC2i9VeV7yXOf4yCdx4Q@mail.gmail.com>
 <CAGdFq_h+Hpv9perLTU2rbdT6oZ3kZy22t5nghJQeEjNGvunL+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 02:30:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLm8a-0006xo-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 02:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190Ab1KCBac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 21:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793Ab1KCBab convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 21:30:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 415EC2A38;
	Wed,  2 Nov 2011 21:30:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dcXYRXHqfs+z
	rKb74Fh79ZMYoRU=; b=Bj6oYkcxdnJRyO8kjknZreAgsKOr1O1vG8bQJIpk3938
	EXkw9Khr2r8sq7qb2GDNrmWIzxwJ0UZZF0UlPvnCM82K4CGq5/JGWk28U5G9142u
	FhSKZTvQ/6kcGIHK+mLuX4FhLrfGFC3jl9/3++q6PHoFfFK47somiJdFr/+vZx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ePQzJs
	0KHx4GYy0Ru37lVLQClJufcbJObOZMiGbqh7htY2TLdFP79MMWFxxlyYFJ/u7McE
	5Mbi0nrRj30TTxMVZ/450lTu5PEDYJgdTHk73VyZIvj/ab6yltGqJZnFhpwI2OGi
	GtpXVNF2tsOHGvFElC4+xElfOK8m/ha2TKGlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3831B2A37;
	Wed,  2 Nov 2011 21:30:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7F822A36; Wed,  2 Nov 2011
 21:30:29 -0400 (EDT)
In-Reply-To: <CAGdFq_h+Hpv9perLTU2rbdT6oZ3kZy22t5nghJQeEjNGvunL+A@mail.gmail.com> (Sverre
 Rabbelier's message of "Thu, 3 Nov 2011 00:35:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A483740-05BB-11E1-A961-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184690>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> =C3=86var, this seems like something we could look at during the mini
> GitTogether in Amsterdam this Saturday, no?

Have fun.

I think I happened to hit this while testing today's 'pu' that hasn't b=
een
pushed out. The process chain looks like this:

pid  command                     stuck at
4767 sh t5800-remote-helpers.sh  wait4(-1)
 4793 git push                   read(6)
  4809 git-remote-testgit        wait4(4906)
   4906 git fast-import          wait4(4912)
    4912 git-fast-import         read(0)

lr-x------ 1 junio junio 64 Nov  2 18:21 /proc/4793/fd/6 -> pipe:[13303=
7701]
l-wx------ 1 junio junio 64 Nov  2 18:21 /proc/4793/fd/7 -> pipe:[13303=
7700]
lr-x------ 1 junio junio 64 Nov  2 18:21 /proc/4793/fd/8 -> pipe:[13303=
7701]
lr-x------ 1 junio junio 64 Nov  2 18:05 /proc/4809/fd/0 -> pipe:[13303=
7700]
l-wx------ 1 junio junio 64 Nov  2 18:05 /proc/4809/fd/1 -> pipe:[13303=
7701]
lr-x------ 1 junio junio 64 Nov  2 18:05 /proc/4906/fd/0 -> pipe:[13303=
7700]
l-wx------ 1 junio junio 64 Nov  2 18:05 /proc/4906/fd/1 -> pipe:[13303=
7701]
lr-x------ 1 junio junio 64 Nov  2 18:03 /proc/4912/fd/0 -> pipe:[13303=
7700]
l-wx------ 1 junio junio 64 Nov  2 18:03 /proc/4912/fd/1 -> pipe:[13303=
7701]

So "git push (4793)" is stuck reading from pipe:[133037701], expecting =
the
innermost "git-fast-import (4912)" to write to it via its standard outp=
ut,
but the latter is waiting to read from pipe:[133037700], hoping the for=
mer
to write to it via its fd#7.

Does this deadlock ring a bell to anybody who's involved in these
codepaths?
