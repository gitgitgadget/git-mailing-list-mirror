From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Mon, 22 Sep 2014 10:58:01 -0700
Message-ID: <xmqqbnq7leqe.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
	<xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
	<20140615102736.GA11798@redhat.com>
	<xmqqy4wwraoz.fsf@gitster.dls.corp.google.com>
	<20140618030903.GA19593@redhat.com>
	<CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
	<xmqq38f2jed3.fsf@gitster.dls.corp.google.com>
	<20140922140144.GA9769@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW7sL-0006IP-5K
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 19:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbaIVR6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 13:58:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55030 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbaIVR6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 13:58:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A06763C850;
	Mon, 22 Sep 2014 13:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uokxx3Da5v9Rq9+JqxcmNLFgduY=; b=DgPVFY
	CD/I9oDhlDrh3ejLaKb0agODLB1bBQuT08dyonPHCRWLKsmnxMnBjYk5uDhblEBt
	FzKeqpl9xzdJhV35EZ7n/QvoF4ba6iIeH7PDSCpR84d+j9bYP8SPzSgPA07FLWhP
	2/JMOmfsde4fu5Wlr7pOPbn2P7nLV1r7z2jzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GawRnPZPdBRvSEpCRbW2o1VJHVwSlJJG
	F0mI+JaX/SNVK1+ZW4abgXqQtUG3CwS4DCN8daylSYwSViXvVmsT8qXsDK6IiCDF
	4cKOtTpkIXGz2PHVpjgBVcCF1VuTW2Fmfpntu9EPs0HJSaewX0gz8IstPA7kyW2a
	U1OEzwAXNAY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 970093C84E;
	Mon, 22 Sep 2014 13:58:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDAB03C84A;
	Mon, 22 Sep 2014 13:58:04 -0400 (EDT)
In-Reply-To: <20140922140144.GA9769@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 22 Sep 2014 17:01:44 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00849B26-4282-11E4-A14A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257373>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Hi Junio, Christian,
> it's been a while.
> I see that the work on trailers is going on.
> I tried going over the documentation but I could not figure
> out how would one implement multiple signatures using the
> trailers mechanism.

Good.  Christian has been rerolling the series numerous times but he
has been working without getting much input from people who would
envision using the mechanism themselves (and my comments on the
series do not count because I am not as one of them).

Please bombard us with questions and usability improvement
suggestions ;-)
