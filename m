From: Junio C Hamano <junkio@cox.net>
Subject: Re: blameview and file line number
Date: Tue, 30 Jan 2007 00:33:35 -0800
Message-ID: <7vireo52xs.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 09:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBoQx-0002Rw-MA
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbXA3Idh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbXA3Idh
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:33:37 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40330 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbXA3Idg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:33:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130083336.YOIT15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jan 2007 03:33:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HLZv1W0081kojtg0000000; Tue, 30 Jan 2007 03:33:55 -0500
In-Reply-To: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
	(Aneesh Kumar's message of "Tue, 30 Jan 2007 12:55:44 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38137>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> Is it a typo or intentional ? I found the blameview output confusing.

Compare it with gitweb or textual output (blame -n -f).

It is supposed to show the line number in the original file.
Using lno is obviously wrong, as we are not reinventing "cat -n"
here ;-).
