From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 11:09:20 -0700
Message-ID: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
References: <20080907184537.GA4148@regex.yaph.org>
 <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kff0d-00087v-01
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 20:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbYIPSJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbYIPSJc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 14:09:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbYIPSJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 14:09:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 88DEF618F2;
	Tue, 16 Sep 2008 14:09:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C2AAA618E8; Tue, 16 Sep 2008 14:09:23 -0400 (EDT)
In-Reply-To: <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 16 Sep 2008 12:49:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B98C4D4-841A-11DD-AAC1-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96024>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> It's too late to change diff.*.funcname now, but an alternative fix
> which would probably not require every other platform to use GNU regex,
> is to introduce a new funcname option which would allow extended regular
> expression syntax and to convert the internal regular expressions to
> that format.

That's a very sensible approach, I would agree.
