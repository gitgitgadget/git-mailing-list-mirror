From: X H <music_is_live_lg@hotmail.com>
Subject: Git force push fails after a rejected push (unpack failed)?
Date: Tue, 7 Jul 2015 15:45:50 +0200
Message-ID: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:48:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTEF-0002J1-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 15:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411AbbGGNq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2015 09:46:58 -0400
Received: from dub004-omc3s33.hotmail.com ([157.55.2.42]:55434 "EHLO
	DUB004-OMC3S33.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756950AbbGGNpv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jul 2015 09:45:51 -0400
Received: from DUB120-W50 ([157.55.2.7]) by DUB004-OMC3S33.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Tue, 7 Jul 2015 06:45:50 -0700
X-TMN: [Y9a8lEcWKjXDCFVdGZR1wTExeZuF3V1M]
X-Originating-Email: [music_is_live_lg@hotmail.com]
Importance: Normal
X-OriginalArrivalTime: 07 Jul 2015 13:45:50.0532 (UTC) FILETIME=[3C63E840:01D0B8BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273504>

Hi,

I have a remote repository on a network share configured as a file remo=
te.
I have pushed the HEAD of a branch to the remote, then amend the local =
HEAD. I then try to push the HEAD again but it was rejected.
I made multiple attempts and then try to force the push with: $ git pus=
h -f origin branch_name but it failed with message:

remote: error: unable to write sha1 filename objects/d9/4bfb39cd0be7497=
e493bd4045111a7b1158134: Permission denied
remote: fatal: failed to write object
error: unpack failed: unpack-objects abnormal exit
To file://xxx
=A0! [remote rejected] branch_name -> branch_name (unpacker error)
error: failed to push some refs to 'file://xxx'

Sometimes the error is due to a commit sha, sometimes due to a tree sha=
=2E
It seems that after a rejected push some files are not deleted and sinc=
e they are read only on the remote, the next push cannot overwrite them=
=2E

Is it the intended behaviour? I try to reproduce this and it seems it d=
oesn't happen always.

git v2.3.5 (git-for-windows)

Thank you. 		 	   		  