From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: git submodule merge madness
Date: Fri, 9 Jan 2009 13:50:50 -0800
Message-ID: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 22:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLPNa-0007Wi-08
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 22:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZAIV5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 16:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbZAIV5d
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 16:57:33 -0500
Received: from x8.develooper.com ([216.52.237.208]:58387 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbZAIV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 16:57:32 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jan 2009 16:57:32 EST
Received: (qmail 19450 invoked from network); 9 Jan 2009 21:50:51 -0000
Received: from dsl081-039-130.lax1.dsl.speakeasy.net (HELO dhcp221.bur.sol) (ask@mail.dev@64.81.39.130)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 9 Jan 2009 21:50:51 -0000
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105042>

Hi,

We've (again) replaced a few directories with submodules.  Man, it's  
madness!

The typical problem is that we get an error trying to merge a "pre- 
submodule" branch into master:

	fatal: cannot read object 894c77319a18c4d48119c2985a9275c9f5883584  
'some/sub/dir': It is a submodule!
Mark Levedahl wrote an example in July, but I don't think he got any  
replies:  http://marc.info/?l=git&m=121587851313303
Any ideas?   Is there something we can do?    I see a strong  
correlation between adding a new submodule and the number of "git  
sucks" messages on our internal IRC server.


  - ask

-- 
http://develooper.com/ - http://askask.com/
