From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 16:59:15 -0700
Message-ID: <7viqmh7wvg.fsf@gitster.siamese.dyndns.org>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>
 <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302> <49B64ADC.2090406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 01:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhBsd-0001ZS-1D
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 01:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbZCJX73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 19:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZCJX72
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 19:59:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbZCJX71 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 19:59:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D3DB2576C;
	Tue, 10 Mar 2009 19:59:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD3415768; Tue,
 10 Mar 2009 19:59:17 -0400 (EDT)
In-Reply-To: <49B64ADC.2090406@viscovery.net> (Johannes Sixt's message of
 "Tue, 10 Mar 2009 12:11:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C111C1C-0DCF-11DE-BBBC-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112859>

Johannes Sixt <j.sixt@viscovery.net> writes:

> All data producers and data consumers *in git* use band #2 to transport
> error messages and progress report.

Correct; I wrote that in the big comment at the beginning of sideband.c.

Of course we could enhance the protocol to use more bands as needed.  #2
and #3 have their own meanings and they both map well to "send to stderr".
