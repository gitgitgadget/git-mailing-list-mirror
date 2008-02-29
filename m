From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: add "man.viewer" config var to use "woman" or
 "konqueror"
Date: Thu, 28 Feb 2008 23:46:44 -0800
Message-ID: <7vfxvcdx23.fsf@gitster.siamese.dyndns.org>
References: <20080228051956.2f36edf0.chriscool@tuxfamily.org>
 <200802290200.m1T2023x017992@localhost.localdomain>
 <200802290814.39366.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xavier Maillard <xma@gnu.org>, pascal@obry.net,
	nanako3@bluebottle.com, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 08:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUzy8-0006Is-Pt
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 08:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbYB2HrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 02:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755046AbYB2HrL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 02:47:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbYB2HrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 02:47:11 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B76C132C;
	Fri, 29 Feb 2008 02:47:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CF6DC132A; Fri, 29 Feb 2008 02:47:03 -0500 (EST)
In-Reply-To: <200802290814.39366.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 29 Feb 2008 08:14:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75509>

Looking at this exchange really makes me suspect that these
things should not be in C.  Every time Emacs updates we need
recompilation?  Yuck.

What was the reason we gave up calling out to a single generic
scripted wrapper that the users can just munge to suit their
tastes?
