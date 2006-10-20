From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 13:47:27 -0400
Message-ID: <45390BAF.5040405@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca> <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 19:47:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GayT2-0005el-95
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992527AbWJTRrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992528AbWJTRrd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:47:33 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:54681 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S2992527AbWJTRrc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 13:47:32 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaySv-000376-00; Fri, 20 Oct 2006 13:47:29 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29510>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Fri, 20 Oct 2006, Aaron Bentley wrote:
> 
>>All solutions have disadvantages.  We prefer the disadvantages that come
>>from using file-ids over the disadvantages that come from using
>>content-based rename detection.
> 
> 
> That's fine, but please don't call the git rename handling "maybe" or 
> "partial", like a lot of people seem to do. 
> 
> Git _definitely_ handles renames, both in everyday life and when merging.

Hmm.  Could you say more here?  The only examples I can think of for
handling renames are situations that can be expressed as a merge.

For example, populating a working tree can be expressed as:
BASE: nothing
THIS: nothing
OTHER: aabbccddee

Or revert can be expressed as

BASE: current
THIS: current
OTHER: aabbccddee

Or fast-forward pull

BASE: last-commit
THIS: current
OTHER: aabbccddee

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOQuv0F+nu1YWqI0RAotBAKCEEzvh1Cc2jJH4NIEBwoYrDJlbUQCgiPBF
DZ4+hSbkjbvgOwbT4+oLzFA=
=wSgK
-----END PGP SIGNATURE-----
