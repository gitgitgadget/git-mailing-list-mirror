From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Alphabetize the fast-import options, following a
 suggestion on the list.
Date: Sat, 05 Jan 2013 23:12:25 -0800
Message-ID: <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 08:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrkUP-0008H9-0A
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 08:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab3AFHM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 02:12:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3AFHM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 02:12:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9466A76A1;
	Sun,  6 Jan 2013 02:12:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/U6zw38xX3ca8Wida/ZNLqhWoFE=; b=P1FC3b
	zQvI7AZ31EQvUpHHTrJFpQvoM5gIfz4o+riMK5OrXIgsvF43VndLI3CRbfoXwOw/
	I9TFlpLhxFDHDnMKMQu9dE25MxBUa1ghcY2k7N+lwHNnt1ZMqrSRHNRzkw8waRp6
	r6yjtITYiJxHPDt/IqMnNVKaOnFhUiIAFKV3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEeV2oKYo6ukRzNdgb9FxL3q8wxSI2Nl
	mTD1R9GZemnpOMro1b31AnIrglHaVUOSJok2x+6VHKk9eVhEfpDoXKI54NEYmFBd
	etB02WkZ5fmiNhoKmZugEXb/pY78itv2xKaJaixKLHy0W15PXLqmzjKxXRK0BzLp
	9eepqfFj30w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8720676A0;
	Sun,  6 Jan 2013 02:12:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13946769F; Sun,  6 Jan 2013
 02:12:26 -0500 (EST)
In-Reply-To: <20130105231151.GD3247@elie.Belkin> (Jonathan Nieder's message
 of "Sat, 5 Jan 2013 15:11:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D2AFE8A-57D0-11E2-AF59-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212782>

Jonathan Nieder <jrnieder@gmail.com> writes:

> My knee-jerk response was "If the options are currently organized logically,
> wouldn't it be more appropriate to add a sub-heading for each group of options
> and alphabetize only within the subgroups?"
>
> But in fact the current options list doesn't seem to be well organized at all.
> What do you think would be a logical way to group these?
>
>  Features of input syntax
>
> 	--date-format
> 	--done
>
>  Verbosity
>
> 	--quiet
> 	--stats
>
>  Marks handling (checkpoint/restore)
>
> 	--import-marks
> 	--import-marks-if-exists
> 	--export-marks
> 	--relative-marks
>
>  Semantics of execution
>
> 	--dry-run
> 	--force
> 	--cat-blob-fd
> 	--export-pack-edges
>
>  Tuning
>
> 	--active-branches
> 	--max-pack-size
> 	--big-file-threshold
> 	--depth

Sounds sensible.
