From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Port forwarding
Date: Tue, 12 Jun 2007 17:26:19 +0200
Message-ID: <466EBB1B.9060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 19:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAX0-0004XM-EY
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbXFLRvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbXFLRvi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:51:38 -0400
Received: from ms01.sssup.it ([193.205.80.99]:43480 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755062AbXFLRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 13:51:37 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 31100891 for git@vger.kernel.org; Tue, 12 Jun 2007 17:18:31 +0200
Received: from [10.30.3.110] (chrome.retis [10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l5CENi8p016032
	for <git@vger.kernel.org>; Tue, 12 Jun 2007 16:23:44 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070306)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49979>

Hi all,

    how can I specify the port in git-clone when cloning from a server running 
git-daemon ?

The issue is the following.

I need to set port forwarding from a public server to a private server.
The public server, however, already hosts a git-daemon on port 9418.
So, I have to use a different port for the forwarding.

My idea is to let the public server listen on a different port (e.g. 9419) and 
make it redirect all the incoming connections to the port 9418 of the private 
server.

However, I don't know how make git-clone go on a port different than the default 
(9418).

Many thanks in advance,

          Claudio
