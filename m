From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: warn against merging in a dirty tree
Date: Mon, 15 Sep 2008 16:42:45 -0700
Message-ID: <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
References: <200809160048.31443.trast@student.ethz.ch>
 <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
 <1221518994-26111-2-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 16 01:44:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfNjo-0004Mz-RM
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 01:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYIOXnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYIOXnD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 19:43:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbYIOXnB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 19:43:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8882461384;
	Mon, 15 Sep 2008 19:42:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D5A466137C; Mon, 15 Sep 2008 19:42:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06E14A04-8380-11DD-8F16-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95957>

Thomas Rast <trast@student.ethz.ch> writes:

> Merging in a dirty tree is usually a bad idea because you need to
> reset --hard to abort; but the docs didn't say anything about it.

Strictly speaking, you do not have to worry about anything if (1) all of
your work tree changes are easily reproducible (Linus's keeping a new
EXTRAVERSION in his Makefile, never staged nor committed is an often cited
example), or (2) you know beforehand that a merge with the other party
will not touch the part you have local changes that you care about.

In other words, you need to know what you are doing, and a warning with
"usually it is a bad idea" would be an appropriate thing to do.
