From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add otherwise missing --strict option to unpack-objects
 summary.
Date: Wed, 23 Apr 2008 14:59:03 -0700
Message-ID: <7v1w4ws060.fsf@gitster.siamese.dyndns.org>
References: <1208985270-27147-1-git-send-email-jdl@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:00:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jon0Y-0006XN-J4
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 00:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbYDWV7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbYDWV7N
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 17:59:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbYDWV7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 17:59:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BB6B938A9;
	Wed, 23 Apr 2008 17:59:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 36E7538A3; Wed, 23 Apr 2008 17:59:07 -0400 (EDT)
In-Reply-To: <1208985270-27147-1-git-send-email-jdl@freescale.com> (Jon
 Loeliger's message of "Wed, 23 Apr 2008 16:14:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80264>

Jon Loeliger <jdl@freescale.com> writes:

> The option --pack_header= is also not documented here
> and in git-fetch-pack (others?), but it seems like that
> might have been intentional?

It is pretty much an implementation detail of an internal communication
between fetch-pack and unpack-objects.

The option would help anybody who wants to create an alternative
implementation of fetch-pack but otherwise won't be of much use.
