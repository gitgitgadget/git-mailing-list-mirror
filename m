From: Panagiotis Issaris <takis.issaris@uhasselt.be>
Subject: Creating attachments using git-format-patch
Date: Sat, 3 Mar 2007 21:07:26 +0000 (UTC)
Message-ID: <loom.20070303T215950-974@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 22:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNbSi-00011x-IM
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 22:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbXCCVIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 16:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbXCCVIN
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 16:08:13 -0500
Received: from main.gmane.org ([80.91.229.2]:47801 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932898AbXCCVIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 16:08:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HNbSU-0006ct-7A
	for git@vger.kernel.org; Sat, 03 Mar 2007 22:08:02 +0100
Received: from 240.12-67-87.adsl-dyn.isp.belgacom.be ([87.67.12.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 22:08:02 +0100
Received: from takis.issaris by 240.12-67-87.adsl-dyn.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Mar 2007 22:08:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.67.12.240 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1) Gecko/20060601 Firefox/2.0 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41327>

Hi,

I've been trying to start using git-format-patch together with git-send-email,
but I've encountered some problems. The mailinglist I want to send the patches
to, requires patches to be sent as attachments. So, I tried using the --attach
option of git-format-patch.
However its output does not seem to generate output which Thunderbird or Mutt
recognize as attachments. Has anyone noticed similar problems or am I using it
incorrectly?

I'm doing it as follows:
takis@poseidon:/usr/local/src/ffmpeg-pi$ git-format-patch --attach HEAD^
0001-Modify-av_pkt_dump-and-av_hex_dump-to-be-av_logish.patch
takis@poseidon:/usr/local/src/ffmpeg-pi$ git-send-email
0001-Modify-av_pkt_dump-and-av_hex_dump-to-be-av_logish.patch


Mutt shows a message containing:
This is a multi-part message in MIME format.
--------------1.5.0.1.226.g7bd59
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit
...
--------------1.5.0.1.226.g7bd59
Content-Type: text/x-patch;
 name="514f2915144861b6d69ef54bd8d392aa8b3a00e6.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="514f2915144861b6d69ef54bd8d392aa8b3a00e6.diff"
...

But it does not look like an attachment. Same happens when reading the email
with Thunderbird: everything appears inline.

Any suggestions?

With friendly regards,
Takis
