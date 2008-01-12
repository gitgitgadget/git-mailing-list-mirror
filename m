From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH decompress BUG] Fix decompress_next_from() wrong argument value
Date: Sat, 12 Jan 2008 10:44:08 -0800
Message-ID: <7v1w8mvq87.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
	<7vfxx3290v.fsf@gitster.siamese.dyndns.org>
	<e5bfff550801112306g6b8127dft80484c9fd8554992@mail.gmail.com>
	<7vir1zwlcw.fsf@gitster.siamese.dyndns.org>
	<e5bfff550801112342w4faee040nad294f3962160180@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:44:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlLi-0000bB-W5
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbYALSoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYALSoU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:44:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbYALSoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:44:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A88D4321;
	Sat, 12 Jan 2008 13:44:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B600B4320;
	Sat, 12 Jan 2008 13:44:12 -0500 (EST)
In-Reply-To: <e5bfff550801112342w4faee040nad294f3962160180@mail.gmail.com>
	(Marco Costalba's message of "Sat, 12 Jan 2008 08:42:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70343>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Do you prefer patches differently organized or I can keep the same
> patch contents (of course with squashing the bug fixes in) ?

My impression was that the organization was good (addition of
the helpers, and then conversion to existing code to use the
helper piece-by-piece), even though I admit that I did not look
at them very deeply.
