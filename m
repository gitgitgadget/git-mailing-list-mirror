From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Fri, 25 Jan 2013 16:11:46 -0800
Message-ID: <7v38xo3irh.fsf@alter.siamese.dyndns.org>
References: <20130106120917.GC22081@elie.Belkin>
 <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com>
 <FBDECCA565D94DF9838DD81FE2E2543A@black>
 <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com>
 <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com>
 <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com>
 <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk>
 <20130120101007.GD16339@elie.Belkin> <50FEDB08.6030901@ramsay1.demon.co.uk>
 <51031C43.5030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 01:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TytNU-00078d-Hs
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 01:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab3AZALv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 19:11:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab3AZALt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 19:11:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA2E4BF88;
	Fri, 25 Jan 2013 19:11:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HmUK2VdGXtbW0867ZB5zxTbNYfY=; b=C1vlE7
	fOCmYSScPxA3Q+IVdloE/7rFghx6xbAH5Zlxzcr7OHipWNwIfPCosDB+8j9NdCGM
	DwqSZMDU/piVK00MW3c+U9gHlEKKZ+Ljd8GTjKSiS1DocS88FpY+1KCl5kgNHd62
	MCRxmtdUmO4QKb6UbjEac4vMV/i3wQbPwpBho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PD8xfmILRIawJ+oldwcPMjfkOrOWBQLN
	axkEZXlFX5/51M0qbz2EzxgaEYWG++aRO7qR8vpcGjx8QLGRlzrMK2xOLLae/jTJ
	mf22a3MhYU+E1jG4FSUcaUvxkVjIuJ4p4vMEpbnMYf3seD0X2pEP5L2dtZd04Esv
	oiNZeRbG+xM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEA04BF87;
	Fri, 25 Jan 2013 19:11:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C5B5BF85; Fri, 25 Jan 2013
 19:11:48 -0500 (EST)
In-Reply-To: <51031C43.5030307@gmail.com> (Mark Levedahl's message of "Fri,
 25 Jan 2013 18:58:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA00DC68-674C-11E2-A629-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214597>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Cygwin and Windows should be treated as completely separate platforms:
> if __CYGWIN__ is defined, do one thing, if not, go ahead and check
> WIN32, but the WIN32 macro should never be tested once we know the
> platform is CYGWIN - these really are different platforms (if you are
> unsure of this, consider that Cygwin includes a cross-compiler to
> target native Win32 as the Cygwin maintainers recognized the platforms
> are different).

Not disagreeing with your conclusion (they should be treated as
different), why does it define WIN32 in the first place?

Perhaps we would want

	#ifdef __CYGWIN__
        #undef WIN32
        #endif

very early in some include file before nothing else is included?

Just being curious.
