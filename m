From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- user-manual.xml:3739: parser error
Date: Sun, 30 Sep 2012 02:15:24 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930021524.01d314d5.hesco@campaignfoundations.com>
Reply-To: hesco@campaignfoundations.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 08:26:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TICzE-0002Nf-MP
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 08:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab2I3GZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 02:25:49 -0400
Received: from mail.greens.org ([207.111.216.211]:59417 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab2I3GZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 02:25:48 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Sep 2012 02:25:48 EDT
Received: by mail.greens.org (Postfix, from userid 2012)
	id 1B4BD805BC; Sat, 29 Sep 2012 23:16:15 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id 1E4002539F
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 02:15:25 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740215256624
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206667>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

user-manual.xml:3739: parser error : Opening and ending tag mismatch: emphasis line 3739 and literal
  char <emphasis role="strong"></literal>, but is actually expected to be a poin
                                         ^
user-manual.xml:3741: parser error : Opening and ending tag mismatch: literal line 3741 and emphasis
mit.  Note that whenever a SHA-1 is passed as <literal>unsigned char </emphasis>
                                                                               ^
unable to parse user-manual.xml
make[1]: *** [user-manual.html] Error 6
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-- 
Hugh Esco 
skype: hresco3_ ; 678-921-8186 x21 
http://www.CampaignFoundations.com/
Providing Application Hosting, Telephony, 
Custom Development and Consulting Services 
to Green Candidates, Green Parties and
the non profits working for a just and sustainable future.

if( $insurance->rationing() ) { $people->die(); }
if( isa_ok($self,'Troy::Davis') =~ m/^ok/) { $people->are_whole(); }
