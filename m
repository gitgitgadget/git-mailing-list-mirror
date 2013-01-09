From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7400 broken on pu (Mac OS X)
Date: Wed, 09 Jan 2013 11:16:09 -0800
Message-ID: <7v38ya6ubq.fsf@alter.siamese.dyndns.org>
References: <50EDBA37.30205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt18a-000607-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446Ab3AITQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2013 14:16:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52171 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932367Ab3AITQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 14:16:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 627FEB3FA;
	Wed,  9 Jan 2013 14:16:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Q/+RjjHTHnuu
	ygQDg2M7sIR3tsQ=; b=iiizPuAIKH3gQBeqVAtdboJE9lBbZ5prDiHobyd9S/ZO
	oFtb9paChAyy8rg+QgEaCSPRAyM74C9r2JYwlrbu8FgUl/CNBFrfOSM765hf25c/
	JZ0/ZFA0F8wwKQfsRUKQe9NalrmFAAoh8tAXDSNfGCG+h2K4VIENOZ2F7GmiTcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=crpYhb
	rMQEqKuloPf7fS0Qr7882ZwQmfo4uv85fJkIT3nA2ZEA8qV84k3nCxMi/dYH4gD8
	qb7DDki1Jbu2vNi+xpVWdT08Exh/8iaoPnFltnSEpbU2W5zVp18t8hOsfE9ZLf/1
	jj97ot3j3V3xfVeb9HrBdMgq4OqHZRRPi1CbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 542D1B3F7;
	Wed,  9 Jan 2013 14:16:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C52DAB3F3; Wed,  9 Jan 2013
 14:16:10 -0500 (EST)
In-Reply-To: <50EDBA37.30205@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Wed, 09 Jan 2013 19:43:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06F7C3E6-5A91-11E2-8ED0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213080>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The current pu fails on Mac OS, case insensitive FS.
>
>
> Bisecting points out
> commit 3f28e4fafc046284657945798d71c57608bee479
> [snip]
> Date:   Sun Jan 6 13:21:07 2013 +0700

Next time do not [snip] but please find the author address there,
and Cc such a report.

I think this topic is planned to be rerolled anyway, and your report
would be a valuable input while doing so.

Thanks.
