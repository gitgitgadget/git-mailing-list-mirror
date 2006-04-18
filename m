From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [BUG] gitk draws a wrong line
Date: Tue, 18 Apr 2006 12:40:14 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060418104014.GA2299@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 18 12:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVnd8-0006hH-B9
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 12:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWDRKkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 06:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWDRKkS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 06:40:18 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:31124 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932175AbWDRKkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 06:40:16 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FVnd1-0007D7-04
	for git@vger.kernel.org; Tue, 18 Apr 2006 12:40:15 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k3IAeEW02742
	for git@vger.kernel.org; Tue, 18 Apr 2006 12:40:14 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18850>

Hallo,

I'm using 1.3.0.rc4.g2855d in Linus Linux tree. When doing

	$ gitk v2.6.16..v2.6.17-rc1

and then going to commit 10c2df65060e1ab57b2f75e0749de0ee9b8f4810, 
I see a small superfluous line between the two commits under 10c2df.

But still worse, if I select the line going down from 10c2df and then
select it's parent (i.e c76b6b) I get a big line ending in the commit
descriptions and four lines ending in midair.

See screenshots at 

	http://www.informatik.uni-freiburg.de/~zeisberg/bug-gitk/

Best regards
Uwe

-- 
Uwe Zeisberger

cat /*dev/null; echo 'Hello World!';
cat > /dev/null <<*/ 
() { } int main() { printf("Hello World!\n");}
/* */
