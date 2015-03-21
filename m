From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6039: fix broken && chain
Date: Sat, 21 Mar 2015 11:04:16 -0700
Message-ID: <xmqqy4mqcjmn.fsf@gitster.dls.corp.google.com>
References: <550D1811.3040802@web.de> <550D1B78.5090703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 21 19:04:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZNl2-0000o1-J7
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 19:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbCUSEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 14:04:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbbCUSET convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2015 14:04:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA1CB3EC6E;
	Sat, 21 Mar 2015 14:04:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b+7rvFsz8kwm
	VDrJiBeNF5NY/Kc=; b=VfVj5PDI0Vpa4aX5dfsIohuED1Q4R3p8XxLFGVRFf9Ad
	JsBdENx1Z+B+YFHfAciICK7x5R/O8/shC5XbE3hJYWVv7H3nVvuPBDaVTdyi57/2
	ep/FGI+zPE/DstwL9ry6vFwA0BgjzvyWVq/GOeQ2Q5sDFRtV0A1h6f2CxuODvPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sSkZkn
	OdHnUYows9HLwyY6McAQ9E0CfkAO3jHiXwNaZcMAWe1L1lKZx9r8HHVSt2Ayu+k4
	4lTAFMTLvJLWUIzIo0wiCDi9yv3+5E4TmHKbG/SyosX06nCGzakHBb4EY4RXhtr6
	oone2pZGBKHshjilmoTwwwsGNEkdEqNs/CCCQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E37113EC6D;
	Sat, 21 Mar 2015 14:04:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 466AE3EC6B;
	Sat, 21 Mar 2015 14:04:18 -0400 (EDT)
In-Reply-To: <550D1B78.5090703@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 21 Mar 2015 08:19:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1636846-CFF4-11E4-A155-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266029>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-03-21 08.04, Torsten B=C3=B6gershausen wrote:
>> Add missing %%, detected by the --chain-lint option
> Oh, early morning typo, should be
> Add missing &&, detected by the --chain-lint option
>
> (I'll re-run the testsuite with the  --chain-lint in a minute,
>  thanks everybody for this nice feature)

Yes, it is nice to see people helping prereq holes other people
may inevitably have.

Sign-off?
