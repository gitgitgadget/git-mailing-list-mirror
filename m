From: Adam Majer <adamm@zombino.com>
Subject: git and appending merge commits
Date: Sun, 25 May 2008 22:35:42 -0500
Message-ID: <483A300E.6090104@zombino.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 06:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0UJe-0007VR-Ag
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 06:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbYEZE0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 00:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbYEZE0u
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 00:26:50 -0400
Received: from polaris.galacticasoftware.com ([216.55.199.131]:59210 "EHLO
	polaris.galacticasoftware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714AbYEZE0u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2008 00:26:50 -0400
X-Greylist: delayed 3072 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 May 2008 00:26:50 EDT
Received: from mira.lan.galacticasoftware.com ([192.168.53.2])
	by polaris.galacticasoftware.com with esmtp (Exim 4.63)
	(envelope-from <adamm@zombino.com>)
	id 1K0TUl-0005q7-AQ
	for git@vger.kernel.org; Sun, 25 May 2008 22:35:35 -0500
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82896>

Hi all,

I've recently started using Git and it is a very nice tool. During some
merging, I've come upon one type of issue that seems to be a bug
somewhere. To reproduce,


  1. branch master
  2. branch upstream
  3. add new version to upstream
  4. merge it to master
  5. append master merge changeset

#5 results in "messsed up" diffs

For an example of such a mess up please see,

http://git.debian.org/?p=collab-maint/mrtg.git;a=commitdiff;h=a8bc78ffd6d51ab09a791fa97e25f57b60eecd06

It appears that the tool generates a patch to a patch and displays that
instead of the appended merge diff which is what I would have expected..

Is current output by design?

- Adam

PS. I should have probably used a new commit to do that changelog
addition instead of appending the merge!
