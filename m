From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 15:33:31 +0100
Message-ID: <49AA9CBB.1020406@gmail.com>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl>	 <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com>	 <49AA884D.1050806@pelagic.nl>	 <9e4733910903010608u1777f0d4j843f12551154f962@mail.gmail.com>	 <49AA9A05.6010404@gmail.com> <9e4733910903010631p51f9d4a7xddf9d823ff848bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 15:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdmlJ-0007V5-Ty
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 15:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbZCAOdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZCAOdm
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 09:33:42 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:63097 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbZCAOdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 09:33:41 -0500
Received: by fxm24 with SMTP id 24so1656583fxm.37
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nPSo5g3tIAc2PE/ajHaCYidehk/OB5N48KMmggyr7Sk=;
        b=uROxzawIj54GXQ0Fah6o4qWc6rmFsPPMRZLLdUSFLTG3gSByWhooBodJ21/0trkPC5
         WUWecALfn2nE9AKmhQFP37m56IltKveR9q4Fr/XnCh41TJwV/MKr98icNzcCVxqw1uks
         DPxdY53qs62R6g6o6W9Er/XGNdWduf1hpjyVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OgVWpsEXRFwo5v8sfSXMMJKgYljEw/1PiKwqfKbF6RT6Ogw2Si35AMtarpstUKFzX1
         OPgmNtDIkHnOKW7ND4EUL3Jr9LO30eKewNPjNxqxJLBGFnJCnYDQi1dtYgGMCsJkZ4VN
         +oL8QRWMDqZ8dOU2p8ebd1znNWbylTNWvbjTw=
Received: by 10.86.83.2 with SMTP id g2mr2281251fgb.21.1235918018708;
        Sun, 01 Mar 2009 06:33:38 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d6sm6645193fga.2.2009.03.01.06.33.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 06:33:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <9e4733910903010631p51f9d4a7xddf9d823ff848bde@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111848>

Jon Smirl wrote:
> On Sun, Mar 1, 2009 at 9:21 AM, Tor Arne Vestb=F8 <torarnv@gmail.com>=
 wrote:
>> Perhaps we should try to detect if the project is a Java (/JDT) proj=
ect,
>> or otherwise likely to be a "child"-project, where it makes sense to
>> have the repository in the parent directory?
>=20
> My .git got created in my workspace root. Is there ever a case where
> you would want .git in your workspace root? If not, remove this choic=
e
> when the parent directory is the workspace root.

That would be one heuristics to figure out if the option should be
enabled or disabled (or hidden) yes.

Could you open an issue in the issue tracker for this?

    http://code.google.com/p/egit/issues/list

Tor Arne
