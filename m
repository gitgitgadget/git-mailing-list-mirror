From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] make struct progress an opaque type
Date: Tue, 30 Oct 2007 17:05:27 -0700
Message-ID: <7vabq0jghk.fsf@gitster.siamese.dyndns.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
	<1193770655-20492-2-git-send-email-nico@cam.org>
	<1193770655-20492-3-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In15h-0008K2-2A
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbXJaAFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXJaAFd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:05:33 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:36043 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbXJaAFc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:05:32 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 94EDD2FC;
	Tue, 30 Oct 2007 20:05:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3551F90779;
	Tue, 30 Oct 2007 20:05:51 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62764>

The ../linux-2.6/scripts/checkpatch.pl (run with --no-tree)
script found a few instances of:

ERROR: "foo * bar" should be "foo *bar"
#239: FILE: progress.c:91:
+struct progress * start_progress_delay(const char *title, unsigned total,

I'll munge them away before applying.
