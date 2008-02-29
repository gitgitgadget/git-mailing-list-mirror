From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] path-list: add functions to work with unsorted lists
Date: Thu, 28 Feb 2008 18:04:31 -0800
Message-ID: <7vprugfrgw.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site>
 <alpine.LSU.1.00.0802290144410.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUucj-0006Am-4y
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbYB2CEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYB2CEo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:04:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYB2CEn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:04:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 580401F0F;
	Thu, 28 Feb 2008 21:04:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B5FFC1F01; Thu, 28 Feb 2008 21:04:38 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802290144410.22527@racer.site> (Johannes
 Schindelin's message of "Fri, 29 Feb 2008 01:44:56 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75495>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	This is probably useful to a number of existing non-users of
> 	path_list.

I suspect most of the non-users will stay non-users, until the
thing is renamed to something more sensible.

The name gives a false impression that this is a special-purpose
data structure that is meant to handle pathnames very well
(e.g. canonicalizing "foo//../bar" to "bar" before doing
comparsion) but in reality it does not do anything like that,
and is a general purpose "table keyed with string" mechanism.

The wholesale renaming, if we were to do so, should happen when
things are quiet, and this is probably not a good time for it.


