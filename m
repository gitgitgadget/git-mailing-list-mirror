From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8] ls-files: Add eol diagnostics
Date: Wed, 30 Dec 2015 13:43:38 -0800
Message-ID: <xmqqwprvd33p.fsf@gitster.mtv.corp.google.com>
References: <5683D49D.2010509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOX3-0005y3-OO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbbL3Vnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2015 16:43:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755202AbbL3Vnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2015 16:43:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF2F735C70;
	Wed, 30 Dec 2015 16:43:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eaD5x+9mPr1D
	lsylYKgVRTbTnLk=; b=u1AEV5+ed599SW2Q7qdNve0A4gw7ndvj5dYJHz34D4O5
	ZOrmRlNWeUfwvQY324gkWTFlSbqbDGcBjyXuE9nGJAjrYs34n+02dX4x5R++3EEu
	JeUYA6W0uomvS1LjvDypNWASo1RCto3F/hMxmwTE/zyvziuADrOLcUxiKsMg1BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hC5J4t
	h1SIyTQcxA4O1vpVp+cQew4XCLvls55+AjzlVJj/D3X5AyGvaqOehVCtRvuOA3te
	mdeMk4SUNBvd7J9irxWq+Kj+7z1EJA8x2/kvbu5ymSf3pf0+KSXflSCRU/qulZtD
	ZGVlPPDWmqo+n8B47OqI8r7f7v60dtuKQDv0E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D78AD35C6F;
	Wed, 30 Dec 2015 16:43:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C80E35C6D;
	Wed, 30 Dec 2015 16:43:39 -0500 (EST)
In-Reply-To: <5683D49D.2010509@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 30 Dec 2015 13:57:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6353B852-AF3E-11E5-A2BE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283204>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Add test cases in t0027, thanks to Junio C Hamano for the optimized
> grep-less sed expression.

Please drop this part; it is embarrassing.

You wouldn't thank all the mentors you have ever had from whom you
learned programming in your log messages, either ;-)
