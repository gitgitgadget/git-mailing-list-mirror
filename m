From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Updated Swedish translation (514t0f0u).
Date: Thu, 20 Nov 2008 11:33:34 -0800
Message-ID: <20081120193334.GA2932@spearce.org>
References: <20081116215822.GF2932@spearce.org> <Pine.LNX.4.64.0811201047180.1606@ds9.cixit.se> <49254595.7040103@op5.se> <Pine.LNX.4.64.0811201423291.1606@ds9.cixit.se> <49257790.5010105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Mikael Magnusson <mikachu@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 20 20:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3FIh-0005C9-8r
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 20:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbYKTTdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2008 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbYKTTdg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 14:33:36 -0500
Received: from george.spearce.org ([209.20.77.23]:47778 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbYKTTdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 14:33:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C0430381FF; Thu, 20 Nov 2008 19:33:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49257790.5010105@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101470>

Andreas Ericsson <ae@op5.se> wrote:
> Peter Krefting wrote:
>>
>>>> +msgid "Blame History Context Radius (days)"
>>>> +msgstr "Historikkontextradie f=F6r klandring (dagar)"
>>> At least a 100 points in scrabble for "historikkontextradie". How a=
bout
>>> "Historikradie f=F6r klandring (dagar)"?
>>
>> I struggled with this one. I still haven't got the faintest clue wha=
t
>> it is all about, but I have changed it as you suggested...
>
> I *think* it's about how many days to go back when viewing blame outp=
ut
> for the selected file. Shawn, can you enlighten us here?

Yes, exactly.  It tells git-gui what to pass to gitk.  When you are in
the blame viewer you can open a "gitk --since=3D$d.days $commit -- $pat=
h"
window and $d is the property this message names.

--=20
Shawn.
