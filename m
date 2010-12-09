From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc
 warning
Date: Thu, 09 Dec 2010 11:08:38 -0800
Message-ID: <7vmxoeg3wp.fsf@alter.siamese.dyndns.org>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk>
 <20101204205206.GB3170@burratino> <4D011D30.4070405@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Dec 09 20:09:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQlrR-0005hD-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 20:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab0LITI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 14:08:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab0LITIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 14:08:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2213D2417;
	Thu,  9 Dec 2010 14:09:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWcAAMv6MUbo0vHFqhoV7VGuqaw=; b=RxFYJe
	w8t5xQv+v0q3MFJVmk20FSHaSdu8nzbOT6cEcEcscGLzD8hnIHeWlb61G7CkXywE
	HXnAZ5QUbkb941EdQSFicnFfPc77dXMPqtO/lqb9dUv2iVyIRLpsHBV2pm4BJcSx
	ztN9e6AOPOh7D8XYeLAf+Pba9jXpHnLTMWedE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dUj0H2bAgLglGlSG57H1YevRU1mFPtNL
	p/tPqtwcdF+5oRqaIxXazzUpCPNkhhZwA1nouXq7+/xFoY7sQQ2g57UM+18h4IU0
	H+svpqplIM8YOOLkzi2ZlKbIv1qusdDjQuCxrKMGZ2VAKuumKFHKnY/Zrj0RlIuO
	GEO6azKtzIs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1ED82416;
	Thu,  9 Dec 2010 14:09:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E953E2414; Thu,  9 Dec 2010
 14:09:03 -0500 (EST)
In-Reply-To: <4D011D30.4070405@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Thu\, 09 Dec 2010 18\:17\:20 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE5FAF66-03C7-11E0-B805-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163304>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio, could you please drop patches 5-14 from the series; the first four patches
> are the important ones and I'd rather they didn't get held up. Thanks!

Have these four patches been Acked by interested parties?

I think I saw 1/N and 2/N acked by Erik and 4/N acked by SSchuberth and
J6t, but any words on 3/N?

Not that I deeply care nor have environment to test changes to [3/N], but
I am wondering if these need conditional definition to futureproof (e.g.
what happens when the header you are using the definition _I64_MIN from,
or some other headers, started defining these constats?).
