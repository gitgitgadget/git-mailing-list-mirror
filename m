From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] t0060: verify that basename() and dirname() work as expected
Date: Wed, 13 Jan 2016 11:43:46 -0800
Message-ID: <xmqqziw9mfil.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
	<CAO2U3QjYukb4mB414mVLX2=CxLPBnDaUyDRsfitE_bTZv8_zFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:43:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRKj-0005an-6i
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947AbcAMTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:43:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757941AbcAMTns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:43:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F03603AC4D;
	Wed, 13 Jan 2016 14:43:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBC46ovHPFegM5oqc4YxyPYZ4UA=; b=uv2HlH
	siAe8ni5XAg9YlXZ0eAL3K15VufB7KYz6SHn3CfbS1g1gp87azDcQvkty/BoPVHt
	7onMbj/LGcNWHMQcVmPq032JCD4jJoHiXpx5D/1zfr7NEuEl59i21hoTnOvlHjhp
	OyMI0U6jm7N2TS4TouPAJOZsk5hHFKZh/sFh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pkl1eGMfbBKB0zfWFqxVLlA/Da/8qN3M
	/igCRdSs8rB7IDi2vifDr5kJJnaq/a50pcobGeUoz7IGqobotsfiJG2t9CDhLCW6
	fEQtSAxzwNEM9j45/8ZWWAqqcbHIYwXgmdyH9ALigHlMz8RxhIjUi2+a2SNwFiUg
	sRJaOSuuqfM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8C993AC4C;
	Wed, 13 Jan 2016 14:43:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 70D4D3AC4B;
	Wed, 13 Jan 2016 14:43:47 -0500 (EST)
In-Reply-To: <CAO2U3QjYukb4mB414mVLX2=CxLPBnDaUyDRsfitE_bTZv8_zFQ@mail.gmail.com>
	(Michael Blume's message of "Wed, 13 Jan 2016 10:52:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6648410-BA2D-11E5-8B0A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283978>

Michael Blume <blume.mike@gmail.com> writes:

> Test fails on my Mac:
>
> expecting success: test-path-utils dirname
> error: FAIL: dirname(//) => '/' != '//'
>
> not ok 2 - dirname
> #    test-path-utils dirname

Thanks for reporting.

Ramsay gave a nice analysis at

  http://thread.gmane.org/gmane.comp.version-control.git/283928

and Dscho already is working on it, IIUC.

Thanks.
