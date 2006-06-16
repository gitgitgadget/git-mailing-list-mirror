From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: 2.6.17-rc6-mm2
Date: Fri, 16 Jun 2006 14:40:10 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060616124010.GB13884@informatik.uni-freiburg.de>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org> <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 16 14:40:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrDcX-0007Kx-UM
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 14:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWFPMkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 08:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFPMkO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 08:40:14 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:65156 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751379AbWFPMkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 08:40:12 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FrDcQ-0006UN-T5
	for git@vger.kernel.org; Fri, 16 Jun 2006 14:40:10 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5GCeAe14693
	for git@vger.kernel.org; Fri, 16 Jun 2006 14:40:10 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21940>

Hello,

> I suggest adding SO_KEEPALIVE option on the git socket.
I suggest to do this "manually", that is send an dummy (or status)
package every x seconds.  Then the server could detect if a cloning
client disconnected and stop generating the pack file.

(Currently I see from time to time a git server process (IIRC
git-pack-objects) that creates a packfile and only when it's done fails
to send it.)

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=30+hours+and+4+days+in+seconds
