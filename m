From: Markus Schiltknecht <markus@bluegap.ch>
Subject: Re: cvs import
Date: Wed, 13 Sep 2006 23:04:13 +0200
Message-ID: <4508724D.2050701@bluegap.ch>
References: <45084400.1090906@bluegap.ch>	
	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dev@cvs2svn.tigris.org, monotone-devel@nongnu.org,
	Jon Smirl <jonsmirl@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Wed Sep 13 23:04:31 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbuC-0006e6-9E
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 23:04:24 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNbuB-0002yY-VT
	for gcvmd-monotone-devel@m.gmane.org; Wed, 13 Sep 2006 17:04:23 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNbu7-0002xc-Qm
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 17:04:19 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNbu5-0002xC-Db
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 17:04:18 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNbu5-0002x7-7N
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 17:04:17 -0400
Received: from [213.133.111.57] (helo=bugaboo.mu)
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA:24) (Exim 4.52) id 1GNbvs-0000T7-HJ
	for monotone-devel@nongnu.org; Wed, 13 Sep 2006 17:06:08 -0400
Received: from [192.168.77.23] (p54BD9EF0.dip0.t-ipconnect.de
	[::ffff:84.189.158.240]) (AUTH: CRAM-MD5 markus@bluegap.ch)
	by bugaboo.mu with esmtp; Wed, 13 Sep 2006 23:04:14 +0200
	id 008A9968.4508724E.000040F9
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26944>

Martin Langhoff wrote:
> On 9/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>> Let's copy the git list too and maybe we can come up with one importer
>> for everyone.
> 
> It's a really good idea. cvsps has been for a while a (limited, buggy)
> attempt at that. One thing that bothers me in the cvs2svn algorithm is
> that is not stable in its decisions about where the branching point is
> -- run the import twice at different times and it may tell you that
> the branching point has moved.

Huh? Really? Why is that? I don't see reasons for such a thing happening 
when studying the algorithm.

For sure the proposed dependency-resolving algorithm which does not rely 
on timestamps does not have that problem.

Regards

Markus
