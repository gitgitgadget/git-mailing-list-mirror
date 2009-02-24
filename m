From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT] [PATCH v1 1/1] Add an ignored icon
Date: Tue, 24 Feb 2009 10:23:47 +0100
Message-ID: <49A3BCA3.8010201@gmail.com>
References: <cover.1235415747.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtOO-0007DW-4k
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZBXJOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 04:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbZBXJO3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:14:29 -0500
Received: from hoat.troll.no ([62.70.27.150]:58373 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579AbZBXJO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:14:28 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 5BB8920F8D;
	Tue, 24 Feb 2009 10:14:21 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 4799920B59;
	Tue, 24 Feb 2009 10:14:21 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n1O9EKqK012071;
	Tue, 24 Feb 2009 10:14:20 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 24 Feb 2009 10:14:20 +0100 (CET)
In-Reply-To: <42268.77.61.241.211.1235455860.squirrel@hupie.xs4all.nl>
References: <ec97c536d418f465befba2a7f30f82f0d75004f8.1235415747.git.ferry.huberts@pelagic.nl>
References: <49A33862.90507@gmail.com>
References: <49A38282.8020308@pelagic.nl>
References: <42268.77.61.241.211.1235455860.squirrel@hupie.xs4all.nl>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111246>

=46erry Huberts (Pelagic) wrote:
> On Tue, February 24, 2009 06:15, Ferry Huberts (Pelagic) wrote:
>> Tor Arne Vestb=F8 wrote:
>>> Ferry Huberts wrote:
>>>> Add an ignored icon to the label decorations page and make
>>>> sure that it is actually decorated: from now on do not ignore
>>>> ignored resources during decoration.
>>> The reason this was not added in the original series was because th=
at's
>>> kind of the point of ignoring a resource -- you don't want any
>>> information about it. Also, none of the other team plugins provide
>>> decorations for ignored resources-
>>>
>> I could also argue that I want everything to be explicit, even the
>> status of ignored files :-)

That's a reasonable argument :) I'm not really opposed to the feature -=
-=20
I was just trying to think of reasons why it might not be such as good=20
idea, just to be safe and have that discussion. But you are right.

Acked-by: Tor Arne Vestb=F8 <torarnv@gmail.com>

>> If you look at (for example) TortoiseSVN then you'll see that it doe=
s
>> provide an ignore icon. My icon was sort of 'inspired' by that one.
>> Don't know if it's on by default though, will have to check that.
>=20
> I just checked, TortoiseSVN has the overlay for ignored items on by d=
efault

The difference is TortoiseSVN does not come with a set of global defaul=
t=20
ignored files (as far as I know). Eclipse does, see Team->Ignored...

So, a globally ignored file such as foobar.BAK would show up as=20
non-decorated if shared using the CVS or SVN plugins, but with an icon=20
if shared with Git. That might be confusing to users, especially since=20
the minus-sign icon does not have any history in Eclipse as something=20
being "ignored" (it actually breaks the convention of using=20
non-decoration -- meaning no "untracked"-icon -- to signal ignored).

So, I would still argue that we should leave it off by default.

Tor Arne
