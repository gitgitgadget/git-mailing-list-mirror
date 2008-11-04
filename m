From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Mon, 03 Nov 2008 17:36:14 -0800
Message-ID: <7v3ai8tgq9.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thanassis Tsiodras <ttsiodras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 02:38:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxArw-0004Ax-R7
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 02:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbYKDBge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 20:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbYKDBgd
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 20:36:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYKDBgd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 20:36:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C0858932CC;
	Mon,  3 Nov 2008 20:36:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AED48932CB; Mon,  3 Nov 2008 20:36:16 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811031959070.13034@xanadu.home> (Nicolas
 Pitre's message of "Mon, 03 Nov 2008 20:18:37 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 021FB2DC-AA11-11DD-A5A2-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100022>

Nicolas Pitre <nico@cam.org> writes:

> Right.  Those thin packs were designed for different versions of the 
> same file in mind, not different files with almost the same content.  
> This could possibly be improved at some point...

Wouldn't using a large --window help by going across name-hash boundaries?
