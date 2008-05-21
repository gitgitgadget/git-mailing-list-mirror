From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: gitignore: negating path patterns
Date: Wed, 21 May 2008 16:40:23 +0200
Message-ID: <g11c8p$kgp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000700010003000008010202"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 16:50:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JypVO-0003iA-3Q
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758389AbYEUOkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 10:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758266AbYEUOkf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:40:35 -0400
Received: from main.gmane.org ([80.91.229.2]:39252 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757193AbYEUOke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 10:40:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JypUY-0000Ty-DL
	for git@vger.kernel.org; Wed, 21 May 2008 14:40:34 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 May 2008 14:40:34 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 May 2008 14:40:34 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82547>

This is a multi-part message in MIME format.
--------------000700010003000008010202
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi there

It seems that negating path patterns in gitignore doesn't work, or I 
don't understand it (or both). With the attached script, git status 
(1.5.5.1) reports "dir/a" as new and "dir/b" as untracked. I would 
rather expect it to report "dir/c" as untracked also.

It seems that "!b" matches to include "dir/b" (reverting the exclusion 
"*" as expected), whereas "!dir/" does not match to include "dir/c".

What's going on here?

Michael

P.S.: "*" in dir/.gitignore would do what I want, but I want all 
patterns in one place.

--------------000700010003000008010202
Content-Type: application/x-shellscript;
 name="etest.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="etest.sh"

IyEvYmluL3NoCnJtIC1SZiB0ZXN0Cm1rZGlyIHRlc3QKY2QgdGVzdApnaXQgaW5pdApta2Rp
ciBkaXIKZWNobyB0ZXN0ID4gYQplY2hvIHRlc3QgPiBkaXIvYQplY2hvIHRlc3QgPiBkaXIv
YgplY2hvIHRlc3QgPiBkaXIvYwpnaXQgYWRkIGRpci9hCmNhdCA+IC5naXQvaW5mby9leGNs
dWRlIDw8RU9GCioKIWRpci8KIWIKRU9GCmdpdCBzdGF0dXMK
--------------000700010003000008010202--
