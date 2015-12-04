From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Use "last one wins" convention for --recurse-submodules
Date: Fri, 04 Dec 2015 13:04:37 -0800
Message-ID: <xmqq610erkm2.fsf@gitster.mtv.corp.google.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<1449148235-29569-2-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:04:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4xX7-00006c-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbbLDVEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:04:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754973AbbLDVEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:04:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FC8B31596;
	Fri,  4 Dec 2015 16:04:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=kHsoX7
	ijCdjaEtuPQxbPV+4wSOjYsiEzHXSbhEfHgh01KaSYeHcwON6+AqTgRmTgWoJ8pl
	rAyC8l6sqkZU9gmhHyqK0KI5evvlInqF1lGaHbtQjMNNB/hAqKAfpkLXbjih3KJ3
	hXC0kOej2s7XAxsMxjUD0iLGL4+9aKAuj4eYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TEqbgWDv4HsGCmYukBaKL5+C/kjldLOt
	d+lK4IWvYflR0cyfBVuELgJ+mMTBPyQu1JWA1abNx2PENuuF0TZMpOfOCEGgdsnG
	PcfOwDLhS4EJu9vD1Y+HhVz0FlyvVAqxtPwhF9ardbnltaRqSMXXL5Jc4Aq8LT5Y
	fmNala1OItQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45BD231595;
	Fri,  4 Dec 2015 16:04:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B84F831594;
	Fri,  4 Dec 2015 16:04:39 -0500 (EST)
In-Reply-To: <1449148235-29569-2-git-send-email-mac@mcrowe.com> (Mike Crowe's
	message of "Thu, 3 Dec 2015 13:10:35 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A20FDC84-9ACA-11E5-AB71-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282002>

Thanks, will queue.
