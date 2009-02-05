From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 06/11] Implement basic customizable label decorations
 with preferences
Date: Thu, 05 Feb 2009 22:00:36 +0100
Message-ID: <498B5374.1030305@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-6-git-send-email-torarnv@gmail.com> <1233795618-20249-7-git-send-email-torarnv@gmail.com> <200902052102.00409.robin.rosenberg@dewire.com> <498B4A66.9020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBMS-0004ET-9U
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZBEVAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 16:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZBEVAn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:00:43 -0500
Received: from mail-ew0-f33.google.com ([209.85.219.33]:44655 "EHLO
	mail-ew0-f33.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZBEVAm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:00:42 -0500
X-Greylist: delayed 17001 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 16:00:41 EST
Received: by ewy14 with SMTP id 14so783527ewy.18
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Ktc4q2rEPfmWUuQEcnjG1fkU1cFWxhiwhtBJbAHj/p4=;
        b=W8DPo+JXOwdGLf20HWbzvGg37AHkoWFoLnp+hCb097GRCfEu6GGn5pZ5H0G7odX219
         w/cvPEc2ktBi/cOTIi3/eCiZTVVAhBTZ7UsjIXBFPGBHgfCr+OfJEprCnLDH9VsfLSUY
         Zu3FTkgLAW8ktOWIzMGMWml5pLNLP7E4J0L5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KliYEdFbvq+tu74nWZzisznXUJ1+rP9pLonqFt5YVz6YFoniNky/2+K1kmaEe1RI4X
         3OP7LLc4aa0thRQPLei9cOWEv2YiTW1a428pmBfy+hJ8GCUdLmwUn8QqQcrSI0U7hRs5
         YtBQkA0wC+nKBUkHGAbI3qHJCjJtYS4s393Ig=
Received: by 10.103.214.13 with SMTP id r13mr399271muq.37.1233867640057;
        Thu, 05 Feb 2009 13:00:40 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id y6sm1253795mug.27.2009.02.05.13.00.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 13:00:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498B4A66.9020108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108620>

Tor Arne Vestb=F8 wrote:
>> I miss the red attention-gathering red conflict icon we had.
>=20
> Happy to replace. If I remember correctly that's the symbol used by
> other plugins to indicate conflicts, so I was aiming for consistency =
and
> recognizability.

Okey, I've replaced the blue one with the default conflict icon from th=
e
team org.eclipse.team.ui plugin, what can be more consistent then that?
:) See mockup below.

>> I also have a hard time distinguishing the staged/added/removed icon=
s
>> without reading glasses. The decorations are only 1.3 mm on my=20
>> screen (150 dpi), so I think the icons should have different colors
>> and different shapes instead of a few different pixels withing a
>> square box.>
>=20
> Noted, I'll try to make some mocukups of variations to the icons.

Here are two alternatives. The first one (A) uses the same icons as
before, but adds red and green shading. The second one (B) uses the
green plus sign for added (which is used all over the place in Eclipse
to mean 'added'), and the gray x for removed (which is also used all
over the place in Eclipse for that same concept).

http://img443.imageshack.us/img443/5138/egitmockupmm7.png

I favor solution B, as it uses recognizable concepts from the existing
Eclipse UI, plus that having a red removed-icon conflicts too much with
the conflict-icon (pun intended). There's also a very similar red icon
in JDT that indicates that something needs fixing (a red medic kit),
which is another reason to go with solution B.

What do you say?

Tor Arne

>=20
>> I'd also like to see the conflict state for files inherited by paren=
t
>> folder and projects.
>=20
> Good idea, like the synchronize view shows it. Noted.
>=20
>> The checkboxes in the general tab have no effect on the preview.
>=20
> True. Should be easy to fix.
>=20
> Thanks for the feedback!
>=20
> Tor Arne
