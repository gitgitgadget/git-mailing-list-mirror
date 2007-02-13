From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Tue, 13 Feb 2007 09:43:05 -0800
Message-ID: <7v7iumymvq.fsf@assigned-by-dhcp.cox.net>
References: <200702131512.45412.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1gN-0006AW-UN
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbXBMRnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbXBMRnH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:43:07 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62450 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbXBMRnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:43:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213174306.KNFP21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 12:43:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P5j51W00b1kojtg0000000; Tue, 13 Feb 2007 12:43:06 -0500
In-Reply-To: <200702131512.45412.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 13 Feb 2007 15:12:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39552>

As a principle, I am in favor of this.  Perhaps post 1.5.0 after
hearing what real cvsserver users have to say on the list.
