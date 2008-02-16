From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid html output repo.or.cz (alt-git.git)
Date: Sat, 16 Feb 2008 11:20:29 -0800
Message-ID: <7v7ih4908y.fsf@gitster.siamese.dyndns.org>
References: <20080216130037.GA14571@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Sat Feb 16 20:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSbf-00015E-8i
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbYBPTVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756503AbYBPTVP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:21:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406AbYBPTVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:21:14 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EDD55756;
	Sat, 16 Feb 2008 14:21:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 E6BCB5753; Sat, 16 Feb 2008 14:21:05 -0500 (EST)
In-Reply-To: <20080216130037.GA14571@auto.tuwien.ac.at> (Martin Koegler's
 message of "Sat, 16 Feb 2008 14:00:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74066>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> http://repo.or.cz/w/alt-git.git?a=shortlog
>
> fails to load in my Seamonkey browser (Debian stable):

Sorry, that's caused by a bad commit author encoding.  gitweb
should ideally be tightened, though.
