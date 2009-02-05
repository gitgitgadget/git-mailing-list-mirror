From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 06/11] Implement basic customizable label decorations
 with preferences
Date: Thu, 05 Feb 2009 21:21:58 +0100
Message-ID: <498B4A66.9020108@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-6-git-send-email-torarnv@gmail.com> <1233795618-20249-7-git-send-email-torarnv@gmail.com> <200902052102.00409.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVAl5-0006Y8-UI
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 21:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756052AbZBEUWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 15:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756083AbZBEUWH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 15:22:07 -0500
Received: from qb-out-0506.google.com ([72.14.204.227]:12674 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbZBEUWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 15:22:04 -0500
Received: by qb-out-0506.google.com with SMTP id q18so282256qba.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=24To0zpLEsafs4qKJVd8kpl2q/Eao5cZowTrn0XkxVI=;
        b=RYx9OpmzpI3bDOjUgrS07MNVCoqNpTKvykVzP5Y/uLTcl74fr07QKVkJy2iQe/UQZg
         e5Kyj/22x++ndhKbdJKQRcr/PHWlegZJZI7ntrflRXwpcrDtQbIsvdFgq5xCKUCew0ty
         Cjm7ArjUtvto6aENloPj2fRX9DPCkCKKiru4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PwVx4HusAsdIDG7sftoH24DvnzD5UPVkRNTJ18X+zxn2/I/hetxZmDQF7mxS4innQB
         Yn3bzHzocuZxQ0tXwLyRwPZIxWBhNpTuOoMJa8IRekx932PaJCv2EKVG5feckuGdrKPt
         y2lRfOLoDrbZ9HhYjwyeV0u2dWhP5dyYowrI4=
Received: by 10.103.160.3 with SMTP id m3mr386188muo.25.1233865322583;
        Thu, 05 Feb 2009 12:22:02 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id y6sm1189586mug.27.2009.02.05.12.22.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 12:22:02 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200902052102.00409.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108608>

Robin Rosenberg wrote:
> torsdag 05 februari 2009 02:00:13 skrev Tor Arne Vestb=F8:
>> Currently the only binding available is the resource name, but
>> this commit enables a framework for adding more bindings.
>=20
> The size of the components of the page is wrong forcing unnecessary s=
crollbars.

Argh, I've been battling those layouts on Linux, but though it was
finally fixed. On Windows the dialog looks fine. I'll investigate furth=
er.

> The terms use should probably have a cleared explanation/definition=20
> and the same terms used for the flags/icons. The explanation could
> probably be done using longer tooltips.

Noted.

> I miss the red attention-gathering red conflict icon we had.

Happy to replace. If I remember correctly that's the symbol used by
other plugins to indicate conflicts, so I was aiming for consistency an=
d
recognizability.

> I also have a hard time distinguishing the staged/added/removed icons
> without reading glasses. The decorations are only 1.3 mm on my=20
> screen (150 dpi), so I think the icons should have different colors
> and different shapes instead of a few different pixels withing a
> square box.>

Noted, I'll try to make some mocukups of variations to the icons.

> I'd also like to see the conflict state for files inherited by parent
> folder and projects.

Good idea, like the synchronize view shows it. Noted.

> The checkboxes in the general tab have no effect on the preview.

True. Should be easy to fix.

Thanks for the feedback!

Tor Arne
