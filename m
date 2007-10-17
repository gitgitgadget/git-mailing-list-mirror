From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 13:51:30 -0400 (EDT)
Message-ID: <BAYC1-PASMTP126D526163BEA68991F905AE9D0@CEZ.ICE>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
    <471476B7.5050105@users.sourceforge.net>
    <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
    <47148F72.1090602@users.sourceforge.net>
    <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> 
    =?ISO-8859-1?Q?=20=04?= =?ISO-8859-1?Q?<B2F6DB0C-4EFE-4?=
    =?ISO-8859-1?Q?C56-8E7A-3182032?= =?ISO-8859-1?Q?0CA02@mit.edu>?=
    <3awb7zw6.fsf@blue.sea.net>
    <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
    <1192565900.6430.16.camel@athena>
    <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> 
    =?ISO-8859-1?Q?=20<?= =?ISO-8859-1?Q?20071017015109=04.?=
    =?ISO-8859-1?Q?303760cc@localho?= =?ISO-8859-1?Q?st.localdomain>?=
    <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
    <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
    <86sl49g1w1.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 19:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiD3y-00083a-73
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 19:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761273AbXJQRvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 13:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763425AbXJQRvh
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 13:51:37 -0400
Received: from bay0-omc2-s29.bay0.hotmail.com ([65.54.246.165]:11686 "EHLO
	bay0-omc2-s29.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760070AbXJQRvg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 13:51:36 -0400
Received: from BAYC1-PASMTP12 ([65.54.191.185]) by bay0-omc2-s29.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Oct 2007 10:51:35 -0700
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 17 Oct 2007 10:52:53 -0700
Received: from apache by linux1.attic.local with local (Exim 4.43)
	id 1IiD3K-0001HY-FH; Wed, 17 Oct 2007 13:51:30 -0400
Received: from 10.10.10.29
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 17 Oct 2007 13:51:30 -0400 (EDT)
In-Reply-To: <86sl49g1w1.fsf@lola.quinscape.zz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 17 Oct 2007 17:52:53.0750 (UTC) FILETIME=[8AD07960:01C810E6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61399>

On Wed, October 17, 2007 12:08 pm, David Kastrup said:

>
> All-space indentation renders the binary delta algorithm git uses for
> compression of packs slow and partly inoperative (all sequences of 16
> spaces share the same finger print, and the number of identical finger
> prints for which the file information is kept is reduced to 64).

You seem to have identified a weakness in Git's design rather than
an argument against using all-space indentation.  Personally I find it
counter-productive and annoying to work in space-indented source code.
But let's be honest, this "issue" is mostly about familiarity and
comfort rather than some deep objective truth.

Sean
