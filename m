From: Rick Moynihan <rick@calicojack.co.uk>
Subject: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 13:17:20 +0100
Message-ID: <48F730D0.9040008@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 15:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqTKt-0002pd-CG
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 15:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYJPNzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 09:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYJPNzG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 09:55:06 -0400
Received: from storm.bpweb.net ([83.223.106.8]:52882 "EHLO storm.bpweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbYJPNzF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 09:55:05 -0400
X-Greylist: delayed 5853 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Oct 2008 09:55:04 EDT
Received: from lechuck.local (host-77-100-223-163.static.telewest.net [77.100.223.163])
	(authenticated bits=0)
	by storm.bpweb.net (8.13.1/8.13.1) with ESMTP id m9GCHPQx002949
	for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:17:30 +0100
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
X-BpTo: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98381>

Hi,

I have a master branch, a dev branch and a number of feature branches 
from dev.  And I was wondering if there was an easy way to rebase dev 
and all of it's sub-branches onto master.

I know I can run this as a series of commands, and use --onto to do 
this, but was wondering if there was an easier way.  As running:

git rebase master

when on the dev branch only rebases dev and not it's dependent branches.

Thanks!

R.
