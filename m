From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION ?] git-remote "--mirror" option is not integrated in 1.5.3.7
Date: Mon, 03 Dec 2007 10:09:50 -0800
Message-ID: <7vprxnir9t.fsf@gitster.siamese.dyndns.org>
References: <31e679430712030532p12e1f0f5x7e10bd0a1fdf9ef9@mail.gmail.com>
	<Pine.LNX.4.64.0712031622470.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFkG-0004hV-5V
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbXLCSJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbXLCSJ4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:09:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44037 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbXLCSJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:09:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 21D162F0;
	Mon,  3 Dec 2007 13:10:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 99E269B899;
	Mon,  3 Dec 2007 13:10:13 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712031622470.27959@racer.site> (Johannes
	Schindelin's message of "Mon, 3 Dec 2007 16:23:23 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66937>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 3 Dec 2007, Felipe Balbi wrote:
>
>> I've using git-remote --mirror mode for while right now but I saw it's 
>> not integrated in v.1.5.3.7, is this on purpose? I can still get it if I 
>> compile recent git's head "36863af16e91aebc87696209f4f4780cf4c4059f".
>
> AFAICT there are problems with --prune.  That might be a reason that it is 
> not in 1.5.3.7 (haven't checked if that's even the case, though).

That is a _NEW_ feature.  Maintenance series won't get any new features.
