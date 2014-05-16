From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 18:26:35 -0700
Message-ID: <xmqqmweibjjo.fsf@gitster.dls.corp.google.com>
References: <20140514184145.GA25699@localhost.localdomain>
	<xmqqd2fghvlf.fsf@gitster.dls.corp.google.com>
	<CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com>
	<20140515050820.GA30785@localhost.localdomain>
	<alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
	<20140515184808.GA7964@localhost.localdomain>
	<CANQwDwe+GJ+yAYWdVfMaHq97zGXBoepCfUdLiaQD9LFoz3SiOA@mail.gmail.com>
	<xmqqmweiessl.fsf@gitster.dls.corp.google.com>
	<CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wagner <accounts@mwagner.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	git <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 03:26:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl6v7-0002ua-46
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 03:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaEPB0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 21:26:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60774 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbaEPB0k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2014 21:26:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A983D19808;
	Thu, 15 May 2014 21:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/LeuW9jtQuic
	hgRTT7PeCYfTKQ0=; b=V3Q3T8u5YLlx9Y1fk6z8Wz8AHLQHe6ADiEVtq7wgMl/A
	6qIw8GlaqLXP5XcGXsj6eV9RygPRPeWSZ+QEJFi3phgBrBbdXE7fmB6nRLCubFyx
	AwqxflvyeHdcheq6/75fQuabeiXJMakRl+5Ew7CZcfOLjYvxEqx4Fd8Xs86VDTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dkLwOH
	tjquYa41pA0J/uGojvgl2pX+aRpak8XISkbdoxMF1dugsxc+d/UoRP9pfUUuWEyH
	nBv7fOsif+06lKr/JM8W8e54VN6rPpjLw/IBp8sspiFZU/wrD1Gfvq6vXLeeVM6x
	PSMeQKBCWFh/aH+Ia/7a06xOYZ1oUmWc+V1TU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E98F19807;
	Thu, 15 May 2014 21:26:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D298219804;
	Thu, 15 May 2014 21:26:36 -0400 (EDT)
In-Reply-To: <CANQwDwffdbqD96OadyECFs=6WY_t+_0b63L5yAZVQ8aXrMvHHA@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 15 May 2014
 22:45:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F8DF232-DC99-11E3-B663-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249269>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On Thu, May 15, 2014 at 9:38 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>>
>>> Writing test for this would not be easy, and require some HTML
>>> parser (WWW::Mechanize, Web::Scraper, HTML::Query, pQuery,
>>> ... or low level HTML::TreeBuilder, or other low level parser).
>>
>> Hmph.  Is it more than just looking for a specific run of %xx we
>> would expect to see in the output of the tree view for a repository
>> in which there is one tree with non-ASCII name?
>
> There is if we want to check (in non-fragile way) that said
> specific run is in 'href' *attribute* of 'a' element (link target).

Correct, but is "where does it appear" the question we are
primarily interested in, wrt this breakage and its fix?

If gitweb output has some volatile parts that do not depend on the
contents of the Git test repository (e.g. showing contents of
/etc/motd, date/time of when the test was run, or the full pathname
leading to the trash directory), then preparing a tree whose name is
=C3=A4=C3=A9=C3=AC=C3=B5=C3=BB and making sure that the properly encode=
d version of =C3=A4=C3=A9=C3=AC=C3=B5=C3=BB
appears anywhere in the output may not be sufficient to validate
that we got the encoding right, as that string may appear in the
parts that are totally unrelated to the contents being shown and not
under our control.  But is that really the case?

Also we may introduce a bug and misspell the attr name and produce
an anchor element with hpef attribute with the properly encoded URL
in it, and your "parse HTML properly" approach would catch it, but
is that the kind of breakage under discussion?  You hinted at new
tests for UTF-8 encoding in the other message in the thread earlier,
and I've been assuming that we were talking about the encoding test,
not a test to catch s/href/hpef/ kind of breakage.
