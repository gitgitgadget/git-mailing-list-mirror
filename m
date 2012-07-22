From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Unifying mergetool configuration between git and git-gui
Date: Sun, 22 Jul 2012 16:22:23 +0200
Message-ID: <500C0C9F.1000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 16:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssx3b-0008CN-O1
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 16:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab2GVOWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 10:22:46 -0400
Received: from plane.gmane.org ([80.91.229.3]:38126 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab2GVOWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 10:22:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ssx3T-000856-8n
	for git@vger.kernel.org; Sun, 22 Jul 2012 16:22:43 +0200
Received: from p5ddb037a.dip0.t-ipconnect.de ([93.219.3.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 16:22:43 +0200
Received: from sschuberth by p5ddb037a.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 16:22:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb037a.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201849>

Hi,

I was about to add a configuration for yet another mergetool when I 
realized that git gui's mergetool.tcl pretty much duplicates git's 
mergetools/* configuration files. Can some one tell me why this is 
necessary? I would have expected git gui to simply rely on "git 
mergetool" to launch the mergetool. Or, in case that git gui needs to 
use a different tool than the one configured as mergetool, that 
mergetool.tcl somehow uses the configuration from mergetools/*.

Thanks for any insights.

-- 
Sebastian Schuberth
