From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Sun, 12 Oct 2008 23:15:09 -0700
Message-ID: <7vskr1c976.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 08:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpGjH-0002kb-7e
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 08:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbYJMGPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 02:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbYJMGPT
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 02:15:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYJMGPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 02:15:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A4E146DD87;
	Mon, 13 Oct 2008 02:15:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 97D2E6DD85; Mon, 13 Oct 2008 02:15:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E6E5410-98EE-11DD-A889-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98085>

Shawn had this queued in pu, but it appears to even fail its own tests on
my machine, when applied on top of 'master'.

I tentatively dropped this from pu.
