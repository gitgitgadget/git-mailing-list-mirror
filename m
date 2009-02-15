From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gc: make --prune useful again by accepting an
 optional parameter
Date: Sun, 15 Feb 2009 11:33:37 -0800
Message-ID: <7vprhjlcku.fsf@gitster.siamese.dyndns.org>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
 <20090214074954.7e423dd2@perceptron>
 <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
 <200902142233.07190.trast@student.ethz.ch>
 <3651.78.34.159.109.1234647192.squirrel@heapsort.de>
 <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
 <20090214025115.615119bf@perceptron>
 <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>
 <20090214074954.7e423dd2@perceptron>
 <alpine.DEB.1.00.0902141959060.10279@pacific.mpi-cbg.de>
 <3651.78.34.159.109.1234647192.squirrel@heapsort.de>
 <alpine.DEB.1.00.0902142301030.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0902142306400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmlz-00062U-RN
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZBOTdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 14:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbZBOTdq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:33:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZBOTdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 14:33:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DCA892B31E;
	Sun, 15 Feb 2009 14:33:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E66CC2B32D; Sun,
 15 Feb 2009 14:33:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F01EE18-FB97-11DD-BE36-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110039>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this patch, "git gc --no-prune" will not prune any loose (and
> dangling) object, and "git gc --prune=3D5.minutes.ago" will prune
> all loose objects older than 5 minutes.
>
> This patch benefitted from suggestions by Thomas Rast and Jan Kr=C3=BC=
ger.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks.

Being able to say --no-$opt to an OPT_STRING to NULLify a variable that
has non-NULL default value is somewhat amusing ;-)
