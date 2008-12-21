From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Style changes per suggestions from Junio in #git
Date: Sun, 21 Dec 2008 23:03:37 +0100
Message-ID: <vpqbpv5mbie.fsf@bauges.imag.fr>
References: <1229895454-19498-1-git-send-email-tyler@slide.com>
	<1229895454-19498-2-git-send-email-tyler@slide.com>
	<1229895454-19498-3-git-send-email-tyler@slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWSi-00041c-7o
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYLUWGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbYLUWGa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:06:30 -0500
Received: from imag.imag.fr ([129.88.30.1]:58313 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291AbYLUWG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:06:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mBLM3bVr010247
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 21 Dec 2008 23:03:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LEWOf-0002mo-Ay; Sun, 21 Dec 2008 23:03:37 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LEWOf-0006Ra-8c; Sun, 21 Dec 2008 23:03:37 +0100
In-Reply-To: <1229895454-19498-3-git-send-email-tyler@slide.com> (R. Tyler Ballance's message of "Sun\, 21 Dec 2008 15\:37\:34 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103716>

"R. Tyler Ballance" <tyler@slide.com> writes:

> Moving includes into git-compat-util.h, move away from malloc(2)

Usually, those cleanup patches are merged with the actual patch before
inclusion. This helps review (i.e. let reviewers not have to say or
think "you shouldn't do that - oh, ok, you're actually not doing it"),
and avoids having bad commits at all in Junio's repository.

-- 
Matthieu
