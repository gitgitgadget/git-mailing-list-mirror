From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Fix diff regression for submodules not checked out
Date: Sat, 03 May 2008 09:59:51 -0700
Message-ID: <7vy76ruxvc.fsf@gitster.siamese.dyndns.org>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
 <7vfxt0wdkq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805031335380.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 03 19:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsL6V-00077T-8s
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759436AbYECRAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 13:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759314AbYECRAH
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 13:00:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758721AbYECRAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 13:00:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 71CC14FB0;
	Sat,  3 May 2008 13:00:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C14EC4FAE; Sat,  3 May 2008 13:00:00 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805031335380.30431@racer> (Johannes
 Schindelin's message of "Sat, 3 May 2008 13:36:49 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60D39E80-1932-11DD-852F-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81101>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In the same vein, I had to think about "stagable" for some time.  I think 
> the correct term is "stageable", but then, I am not sure if there is no 
> better word anyway.

Oh, I did not even mention that because it quite obviously is an typo of a
non-word ;-)
