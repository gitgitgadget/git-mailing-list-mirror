From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 11:22:14 -0800
Message-ID: <7vacbi8eu1.fsf@assigned-by-dhcp.cox.net>
References: <20060322025921.1722.qmail@science.horizon.com>
	<20060322172227.GO3997@reactrix.com>
	<20060322183621.GP3997@reactrix.com>
	<7vslpa8fld.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 20:22:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM8uT-00031Z-EP
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 20:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWCVTWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 14:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWCVTWR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 14:22:17 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:7840 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932391AbWCVTWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 14:22:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322192011.XYS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 14:20:11 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslpa8fld.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 22 Mar 2006 11:05:50 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17823>

Junio C Hamano <junkio@cox.net> writes:

> We do bend backwards to support ISP HTTP servers, but this might
> be going a bit too far.  Also I wonder if ISP runs a really
> dumb-friendly configured server that defaults to text/html
> unless the mimemap says otherwise.  Loose object files do not
> have suffixes and I am expecting these servers would give
> whatever the server default is.

Clarification.  Even if a server configured as such existed and
sent an otherwise valid loose object with text/html, your code
does the right thing.

However the patch would not help when such a server also did a
"Sorry, did you mistype the URL?" HTML response, and I was
wondering how typical that would be.
