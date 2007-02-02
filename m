From: Giorgos Keramidas <keramida@ceid.upatras.gr>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 20:27:10 +0200
Message-ID: <20070202182709.GA3861@kobe.laptop>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<200702010058.43431.jnareb@gmail.com>
	<20070201003429.GQ10108@waste.org>
	<200702021055.49428.jnareb@gmail.com>
	<slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
	<epvnln$fmn$1@sea.gmane.org>
	<Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
	<20070202175923.GA6304@xanadu.kublai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: torvalds@linux-foundation.org, jnareb@gmail.com, mercurial@selenic.com,
        git@vger.kernel.org
X-From: mercurial-bounces@selenic.com Fri Feb 02 19:31:47 2007
Return-path: <mercurial-bounces@selenic.com>
Envelope-to: gcvmd-mercurial@gmane.org
Received: from waste.org ([66.93.16.53])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD3CN-0001kl-Bc
	for gcvmd-mercurial@gmane.org; Fri, 02 Feb 2007 19:31:47 +0100
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l12IG7Je014996;
	Fri, 2 Feb 2007 12:16:10 -0600
Received: from igloo.linux.gr (igloo.linux.gr [62.1.205.36])
	by waste.org (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	l12IFx5N014965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <mercurial@selenic.com>; Fri, 2 Feb 2007 12:16:04 -0600
Received: from kobe.laptop ([194.30.196.125]) (authenticated bits=128)
	by igloo.linux.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l12IROHF008225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 2 Feb 2007 20:27:30 +0200
Received: from kobe.laptop (kobe.laptop [127.0.0.1])
	by kobe.laptop (8.13.8/8.13.8) with ESMTP id l12IRB0V003889;
	Fri, 2 Feb 2007 20:27:22 +0200 (EET)
	(envelope-from keramida@ceid.upatras.gr)
Received: (from keramida@localhost)
	by kobe.laptop (8.13.8/8.13.8/Submit) id l12IRA1X003888;
	Fri, 2 Feb 2007 20:27:10 +0200 (EET)
	(envelope-from keramida@ceid.upatras.gr)
Content-Disposition: inline
In-Reply-To: <20070202175923.GA6304@xanadu.kublai.com>
X-Hellug-MailScanner: Found to be clean
X-Hellug-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-3.732, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.47, BAYES_00 -2.60, DNS_FROM_RFC_ABUSE 0.20)
X-Hellug-MailScanner-From: keramida@ceid.upatras.gr
X-Spam-Status: No
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38523>

On 2007-02-02 09:59, Brendan Cully <brendan@kublai.com> wrote:
>On Friday, 02 February 2007 at 08:42, Linus Torvalds wrote:
>> Tags are *independent* of history. They must be. They are "outside"
>> history, since the whole point of tags are to point to history.
>
> Tags have history too. They are added at particular times by
> particular people, and sometimes changed (this wouldn't happen in an
> ideal world, but it happens). It's a shame not to be able to find this
> history.

Agreed.  There is a _reason_ behind the -f option of 'cvs tag'.

Sometimes, 'sliding a tag' is a real-world need.  Losing the information
of who did the tag sliding and when, is not good.
