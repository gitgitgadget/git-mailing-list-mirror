From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wrong expectation from "git log -p"
Date: Mon, 01 Jun 2009 17:54:47 -0700
Message-ID: <7vzlcrihew.fsf@alter.siamese.dyndns.org>
References: <pan.2009.06.02.00.34.36@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Spura <tomspur@fedoraproject.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 02:55:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBIHL-0003tM-Nw
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 02:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbZFBAyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 20:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbZFBAyr
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 20:54:47 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43157 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbZFBAyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 20:54:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602005448.FULQ20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jun 2009 20:54:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id youn1b00N4aMwMQ03oungJ; Mon, 01 Jun 2009 20:54:48 -0400
X-Authority-Analysis: v=1.0 c=1 a=alPNUxG5nO4A:10 a=jLTWHNihfVYA:10
 a=vTr9H3xdAAAA:8 a=qGWaXdO_8Vi3g4qrV3wA:9 a=-MhYcWjLGXgD3VLhkirD2loZif4A:4
 a=DGUv9C6miAAA:10
X-CM-Score: 0.00
In-Reply-To: <pan.2009.06.02.00.34.36@fedoraproject.org> (Thomas Spura's message of "Tue\, 2 Jun 2009 00\:34\:53 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120492>

Thomas Spura <tomspur@fedoraproject.org> writes:

> If running "git log -p parse-options.*", the last commit is 
> df217ed6430efe444a09fffdafd39720ae3f9864
> There are the changes this commit makes towards parse-options.*.
>
> I was expecting to see the full commit with all changes and not only 
> towards the 2 files - only including the two files.
>
> Is my expactation wrong or is this a bug?

Time to run "man git-log" and look for --full-diff, perhaps?
