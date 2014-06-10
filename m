From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5551: fix the 50,000 tag test
Date: Mon, 09 Jun 2014 22:53:31 -0700
Message-ID: <xmqqoay1b99g.fsf@gitster.dls.corp.google.com>
References: <5390E2D5.9070000@web.de>
	<xmqqr42xevwi.fsf@gitster.dls.corp.google.com>
	<53967F48.1080103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuF0A-0003Ll-NP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbaFJFxi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 01:53:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58262 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaFJFxh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 01:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8BA1101B4;
	Tue, 10 Jun 2014 01:53:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p2ITJ/Qm1MGA
	TzgWxMYeStob0Gg=; b=LebBN+Cm9ICOQbF2MXbAEqRFcHSzNvjcnSwUenLrl0j9
	7KWKre6RwSnckSsZA0mReOuNz/d7FkwEQccmhd6FdHX116oh5iah5DoJroth3GtF
	DTjegzTuPO1yf25IuE7Nu5h/eJ8N+ersDOBmWUAAW8HrX54EItD4REOLNSV/u4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OqR+2C
	lSN496aZxwWbWjFVbmDxOhHAITlEWhegbxHpJzS497KGdznU9hIjBU74Lph8kKyI
	Mly/cWFgwZ7aYhMgOH17RzLMsl5licp4XznmXtNA7+tEkRY4e+w8oAuu061sBZGi
	pde/RQ/a43Gnd7qH7szcijmlmAdwFbHMO7m7s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE37B101B1;
	Tue, 10 Jun 2014 01:53:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFA45101AB;
	Tue, 10 Jun 2014 01:53:32 -0400 (EDT)
In-Reply-To: <53967F48.1080103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 10 Jun 2014 05:45:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E2707DC-F063-11E3-A082-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251162>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks for digging, as we now know better:
> do you want to squeeze in someting like this:
>
> s/Since the day/Since commit 5e2c7cd2/=20

I usually do not dig only to give suggestions to others, which will
risk the time I spent to go to total waste.  When I find the log
message lacking, and if the patch looked otherwise OK enough, I do
the digging myself in order to tweak to reduce one round-trip
(otherwise I'd just discard and tell the submitter to do the
digging).  I may send out what I learned as a response, but that is
a mere "side effect"; the primary effect of queuing an improved
patch has often already happened when you see the result of my
digging.

I do not recall what I did for this particular patch, but you should
be able to fetch and run "git log origin/master..origin/pu" to find
out what I did ;-).

Thanks.
