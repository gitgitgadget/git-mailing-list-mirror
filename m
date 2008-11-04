From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Mon, 03 Nov 2008 19:17:56 -0800
Message-ID: <7vtzaorxgb.fsf@gitster.siamese.dyndns.org>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <m37i7pggnk.fsf@localhost.localdomain>
 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
 <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
 <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
 <alpine.LFD.2.00.0811031611060.13034@xanadu.home>
 <f1d2d9ca0811031453p49390911p956149ca76b9b80d@mail.gmail.com>
 <alpine.LFD.2.00.0811031959070.13034@xanadu.home>
 <7v3ai8tgq9.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0811032053410.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thanassis Tsiodras <ttsiodras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 04:19:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxCS6-0006Xj-QA
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 04:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbYKDDSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 22:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbYKDDSV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 22:18:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbYKDDSU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 22:18:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A41EF93719;
	Mon,  3 Nov 2008 22:18:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EBE2D93710; Mon,  3 Nov 2008 22:17:58 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811032053410.13034@xanadu.home> (Nicolas
 Pitre's message of "Mon, 03 Nov 2008 20:57:04 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A1BD734-AA1F-11DD-BA1B-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100025>

Nicolas Pitre <nico@cam.org> writes:

> The issue is to decide what preferred delta base to add to the list of 
> objects.  Currently only objects with the same path as those being 
> modified are considered.

Ah, I was blind (even though that part is my code).  Thanks.
