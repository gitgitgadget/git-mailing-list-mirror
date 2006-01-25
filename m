From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: git describe fails without tags
Date: Wed, 25 Jan 2006 08:47:25 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060125074725.GA2768@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 08:47:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1fNV-00087q-NQ
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 08:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWAYHra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 02:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWAYHra
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 02:47:30 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:32646 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1750774AbWAYHra (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 02:47:30 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F1fNJ-0000cI-1P
	for git@vger.kernel.org; Wed, 25 Jan 2006 08:47:29 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0P7lP9C003292
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 08:47:25 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0P7lP9Z003291
	for git@vger.kernel.org; Wed, 25 Jan 2006 08:47:25 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15122>

Hello,

using git describe on Linus' sparse repo results in:

	uzeisberger@io:~/gsrc/sparse$ git describe
	fatal: cannot describe '62ac6c16058aba8693fd5827379debc5f57b60f5'

The reason is, that there exist no tags at all, so right, there is no
"most recent tag that is reachable from HEAD".

I wonder if it would be sane to assume an implicit tag for the empty
repository, s.t. git describe results in 

	<empty>-62ac6c16

(whatever name is choosen for <empty>).

Any opinions?

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=1+degree+celsius+in+kelvin
