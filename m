From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 11:06:53 -0400
Organization: Highrise Community Network
Message-ID: <20070518151044.2FC05111E33@yugib.highrise.ca>
References: <200705170539.11402.andyparkins@gmail.com> <200705180857.18182.andyparkins@gmail.com> <200705181043.09203.Josef.Weidendorfer@gmx.de> <200705181021.30062.andyparkins@gmail.com> <20070518110804.GD4708@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Nicolas Pitre <nico@cam.org>,
	Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 17:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp4PX-0000dl-8L
	for gcvg-git@gmane.org; Fri, 18 May 2007 17:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbXERPaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbXERPaW
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 11:30:22 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:33916 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbXERPaV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 11:30:21 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 2FC05111E33;
	Fri, 18 May 2007 11:10:44 -0400 (EDT)
User-Agent: KNode/0.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47616>

Michael S. Tsirkin wrote:

>> Quoting Andy Parkins <andyparkins@gmail.com>:
>> Subject: Re: [3/4] What's not in 1.5.2 (new topics)
>> 
>> On Friday 2007 May 18, Josef Weidendorfer wrote:
>> 
>> > It all depends on how we construct the default URL out of the
>> > subproject identifier. Options:
>> > (1) do not try to construct a default URL at all. Error out without a
>> > config (2) use a configurable rewriting scheme like
>> > s/(.*)/git://host/\1/ (3) automatically detect a senseful rewriting
>> > scheme
>> >
>> > Let's start with (1). We can invent convenient default schemes later
>> > on.
>> 
>> All good; except let's start with
>> 
>>  (1) if no config, try using the key itself - error out if that fails
>> 
>> Then everybody is happy - if you want to use your system where the key is
>> not
>> a URL, then don't - you'll get the error you want.  If the user chose to
>> use a URL then magic will happen.
> 
> I don't want an error. No one wants an error.
> 
> I want to be able to clone a super project, a subproject,
> and use my copy of both instead of the original - including
> cloning my copy, pulls between such clones, being able to verify
> that they are identical.
> 
> What I *don't* want is a situation where the fact that original repository
> resides in north america necessarily means that everyone who looks at *my*
> clone of it will do a round trip to north america too.

Again - if *I* create a project, and decide to use a particular key for a
subproject, then good.  If *you* create a project and decide to use a
particular key for a subproject, then good. 

If you clone *my* superproject, you get *my* choice of key.  If I clone
*your* superproject, I get *your* choice of key.

The fact that I can choose a URL as my key is in no way influencing the fact
that you can choose to *not* use a URL for your key.

And if if you want to "copy" my project, but "change" the key for the
subproject, that's something you can too to!  In GIT, that's a branch.
