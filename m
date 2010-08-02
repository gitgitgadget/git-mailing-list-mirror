From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: use textconv filter for diff and blame
Date: Mon, 02 Aug 2010 12:01:31 -0700
Message-ID: <7vhbjcltys.fsf@alter.siamese.dyndns.org>
References: <1280319830-20483-1-git-send-email-Matthieu.Moy@imag.fr>
 <871valstsi.fsf@fox.patthoyts.tk> <vpq8w4tpie2.fsf@bauges.imag.fr>
 <878w4tz2hi.fsf@fox.patthoyts.tk> <vpqocdpdzgt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Clemens Buchacher <drizzd@aon.at>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:01:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og0Gr-0001M2-4h
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab0HBTBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:01:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab0HBTBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:01:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4780C980C;
	Mon,  2 Aug 2010 15:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=aEE4mtJhVo3HZ8YTbD5Tbvl6bYQ=; b=LIJvv5NEEBvXtJ0zHLhDt3b
	x9KBIMyJvV7D+vUifMsenvrLkEkHmDkWmREi4Gv44sJDW2lWC9IVRboo08vnO4V3
	ZR0kwD/9kCagdwdTu1JFIcc5pHlgswGzFCrA9PclAYIEgUzAtAGoKNmxu9hdLgjb
	l2VeDjwx0H3EVWbBNWe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Swh28ynBPIFTIm8rsUYZp1iZMEwSJoXUBqewAhBcYDax9aJY5
	GhF9AGyZJtCH1O4jo8alHXumlLNwTkyf8qn2dbXKkAqOlrbGOcp/Ceq9coAHvUt2
	5fhvJLL5I68ZyfbV/TkJK7x0+7wEQgOaloGXlOfgRO4PklbsI7RaxiBBXI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59121C9806;
	Mon,  2 Aug 2010 15:01:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2111AC97FF; Mon,  2 Aug
 2010 15:01:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 634091D8-9E68-11DF-BC81-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152439>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> This is great: it also fixes the very long standing bug of "git gui
> blame: Show History Context"
> (http://mid.gmane.org/vpqzkxkorzr.fsf@bauges.imag.fr).
>
> Junio: Can we get this merged into git.git?

Will park in 'pu' for now; I'll double-check with Shawn how we/he would
want to proceed with git-gui in a longer term.

Thanks.
