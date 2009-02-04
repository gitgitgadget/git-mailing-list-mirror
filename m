From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix access to an uninitialized mode variable,
 found by valgrind
Date: Tue, 03 Feb 2009 23:46:42 -0800
Message-ID: <7vljsm4pb1.fsf@gitster.siamese.dyndns.org>
References: <cover.1233712140u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Don Zickus <dzickus@redhat.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 08:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUcV6-0003Dy-Sn
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 08:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbZBDHqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 02:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbZBDHqv
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 02:46:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbZBDHqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 02:46:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FEA796884;
	Wed,  4 Feb 2009 02:46:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BB3896883; Wed,
  4 Feb 2009 02:46:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FAC4151A-F28F-11DD-AA50-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108303>

Looks correct; thanks.
