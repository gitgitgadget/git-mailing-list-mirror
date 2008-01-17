From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 11:23:14 +0000
Message-ID: <C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org> <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com> <alpine.LSU.1.00.0801171106510.17650@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFSqa-0000gj-JI
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 12:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYAQLXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 06:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbYAQLXS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 06:23:18 -0500
Received: from mail.sl.pt ([212.55.140.13]:59477 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751238AbYAQLXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 06:23:17 -0500
Received: (qmail 22493 invoked from network); 17 Jan 2008 11:23:13 -0000
X-Virus-Status: Clean (0.01542 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.05816 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [10.0.0.128]) (melo@[213.205.66.248])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <win@wincent.com>; 17 Jan 2008 11:23:13 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 213.205.66.248 as permitted sender)
In-Reply-To: <alpine.LSU.1.00.0801171106510.17650@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70849>

Hi,

On Jan 17, 2008, at 11:10 AM, Johannes Schindelin wrote:
> [Jay, don't cull Cc: lists on vger.kernel.org.  I consider it rude.]
>
> On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>
>> El 17/1/2008, a las 6:15, Junio C Hamano escribi=F3:
>>
>>> "Jay Soffian" <jaysoffian+git@gmail.com> writes:
>>>
>>>> So here's what I can see as being useful additions to git:
>>>> ...
>>>> Thoughts (besides "patches welcomed")?
>>>
>>> I think we already discussed a plan to store normalization =20
>>> mapping in
>>> the index extension section and use it to avoid getting confused by
>>> readdir(3) that lies to us.  Is there any more thing that need to b=
e
>>> discussed?
>
> Yes, and I think that a lot of time would have more wisely spent on
> reading that, and trying to implement it, than writing a number of =20
> long
> mails, repeating the _same_ (refuted) points over and over again.

I searched the archives for the posts about normalization and I could =20
not find them, sorry.

Is stringprep (RFC 3454) being proposed as an optional normalization =20
step before lookups in the index?

Best regards,
--=20
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
