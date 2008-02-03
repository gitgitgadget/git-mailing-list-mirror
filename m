From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 03 Feb 2008 16:08:55 +0100
Message-ID: <vpqodayrsag.fsf@bauges.imag.fr>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
	<87k5lnwvzd.dancerj%dancer@netfort.gr.jp>
	<878x22j1km.dancerj%dancer@netfort.gr.jp>
	<20080203103804.GC323@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 03 16:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLgUa-00026j-H8
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 16:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762529AbYBCPKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 10:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762017AbYBCPKF
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 10:10:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:38490 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760297AbYBCPKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 10:10:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m13F8viD018298
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Feb 2008 16:08:57 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JLgSl-0000mX-Sx; Sun, 03 Feb 2008 16:08:55 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JLgSl-0000HG-PV; Sun, 03 Feb 2008 16:08:55 +0100
In-Reply-To: <20080203103804.GC323@artemis.madism.org> (Pierre Habouzit's message of "Sun\, 03 Feb 2008 11\:38\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 03 Feb 2008 16:08:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72360>

Pierre Habouzit <madcoder@debian.org> writes:

> On Sun, Feb 03, 2008 at 01:00:57AM +0000, Junichi Uekawa wrote:
>> Hi,
>> 
>> 
>> When I was idly googling around for traces of VCS and popularity,
>> noticed that Git is actually pretty popular.  Googling for 'gitweb'
>> and 'viewcvs' and other comparative web-frontend variants floating in
>> the cyberspace I get these number of hits (in rough estimate) :
>> 
>> 10000000 CVS
>> 1000000 SVN
>> 100000 Git
>> 10000 Mercurial / Darcs
>> 1000 Bzr
>> 
>> This is crude, and I'm sure someone else will come up with a better
>> estimate. The point is, when there are so many users, people don't
>> read the lists or the changelog, but rely on manuals, and be surprised
>> with this change.
>
>   http://www.google.com/trends?q=svn%2C+git%2C+mercurial%2C+bzr%2C+darcs&ctab=0&geo=all&date=all&sort=0

Debian's popularity contest gives an idea too:

$ wget 'http://popcon.debian.org/by_inst'
$ head -11 by_inst
#Format
#   
#<name> is the package name;
#<inst> is the number of people who installed this package;
#<vote> is the number of people who use this package regularly;
#<old> is the number of people who installed, but don't use this package
#      regularly;
#<recent> is the number of people who upgraded this package recently;
#<no-files> is the number of people whose entry didn't contain enough
#           information (atime and ctime were 0).
#rank name                            inst  vote   old recent no-files (maintainer)
$ grep -e ' cvs ' -e ' subversion ' -e ' monotone ' -e ' tla ' -e ' mercurial ' -e ' bzr ' -e ' git-core ' -e ' darcs ' by_inst
890   cvs                            22659  4326 12754  5576     3 (Steve Mcintyre)                
940   subversion                     18888  7630  9693  1560     5 (Peter Samuelson)               
2423  git-core                        3720  1858   992   870     0 (Gerrit Pape)                   
3480  mercurial                       1778   410   914   454     0 (Vincent Danjean)               
3989  darcs                           1344   300   936   108     0 (Isaac Jones)                   
4232  bzr                             1198   278   372   548     0 (Debian Bazaar Maintainers)     
4500  tla                             1067   158   830    79     0 (Adam Majer)                    
7363  monotone                         417    96   277    44     0 (Debian Maintainers For Monotone)

That's not far from the first estimation above, except that Debian
users seem to have abandonned CVS a bit quicker than the rest of the
world. Git is still far behind SVN, but also by far the most popular
of free distributed VCS, modulo the fact that 78.42% of statistics are
biaised ;-).

-- 
Matthieu
