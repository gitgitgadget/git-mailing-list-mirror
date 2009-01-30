From: Johannes Gilger <heipei@hackvalue.de>
Subject: diff-index --cached on bare repository
Date: Fri, 30 Jan 2009 16:13:53 +0000 (UTC)
Message-ID: <glv901$c5v$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 17:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSw1u-00076L-JH
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbZA3QOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZA3QOL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:14:11 -0500
Received: from main.gmane.org ([80.91.229.2]:37697 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbZA3QOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:14:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LSw0M-0002qu-LE
	for git@vger.kernel.org; Fri, 30 Jan 2009 16:14:06 +0000
Received: from u-4-203.vpn.rwth-aachen.de ([137.226.100.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 16:14:06 +0000
Received: from heipei by u-4-203.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 16:14:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-203.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107837>

Hi list,

today I stumbled over the output of "git diff-index --cached HEAD" in a 
bare repository. While diff-index HEAD just reminds me that I got to 
have a work-tree, --cached outputs all the files in HEAD as deleted. The 
question is if this is intended behaviour? Or is it irrelevant because 
diff-index is only plumbing? I found a mail of the gitk-team working 
around this, which is funny because I discovered this while working on 
GitX.

So please, enlighten me ;)

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
