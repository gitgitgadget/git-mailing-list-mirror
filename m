From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Tue, 25 Jun 2013 14:18:42 -0700
Message-ID: <7vppv928jx.fsf@alter.siamese.dyndns.org>
References: <51C5FD28.1070004@ramsay1.demon.co.uk>
	<51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org>
	<51C9EE26.9010006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dpotapov@gmail.com, Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:18:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UradV-0001cy-H8
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654Ab3FYVSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:18:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab3FYVSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:18:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B52E2B96B;
	Tue, 25 Jun 2013 21:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ymTTznv+NaB0gdzsaxlXSHZqXJc=; b=NDn73Q
	nDU2Z4exnKxu1EblLiSqYyO7tyy5i5Biof1X1Y837f2JtAB0jBUnhrSXyBpRTMnH
	UiOhmGsq50rb0mDZIrxk+GrhYk9OXbT7owJwyCoJGCCL8kWG9oI6o4K+/JzLkXhd
	7s90gNmPSPAiL6GD63rBvMIDuDpBMcmpxd3C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VazvhBUhbh/xvlqqszvFPSUo69C71DQ9
	ZQnJJejbdz8DKlEW+cqB3xO55ZcbJoz1kMbbQWrPm7346AjgjaavwrUztWR6aLyu
	P40Lf77Ihn4G9mVIveYL8JFKxss8yInfsOrQTqImHRd36LDQfDQUiCWjMKNcu4S+
	5VbqAvz2YF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 714462B96A;
	Tue, 25 Jun 2013 21:18:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF2372B965;
	Tue, 25 Jun 2013 21:18:43 +0000 (UTC)
In-Reply-To: <51C9EE26.9010006@kdbg.org> (Johannes Sixt's message of "Tue, 25
	Jun 2013 21:23:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0C1A9D4-DDDC-11E2-A764-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228992>

Johannes Sixt <j6t@kdbg.org> writes:

> Some context: This is about a patch by Ramsay that removes the
> "schizophrenic lstat" hack for Cygwin. Junio, can you please queue that
> patch in pu?

Sure.  Thanks.
