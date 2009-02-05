From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu, 05 Feb 2009 17:17:15 +0100
Message-ID: <498B110B.5040304@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <20090205160625.GI26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7BS-0004ks-I9
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZBEQdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 11:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbZBEQdI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:33:08 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:14686 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZBEQdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:33:06 -0500
Received: by fg-out-1718.google.com with SMTP id 16so224955fgg.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=R2Q2L73x00e8DD8vg6DmyRfwESe6ZNjEldeVwdqtwoM=;
        b=E/HR3JvefknbSu7xhdy9JI9VM5y3e60GMFY1JeY0bei5O7zYQoTB7BW8e9vsRT0RY/
         KYkuh/O/F0v5pTQdYpzRDgTHeKGvFVg3rCPIY1cwD0waYoSzcOcizl3R60R8GzplXKf1
         y0rkIBkfrfh+2bTf6TNrVYBkHgtlIWj6pn2yo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=tjugf77mpajJpwBDOBiIOPPZ2JwXvvV18iMEBA/64/yam4RGauz3hDvnWLLzVs4ARq
         +Zbja63qKqKnjRso+p1h+z+Z0lh8I3+egaHYcc2b0OaHrMhmdnWorzeyxt4jGZul0RSi
         mas0IpxAXCXpbbS0E0YknBV4chR7XkmgIngDM=
Received: by 10.86.51.2 with SMTP id y2mr440624fgy.10.1233850638221;
        Thu, 05 Feb 2009 08:17:18 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d4sm718369fga.38.2009.02.05.08.17.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 08:17:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090205160625.GI26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108577>

Shawn O. Pearce wrote:
> Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
>> This series adds support for customizable label decorations, which
>> is usefull for hiding selected decorations, or tweaking the format
>> of the decoration text.
>=20
> Aside from my two remarks about the synchronized collections,
> I like it.=20

Thanks :)

> There's no display for "added and dirty", aka doing:

That's a bug, should work the same as "staged and dirty", with [*] >,
I'll look into it.

>> Known issues are:
>>
>>   - If a project has a repository more than one level above the
>>     project directory decorations will fail.
>=20
> I'd like to see this fixed in the near-ish future, but I don't
> think its blocking to merging your patches.

Yepp, It's on my list. This series is basically the minimum feature-set
I could produce that has most of what the current decorators have, so I
 could get a basis landed.

>>   - When a Java resource is dirty, each parent package in the
>>     package hierarcy will appear dirty, even when the layout is
>>     set to 'flat'.
>=20
> Bah.  I've seen the Java compiler error marks also report like this.
> I don't think its our issue.  But maybe I'm wrong.

The CVS plugin handles this -- possibly through the TeamStateProvider
and friends -- so it is possible. Something to look at.

Tor Arne
