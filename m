From: Mike <fromlists@talkingspider.com>
Subject: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 22:27:57 -0500
Message-ID: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 04:28:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEyx2-00029g-JR
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453AbYAPD17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758440AbYAPD17
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:27:59 -0500
Received: from relay00.pair.com ([209.68.5.9]:1943 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758398AbYAPD16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 22:27:58 -0500
Received: (qmail 27006 invoked from network); 16 Jan 2008 03:27:57 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 03:27:57 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70612>


I'm learning git and I'm really annoyed that the .git directory lives in 
the same directory as my code.  I don't want it there for three reasons:

1. My code lives on a development web server docroot, and I don't want 
the .git repository to end up getting published to the live site by 
accident. (I would imagine this would be a common need.)

2. If I tar/gz my code and deliver it to a client, I don't want the .git 
dir slipping into the tarball, allowing my client to be able to peruse 
the history of what we did and when.

3. The .git respository will get big, especially with binary files in 
it, and I want it someplace with a lot of disk space. And I don't want 
it to get tarred up when we migrate the site to a different server. (And 
tar isn't aware of hard links is it? wonderful.)

How do I make the repository dir live somewhere else, the hell away from 
my code? Thanks
