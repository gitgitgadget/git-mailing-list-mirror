From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pull: document usage via OPTIONS_SPEC
Date: Fri, 22 Feb 2008 17:15:54 -0800
Message-ID: <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
References: <1203727950-14980-1-git-send-email-jaysoffian@gmail.com>
 <1203727950-14980-2-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 02:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSj0V-0002ga-OI
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 02:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYBWBQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 20:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYBWBQK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 20:16:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbYBWBQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 20:16:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3AFAD3CB9;
	Fri, 22 Feb 2008 20:16:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 69CB33CB7; Fri, 22 Feb 2008 20:16:03 -0500 (EST)
In-Reply-To: <1203727950-14980-2-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Fri, 22 Feb 2008 19:52:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74776>

OPTIONS_SPEC is not just for documentation but it actively mucks
with the incoming options list.

Have you checked if you did not break the actual parsing?
