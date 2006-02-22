From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] relax delta selection filtering in pack-objects
Date: Tue, 21 Feb 2006 22:05:39 -0800
Message-ID: <7vpslgrkr0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212034180.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 07:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBn8G-0003Is-45
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 07:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWBVGFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 01:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWBVGFn
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 01:05:43 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:14787 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751344AbWBVGFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 01:05:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060222060548.LDSV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 01:05:48 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602212034180.5606@localhost.localdomain> (Nicolas
	Pitre's message of "Tue, 21 Feb 2006 20:39:25 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16591>

I haven't dug into the issue yet, but these four delta series
seem to break the testsuite.
