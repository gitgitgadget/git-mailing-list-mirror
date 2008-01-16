From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 23:18:49 -0500
Message-ID: <478D85A9.6050807@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzkF-0002uD-Uj
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbYAPESv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbYAPESv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:18:51 -0500
Received: from relay00.pair.com ([209.68.5.9]:1865 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751484AbYAPESv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:18:51 -0500
Received: (qmail 39223 invoked from network); 16 Jan 2008 04:18:50 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 04:18:50 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70620>


David Symonds wrote:
> On Jan 16, 2008 2:27 PM, Mike <fromlists@talkingspider.com> wrote:
>> 2. If I tar/gz my code and deliver it to a client, I don't want the .git
>> dir slipping into the tarball, allowing my client to be able to peruse
>> the history of what we did and when.
> 
> Use git-archive.
> 

Thanks but this isn't sufficient. If we have one directory of our web 
root in a git repository, say docroot/php, and we tar up docroot, it 
will include php/.git.  We don't want that.  We would have to go out of 
our way to avoid the .git directory.  The point is, we don't want 
anything in docroot that shouldn't be made live.
