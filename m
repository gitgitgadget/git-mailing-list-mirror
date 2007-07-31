From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui i18n / 0.9.x plans
Date: Tue, 31 Jul 2007 10:32:28 -0400
Message-ID: <20070731143228.GC20052@spearce.org>
References: <20070731012804.GZ20052@spearce.org> <1E593130-7BBC-488D-88A5-2E16D68614A6@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFsm5-00041P-VU
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 16:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760515AbXGaOcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 10:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760259AbXGaOce
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 10:32:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57820 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759391AbXGaOce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 10:32:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFsls-0004lG-Rl; Tue, 31 Jul 2007 10:32:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4567A20FBAE; Tue, 31 Jul 2007 10:32:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1E593130-7BBC-488D-88A5-2E16D68614A6@yahoo.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54355>

Jean-Fran??ois Veillette <jean_francois_veillette@yahoo.ca> wrote:
> Le 07-07-30 =E0 21:28, Shawn O. Pearce a =E9crit :
> > - UI for cherry-pick/revert
> > - Hunk splitting/selection
>=20
> It would be nice to use the configured external merge tool (git =20
> mergetool) to help here (in my case os-x:opendiff/FileMerge).
> Having a visual diff between
> - the repository and the index
> - the index and the workarea
> - the repository and the workarea

Hmm.  According to the manual[1]:

   opendiff file1 file2 [-ancestor ancestorFile] [-merge mergeFile]

what should be the file1/file2/ancesorFile here?

Another problem is this paragraph:

  opendiff exits immediately after the comparison request has been
  sent to FileMerge.

Uhhhh...  how does git-gui know the user is done and the mergeFile
should be staged?

I'm also on OS X (its my primary development system for git-gui)
so I might consider working on this, but after looking at the
manpage I'm not so sure...


[1] http://developer.apple.com/documentation/Darwin/Reference/ManPages/=
man1/opendiff.1.html

--=20
Shawn.
