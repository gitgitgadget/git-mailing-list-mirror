From: jhud7196@artax.karlin.mff.cuni.cz
Subject: Re: Git in a Nutshell guide
Date: Thu, 22 Nov 2007 17:37:14 +0100 (CET)
Message-ID: <60224.194.138.12.144.1195749434.squirrel@artax.karlin.mff.cuni.cz>
References: <1195477504.8093.15.camel@localhost> <fhvs95$5qk$1@ger.gmane.org>
    <20071121194507.GA3569@efreet.light.src>
    <200711212232.33791.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 17:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvFM2-0000oW-KH
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 17:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbXKVQ4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 11:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbXKVQ4X
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 11:56:23 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35485 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXKVQ4X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 11:56:23 -0500
X-Greylist: delayed 1147 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2007 11:56:22 EST
Received: from artax.karlin.mff.cuni.cz (localhost [127.0.0.1])
	by artax.karlin.mff.cuni.cz (Postfix) with ESMTP id 95E9A140186;
	Thu, 22 Nov 2007 17:37:14 +0100 (CET)
Received: from 194.138.12.144
        (SquirrelMail authenticated user jhud7196)
        by artax.karlin.mff.cuni.cz with HTTP;
        Thu, 22 Nov 2007 17:37:14 +0100 (CET)
In-Reply-To: <200711212232.33791.jnareb@gmail.com>
User-Agent: SquirrelMail/1.4.9a
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65831>

> Dnia =B6roda 21. listopada 2007 20:45, Jan Hudec napisa=B3:
>> On Wed, Nov 21, 2007 at 00:57:28 +0100, Jakub Narebski wrote:
>
>>>  2. Git has some historical cruft, including the fact that it began=
 as
>>>     series of low level tools (plumbing) and became proper SCM
>>> (acquired
>>>     proper porcelain) later, what can be even now seen in
>>> documentation...
>
> What I meant here that some of important documentation can be only
> found in plumbing commands man pages.

Yes, that's true. And does indeed make /writing/ the book harder, becau=
se
the information is harder to compile. Fortunately it should not make it
so much harder to read.

>>>  3. Explanation of some features (like object model) would be much
>>> easier
>>>     with some graphics (diagrams etc.), but chosen documentation
>>> format,
>>>     AsciiDoc, doesn't make it easy...
>>
>> I dare to disagree here. Asciidoc supports generating image tags for
>> respective output formats and it really does not look hard. We could
>> have
>> PNGs and if we wanted higher press quality even SVG or EPS and conve=
rt
>> them
>> to PNGs for the HTML version (and use EPS for latex output).
>
> The problem is that 1) language used to generate images must be easy
> to understand and readable in text form (so sources are enough to
> understand); 2) one of the main formats is manpage (although that wou=
ld
> not matter for "Git Guide" / "The Git Book").

Ad 1), I don't think we have to generate the images. For most images
it is easier to just draw them in a vector image editor.

As you say, 2) does not matter for "Git Guide"/"The Git Book". The man
pages will have to do without graphics or with Ascii-art replacements.

> Should we choose PIC? Or perhaps DOT? I can write little MetaPost, bu=
t
> I don't think that would be good format for git diagrams, even if it
> can be converted to PDF, SVG and PNG.

I'd use DOT for things that can be done with it (ie. visualizing
histories) and just hand-draw the rest in SVG (prefered) or PNG
(for illustrations).

--
                                               Jan Hudec <bulb@ucw.cz>
