From: "David Tweed" <david.tweed@gmail.com>
Subject: [ANNOUNCE] simple chronological versioning script
Date: Mon, 8 Jan 2007 20:48:01 +0000
Message-ID: <e1dab3980701081248k420dffa1ke258fef600acc2c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 08 21:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H41Qv-0004XE-N8
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 21:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbXAHUsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 15:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbXAHUsL
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 15:48:11 -0500
Received: from nz-out-0506.google.com ([64.233.162.239]:6217 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422741AbXAHUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 15:48:04 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3826982nze
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 12:48:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HtMdlD3actw2u/a8R/U6w/MvppBrlgIF9iqWTAcFpOjL8gxCcYOTiCpeGDmeNJc8kQ93E4ojFHchyBbTu09tnnYF1yt3rYytHqEdNlWLesdDSeRG8PPTAVkvD0nD5S8SaUTm2IFAlNVG/hFLjWFjZrB98NYxtP4GMnSrVUGB6Lo=
Received: by 10.65.137.15 with SMTP id p15mr36062944qbn.1168289281667;
        Mon, 08 Jan 2007 12:48:01 -0800 (PST)
Received: by 10.65.160.13 with HTTP; Mon, 8 Jan 2007 12:48:01 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36279>

This is just to announce the release of a simple chronological
versioning script using git as a back end. I wrote this basically
for my personal use, and its a very simple script that I don't
expect any more development on it (except minor bugfixes).
I'm just making this generally available in case anyone else
finds what is does useful. (I _believe_ it now deals with cases
of vanishing and reappearing files correctly in all cases,
but I may have missed some cases.)

>From the man-page:
  chronoversion is a simple python script which attempts to use the git
  content tracker to provide chronological snapshots similar to
  Plan 9's venti filesystem. The two differences are that, being based
  on git, it isn't a filesystem in the sense of needing kernel support
  to gain access to the data (so it can be used on systems where
  you can only install userspace programs) and it allows programatic
  decisions about what to snapshot, rather than recording everything
  into the snapshot.

  It also allows all the git functionality, eg, git-daemon network
  access, git-diff, etc, to be used on the database of snapshots.

  chronoversion has been designed so that, if desired, different areas
  of the user's filespace can be stored in different .git databases with
  their own snapshotting rules. This might be
  useful to, eg, track both work-restricted and personal files on the
  same machine. (It merely allows this, making no judgement if this
  is a good thing to do.)

It can be downloaded (at least currently) from

http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.tgz

If you have any comments or improvements feel free
to email me at david DoT tweed aT gmail DoT com.

-- 
cheers, dave tweed__________________________
david DoT tweed aT gmail DoT com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould
