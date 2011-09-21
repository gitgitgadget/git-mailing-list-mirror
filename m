From: Timothy Harper <timcharper@gmail.com>
Subject: Re: mac osx
Date: Wed, 21 Sep 2011 07:52:54 -0500
Message-ID: <F4C226A7-768D-4913-A6C1-12411FBA212C@gmail.com>
References: <loom.20110921T002437-246@post.gmane.org> <CAFcyEtiexmE0WMif-eGHe5xMoYv7-8mdXos1qbQBH3g04z0sAg@mail.gmail.com> <CAGdFq_h0VqbZ5W3QVwoQWT63znhpePDFCRE+-n1TqPNztREwkA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Kyle Neath <kneath@gmail.com>, tom smitts <tomsmitts@ymail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 15:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6MQm-0000gI-4u
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 15:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab1IUNBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 09:01:35 -0400
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:51303 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab1IUNBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 09:01:35 -0400
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Sep 2011 09:01:35 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 4F5358062B;
	Wed, 21 Sep 2011 08:52:55 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp26.relay.dfw1a.emailsrvr.com (Authenticated sender: tim-AT-leadtune.com) with ESMTPSA id A7A3B802B5;
	Wed, 21 Sep 2011 08:52:53 -0400 (EDT)
In-Reply-To: <CAGdFq_h0VqbZ5W3QVwoQWT63znhpePDFCRE+-n1TqPNztREwkA@mail.gmail.com>
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181844>


On Sep 21, 2011, at 04:34, Sverre Rabbelier wrote:

> Heya,
> 
> [+timcharper, owner of the git-osx-installer project]
> 
> On Wed, Sep 21, 2011 at 05:40, Kyle Neath <kneath@gmail.com> wrote:
>> On Tue, Sep 20, 2011 at 3:40 PM, tom smitts <tomsmitts@ymail.com> wrote:
>>> Do the git maintainers really think any mac users have
>>>  a clue which git install package to download?  You
>>> put some arcane chipset designation in the package
>>>  name!

Good point, I'll update the description to include "32-bit" and "64-bit"

>>>  Why make mac installers at all?

Why, to install git on the mac, of course. Previous to Xcode 4.0, it wasn't included. It still has value for those that want git on their machine but haven't downloaded and installed the 4gb Xcode package.

>>>  Mac users
>>> know their operating system number, e.g. 10.6.7,
>>> and that's all.

I am a mac user. I know much more than the operating system number.

>>>  I doubt Windows users know any better.

Fair enough.

>>> And I doubt you can find anywhere on a mac that says
>>>  i386 or whatever the heck the other dumb
>>> designation is.

Sure you can. For example:

timcharper@timtheenchanter:~/Desktop $ file /bin/bash 
/bin/bash: Mach-O universal binary with 2 architectures
/bin/bash (for architecture x86_64):	Mach-O 64-bit executable x86_64
/bin/bash (for architecture i386):	Mach-O executable i386


That "dumb designation" is the march (machine architecture). It's a standard to label packages that way in the unix packaging world. I suppose many of us have just grown up knowing that from our experience compiling software.

Based on the way you've approached your complaining, I get the impression you aren't one of those linux users. Perhaps take a deep breath and take some valium for more tact next time? We're volunteers here. I'm trying to make your life better, not more miserable than it already is.

>> 
>> Yikes! That's definitely not good. I'll see what we can do about updating
>> git-scm.com to point to a more reasonable installer for OSX. I haven't clicked
>> that link in a long time and had no idea it was so confusing.
>> 
>> I've created an issue so we can track it, if you'd like to follow along:
>> https://github.com/schacon/gitscm/issues/16
>> 
>> Kyle Neath
>> Director of Design, GitHub

Kyle, I'll put 32-bit and 64-bit in the description. Somebody mentioned linking to the featured download list as well in that issue, that's a good recommendation.

> -- 
> Cheers,
> 
> Sverre Rabbelier

Cheers! Be happy! Go pet a puppy!

Tim