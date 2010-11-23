From: Philippe Lhoste <PhiLho@GMX.net>
Subject: Re: vcs for hefty video and graphics files
Date: Tue, 23 Nov 2010 11:37:46 +0100
Message-ID: <icg5ia$5an$1@dough.gmane.org>
References: <877hg55iyd.fsf@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: info-cvs@gnu.org, mercurial@selenic.com, git@vger.kernel.org,
	users@tomcat.apache.org
To: bazaar@lists.canonical.com
X-From: bazaar-bounces@lists.canonical.com Tue Nov 23 11:38:30 2010
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1PKqGc-0004gq-7A
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 23 Nov 2010 11:38:30 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.69)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1PKqGQ-0003N3-Hh; Tue, 23 Nov 2010 10:38:18 +0000
Received: from lo.gmane.org ([80.91.229.12])
	by chlorine.canonical.com with esmtp (Exim 4.69)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1PKqGO-0003Mx-UD
	for bazaar@lists.canonical.com; Tue, 23 Nov 2010 10:38:17 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvbg-bazaar-ng@m.gmane.org>) id 1PKqGN-0004cm-L2
	for bazaar@lists.canonical.com; Tue, 23 Nov 2010 11:38:15 +0100
Received: from mycomadmin-6-206.cnt.nerim.net ([213.215.6.206])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <bazaar@lists.canonical.com>; Tue, 23 Nov 2010 11:38:15 +0100
Received: from PhiLho by mycomadmin-6-206.cnt.nerim.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <bazaar@lists.canonical.com>; Tue, 23 Nov 2010 11:38:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: mycomadmin-6-206.cnt.nerim.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr;
	rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
In-Reply-To: <877hg55iyd.fsf@newsguy.com>
X-Topics: everythingelse
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161941>

On 22/11/2010 19:09, Harry Putnam wrote:
> Which of the main contenders:  cvs subversion mercurial git bizarre
> Maybe  a few more I don't know about, would be the best candidate for
> the usage and user described

bizarre? Never heard of this VCS before...

 > Each project would only run a month or 2 months at the most and then
 > all but the final delivered version would be deleted.  That version
 > might be keep for a yr or so.

Maybe it is pure heresy, but since all you want is to keep temporarily several very big 
and nearly incompressible files where diffs (or deltas?) are probably not significant, I 
would advance that a VCS won't be very useful here.
Advantages of VCS are (among others):
- make delta of changes to keep as little data as possible
- compress this data (?)
- keep changes indefinitely to be sure to have them when we need them
- share and merge (changes from somebody else, or you elsewhere)
Unless I missed something, these advantages doesn't seem to apply there.

Some game makers keep track of their (large) binary files, along with the rest of the 
project (source code). Rarely in isolation.
Perforce and PlasticSCM both boast superior support of these files, I won't comment on 
these allegations (over other VCS), just having no experience here.

Somehow, in your case, the good old way of keeping copies renamed to keep the version (or 
kept in specific directories) might work for you... Perhaps along with a small text file 
with comments on content of each file.

PS.: I don't see why you included Tomcat list...

-- 
Philippe Lhoste
--  (near) Paris -- France
--  http://Phi.Lho.free.fr
--  --  --  --  --  --  --  --  --  --  --  --  --  --
