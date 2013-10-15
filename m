From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] np/pack-v4 updates
Date: Tue, 15 Oct 2013 14:45:15 -0700
Message-ID: <xmqqvc0yciok.fsf@gitster.dls.corp.google.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
	<alpine.LFD.2.03.1309211205550.312@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 23:45:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCQf-0000cC-CC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 23:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933768Ab3JOVpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 17:45:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759432Ab3JOVpU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Oct 2013 17:45:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1B4E4A3EE;
	Tue, 15 Oct 2013 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2HnynffZjrxc
	0fBY5do2u6z922w=; b=XOadTEcGl7/FQDhkIF6/W7nIpN1sbafcsPpPmywsPvQq
	mMJ+oelQ6/Xdyqi5J9xryq+iE1AUhlIHoBFJ/15fUqc5S/4qSeiuobOpl0ZasjHj
	dkBaOnV0wPzyoLsthu5JTHH6uMZv/0gX6zJTaXG5XOkXdjMgzVVT8oPSJHVwV1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=J2lJFJ
	5d4aynNsPkFvoKpF1vroRQEGxoUuM3+9BoSm9X+GNWieGRl5c8pFEADaXHZGtQhE
	AngirgbdQw+7HJEJaYv03LkYL92YbM25k3Hol4O8zs2T3FHue9yXE6VbmaP+izuo
	h1QqYquytd36Yuchk0L+GJ526+RdCU7vuHCPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C57E44A3ED;
	Tue, 15 Oct 2013 21:45:17 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23F064A3EA;
	Tue, 15 Oct 2013 21:45:17 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309211205550.312@syhkavp.arg> (Nicolas Pitre's
	message of "Sat, 21 Sep 2013 12:07:42 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14A68B34-35E3-11E3-B5AD-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236199>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Sat, 21 Sep 2013, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> This contains many bug fixes or cleanups. Also you can now run the
>> test suite with v4 by setting GIT_TEST_OPTS=3D--packv4. The test sui=
te
>> passes now. pack size limit is not officially not supported with v4.
>> index-pack also learns to convert appended trees to v4 for completin=
g
>> thin packs (still need to convert commits though)
>>=20
>> PS. Nico do you still take patches and then send pull requests to
>> Junio occasionally, or should I start to CC Junio?
>
> I'm still willing to act as the middle man if that suits everybody. =20
> That gives me the opportunity to review those patches and stay minima=
lly=20
> involved.

Your reviews in this area are greatly appreciated.
