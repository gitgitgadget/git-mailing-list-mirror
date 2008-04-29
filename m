From: Tom Widmer <tom.widmer@googlemail.com>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 18:08:28 +0100
Message-ID: <fv7kmc$2br$1@ger.gmane.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 19:10:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqtKe-00044b-Mk
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759689AbYD2RIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759670AbYD2RIs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:08:48 -0400
Received: from main.gmane.org ([80.91.229.2]:37987 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbYD2RIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 13:08:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JqtJs-00026I-AS
	for git@vger.kernel.org; Tue, 29 Apr 2008 17:08:44 +0000
Received: from 82.109.240.196 ([82.109.240.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 17:08:44 +0000
Received: from tom.widmer by 82.109.240.196 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 17:08:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82.109.240.196
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <200804281829.11866.henrikau@orakel.ntnu.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80705>

Henrik Austad wrote:
> Hi list!
> 
> As far as I have gathered, the SHA-1-sum is used as a identifier for commits, 
> and that is the primary reason for using sha1.  However, several places 
> (including the google tech-talk featuring Linus himself) states that the id's 
> are cryptographically secure.
> 
> As discussed in [1], SHA-1 is not as secure as it once was (and this was in 
> 2005), and I'm wondering - are there any plans for migrating to another 
> hash-algorithm? I.e. SHA-2, whirlpool..
> 
> [1] http://www.schneier.com/blog/archives/2005/02/cryptanalysis_o.html

Why not wait until the results of:
http://www.csrc.nist.gov/groups/ST/hash/index.html
are available. That will surely be soon enough (I think 2012 is the
expected finish date), and should prevent having to switch again in the
future.

The necessity or otherwise of improving the hashing will be clearer by
then too.

Tom
