From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import
	option]
Date: Fri, 22 Feb 2008 14:14:58 +0100
Message-ID: <47BECAD2.7000401@alum.mit.edu>
References: <47BE167A.4060005@internode.on.net>
	<20080222073228.GF8410@spearce.org>
	<20080222113737.GA18581@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
X-From: bazaar-bounces@lists.canonical.com Fri Feb 22 14:17:04 2008
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSXkw-0002P8-8q
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 22 Feb 2008 14:16:02 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1JSXkP-000202-Rk; Fri, 22 Feb 2008 13:15:29 +0000
Received: from einhorn.in-berlin.de ([192.109.42.8])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <mhagger@alum.mit.edu>) id 1JSXkM-0001zg-2m
	for bazaar@lists.canonical.com; Fri, 22 Feb 2008 13:15:26 +0000
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.142])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	m1MDFFkg000644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Feb 2008 14:15:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.8.1.8pre) Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20080222113737.GA18581@artemis.madism.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74722>

Pierre Habouzit wrote:
> On Fri, Feb 22, 2008 at 07:32:28AM +0000, Shawn O. Pearce wrote:
>> Michael Haggerty of cvs2svn has spent a good amount of time creating
>> a git-fast-import backend to cvs2svn.  Given that cvs2svn is one of
>> the few tools that can read some of the really strange real world
>> CVS trees its good to be able to leverage that work for other systems
>> (SVN, Git, and now Bazaar).
> 
>   /me opens bigs ears and eyes: does this mean that we have an
> incremental importer of CVS based on git-fast-import ?

cvs2svn is robust and uses git-fast-import, but it is *not* incremental.
 Incremental conversion would be fun but it would be a lot of work to
implement in such a way that it works reliably.

Michael
