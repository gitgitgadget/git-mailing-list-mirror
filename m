From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Sun, 15 Feb 2009 15:39:37 -0800
Message-ID: <7vtz6vgthi.fsf@gitster.siamese.dyndns.org>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu>
 <1233598855-1088-2-git-send-email-keith@cs.ucla.edu>
 <20090203071516.GC21367@sigill.intra.peff.net>
 <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
 <20090206161954.GA18956@coredump.intra.peff.net>
 <alpine.GSO.2.00.0902090921270.719@kiwi.cs.ucla.edu>
 <20090213222233.GA7424@coredump.intra.peff.net>
 <alpine.DEB.1.00.0902140658050.10279@pacific.mpi-cbg.de>
 <20090214061538.GB3223@sigill.intra.peff.net>
 <alpine.DEB.1.00.0902140724360.10279@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0902151521550.24570@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Feb 16 00:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqbt-0000fb-77
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZBOXju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbZBOXju
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:39:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZBOXjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:39:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 700719A24D;
	Sun, 15 Feb 2009 18:39:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AF32B9A24A; Sun,
 15 Feb 2009 18:39:39 -0500 (EST)
In-Reply-To: <alpine.GSO.2.00.0902151521550.24570@kiwi.cs.ucla.edu> (Keith
 Cascio's message of "Sun, 15 Feb 2009 15:26:54 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED931B7E-FBB9-11DD-8893-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110092>

Keith Cascio <keith@CS.UCLA.EDU> writes:

> On Sat, 14 Feb 2009, Johannes Schindelin wrote:
>
>> Why not spell it out?  diff.defaultOptions
>
> OK in v3 I'll use "defaultOptions".  Now what do we call the switches?

ignore-default?
