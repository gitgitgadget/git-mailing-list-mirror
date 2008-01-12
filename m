From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: handle leading/trailing whitespace from svnsync revprops
Date: Sat, 12 Jan 2008 11:31:48 -0800
Message-ID: <7vr6gmsuvv.fsf@gitster.siamese.dyndns.org>
References: <200801081738.56624.devurandom@gmx.net>
	<200801101813.45938.devurandom@gmx.net>
	<7v63y178a3.fsf@gitster.siamese.dyndns.org>
	<200801102213.04082.devurandom@gmx.net>
	<7vmyrd5p81.fsf@gitster.siamese.dyndns.org>
	<20080112071355.GA17021@soma>
	<7vzlvbv5m9.fsf@gitster.siamese.dyndns.org>
	<20080112091242.GA27109@soma>
	<7vprw6ub1f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Schridde <devurandom@gmx.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:32:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDm5h-0005Qp-QZ
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbYALTb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYALTb5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:31:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbYALTb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:31:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD1F55FB;
	Sat, 12 Jan 2008 14:31:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8182755FA;
	Sat, 12 Jan 2008 14:31:51 -0500 (EST)
In-Reply-To: <7vprw6ub1f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 12 Jan 2008 10:57:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70354>

Junio C Hamano <gitster@pobox.com> writes:

> Git.pm is even worse.  It uses the line-noise prototype...

Sorry, I misremembered.  Git.pm is not a prototype offender.
