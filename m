From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert shortlog to use parse_options
Date: Sat, 01 Mar 2008 01:37:26 -0800
Message-ID: <7v8x124wfd.fsf@gitster.siamese.dyndns.org>
References: <20080301090231.GA16937@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 10:39:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVOB9-000757-Ob
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 10:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757985AbYCAJh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 04:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758239AbYCAJh4
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 04:37:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbYCAJhn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 04:37:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D71322E51;
	Sat,  1 Mar 2008 04:37:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4BD292E50; Sat,  1 Mar 2008 04:37:35 -0500 (EST)
In-Reply-To: <20080301090231.GA16937@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 1 Mar 2008 04:02:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75647>

Jeff King <peff@peff.net> writes:

> The behavior should be identical, except that we now support
> option bundling (e.g., "git shortlog -nse").

Sorry, but this breaks

	git shortlog -n -s -e --no-merges v1.5.4..

