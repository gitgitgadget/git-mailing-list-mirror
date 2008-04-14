From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 21:13:41 +0200
Message-ID: <4803ACE5.4020502@keyaccess.nl>
References: <47FEADCB.7070104@rtr.ca>	<20080413121831.d89dd424.akpm@linux-foundation.org>	<20080413202118.GA29658@2ka.mipt.ru>	<200804132233.50491.rjw@sisk.pl>	<20080413205406.GA9190@2ka.mipt.ru>	<48028830.6020703@earthlink.net>	<alpine.DEB.1.10.0804131546370.9318@asgard>	<20080414043939.GA6862@1wt.eu>	<20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
	david@lang.hm, Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 21:14:46 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlU6Y-0001Ni-2v
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 21:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYDNTLv (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 15:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbYDNTLu
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 15:11:50 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:42584 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYDNTLt (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 15:11:49 -0400
Received: from [213.51.130.141] (port=60882 helo=mx3.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JlU4n-0003qf-Id; Mon, 14 Apr 2008 21:10:49 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:38577 helo=[192.168.0.3])
	by mx3.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JlU4m-0006nV-3S; Mon, 14 Apr 2008 21:10:49 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <20080413232441.e216a02c.akpm@linux-foundation.org>
X-Spam-Score: -1.0 (-)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79526>

On 14-04-08 08:24, Andrew Morton wrote:

> On Mon, 14 Apr 2008 06:39:43 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:

>> I have a related proposal: let us require all patches to be stamped
>> with Discordian *and* Eternal September dates.  In triplicate.  While
>> we are at it, why don't we introduce new mandatory headers like, say
>> it,
>>
>> X-checkpatch: {Yes,No}
>> X-checkpatch-why-not: <string>
>> X-pointless: <number from 1 to 69, going from "1: does something useful" all
>> the way to "68: aligns right ends of lines in comments">
>> X-arbitrary-rules-added-to-CodingStyle: <number> (should be present if
>> and only if X-pointless: 69 is present).
>>
>> Come to think of that, we clearly need a new file in Documentation/*,
>> documenting such headers.  Why don't we organize a subcommittee^Wnew maillist
>> devoted to that?  That would provide another entry route for contributors,
>> lowering the overall entry barriers even further...
>>
> 
> None of the above was particularly useful.

Does that mean you're not going to take patches that align the right end of 
lines in comments? :-(

Rene.
