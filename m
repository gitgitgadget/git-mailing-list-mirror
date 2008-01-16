From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 19:50:20 -0800
Message-ID: <86hcheig3n.fsf@blue.stonehenge.com>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzlh-0003BM-1u
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296AbYAPEUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbYAPEUT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:20:19 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:19834 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197AbYAPEUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:20:18 -0500
X-Greylist: delayed 1797 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2008 23:20:18 EST
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B8D441DE220; Tue, 15 Jan 2008 19:50:20 -0800 (PST)
x-mayan-date: Long count = 12.19.14.17.18; tzolkin = 9 Etznab; haab = 6 Muan
In-Reply-To: <478D79BD.7060006@talkingspider.com> (fromlists@talkingspider.com's message of "Tue, 15 Jan 2008 22:27:57 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70622>

>>>>> "Mike" == Mike  <fromlists@talkingspider.com> writes:

Mike> I'm learning git and I'm really annoyed that the .git directory lives in
Mike> the same directory as my code.  I don't want it there for three reasons:

Mike> 1. My code lives on a development web server docroot, and I don't want
Mike> the .git repository to end up getting published to the live site by
Mike> accident. (I would imagine this would be a common need.)

Sounds like you need an installer... something that copies your repo into the
live location with things you don't want included left out, and all the
permissions and ownership correct.

Mike> 2. If I tar/gz my code and deliver it to a client, I don't want the .git
Mike> dir slipping into the tarball, allowing my client to be able to peruse
Mike> the history of what we did and when.

git archive --help

Mike> 3. The .git respository will get big, especially with binary files in
Mike> it, and I want it someplace with a lot of disk space. And I don't want
Mike> it to get tarred up when we migrate the site to a different server. (And
Mike> tar isn't aware of hard links is it? wonderful.)

An installer helps here too.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
