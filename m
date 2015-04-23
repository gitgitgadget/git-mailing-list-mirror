From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Tweak the 2.4.0 release notes and related docs
Date: Thu, 23 Apr 2015 14:27:45 +0200
Message-ID: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlGEf-0005l3-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934421AbbDWM2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2015 08:28:01 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56089 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934406AbbDWM17 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:27:59 -0400
X-AuditID: 1207440d-f79976d000005643-bc-5538e54d70d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 81.EA.22083.D45E8355; Thu, 23 Apr 2015 08:27:57 -0400 (EDT)
Received: from michael.fritz.box (p4FC97208.dip0.t-ipconnect.de [79.201.114.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3NCRsfJ011822
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 23 Apr 2015 08:27:56 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1PV9ahFqcPUFt0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfMb/Io+M5W8XDSY8YGxlOs
	XYycHBICJhIPexawQ9hiEhfurWcDsYUELjNKvD6hCmEfZ5L4tlAbxGYT0JVY1NPMBGKLCKhJ
	TGw7xAJiMws4SGz+3MgIYgsLOEucfb0DzGYRUJX4v/UsWA2vgIvEnTdPoXbJSZw//pMZIi4o
	cXLmE6AaDqA56hLr5wlBjJSXaN46m3kCI98sJFWzEKpmIalawMi8ilEuMac0Vzc3MTOnODVZ
	tzg5MS8vtUjXSC83s0QvNaV0EyMkBHl3MP5fJ3OIUYCDUYmH1yHPIlSINbGsuDL3EKMkB5OS
	KO/Zm0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrx7bgPleFMSK6tSi/JhUtIcLErivGpL1P2E
	BNITS1KzU1MLUotgsjIcHEoSvIpPgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLi
	QREXXwyMOZAUD9De449B9hYXJOYCRSFaTzHqctyZ8n8RkxBLXn5eqpQ4rwTIDgGQoozSPLgV
	sITzilEc6GNhXm2QKh5gsoKb9ApoCRPQkplLwZaUJCKkpBoYS0sVI1X3CUWXPO+3ZC/6VmV1
	2sPzFxvbr3lcx5VY1Sa9vZ943OdE5q/drSvs11l8Od2XeTdd5dv8tmWet87Ft7o++XZ0gbZ6
	SdWtf2ZNsaxLA1MO2184PK/TMy10LUPYNP/8kDR9p/B3ctpeEgzLmTWyO1S3H7kt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267685>

Patches 1 and 2 add some manpage documentation for features mentioned
in the release notes that were not adequately documented.

Patches 3 and 4 correct a couple of concrete problems in the release
notes.

Patch 5 is a sm=C3=B6rg=C3=A5sbord of suggested stylistic changes to th=
e release
notes. Feel free to pick and choose the ones that you think are
improvements.

Michael Haggerty (5):
  status: document the -v/--verbose option
  git tag: mention versionsort.prereleaseSuffix in manpage
  RelNotes: correct name of versionsort.prereleaseSuffix
  RelNotes: refer to the rebase -i "todo list", not "insn sheet"
  RelNotes: wordsmithing

 Documentation/RelNotes/2.4.0.txt | 338 ++++++++++++++++++++-----------=
--------
 Documentation/git-status.txt     |   9 ++
 Documentation/git-tag.txt        |  11 +-
 3 files changed, 189 insertions(+), 169 deletions(-)

--=20
2.1.4
