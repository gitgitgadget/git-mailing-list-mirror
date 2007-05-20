From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 15:52:33 +0200
Message-ID: <20070520135233.GE5015@cip.informatik.uni-erlangen.de>
References: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net> <9fb1551c0705200646m62b61efegbae76e6f17b06799@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Dave Hanson <drh@drhanson.net>
X-From: git-owner@vger.kernel.org Sun May 20 15:52:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hplpw-0001b0-Ud
	for gcvg-git@gmane.org; Sun, 20 May 2007 15:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbXETNwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 09:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756435AbXETNwf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 09:52:35 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:61478 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755994AbXETNwe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 09:52:34 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id C8DB93F38E; Sun, 20 May 2007 15:52:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9fb1551c0705200646m62b61efegbae76e6f17b06799@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47838>

Hello,

> /usr/bin/ld: can't locate file for: -lexpat

make NO_EXPAT=1

or if you have libexpat.so installed on your system you should provide
it in the Linkerpath and Runtimepath.

        Thomas
