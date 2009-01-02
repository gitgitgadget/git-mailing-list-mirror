From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] rebase: learn to rebase root commit
Date: Fri, 02 Jan 2009 14:49:05 -0800
Message-ID: <7vzli9b9y6.fsf@gitster.siamese.dyndns.org>
References: <200812301323.30550.trast@student.ethz.ch>
 <7b2902d36a4790670f20f786d4ea2e26052a6e71.1230639970.git.trast@student.ethz.ch> <7v4p0iivwh.fsf@gitster.siamese.dyndns.org> <200901022320.14055.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsqg-0005nT-Gi
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183AbZABWtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757056AbZABWtM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:49:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZABWtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:49:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E76C1BA05;
	Fri,  2 Jan 2009 17:49:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2682D1BA04; Fri, 
 2 Jan 2009 17:49:06 -0500 (EST)
In-Reply-To: <200901022320.14055.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri, 2 Jan 2009 23:20:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91B9F8A2-D91F-11DD-9701-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104438>

Thomas Rast <trast@student.ethz.ch> writes:

> I'm still not sure what ${1+"$@"} was about by the way.

It is one of the many old-timer's portability idioms that let us work
around bugs in some ancient shell implementations.

${1+"$@"} should be equivalent to "$@" in modern Bourne shell variants
that are POSIX compliant.
