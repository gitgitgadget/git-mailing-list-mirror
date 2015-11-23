From: Matthew Leach <M.Leach@derby.ac.uk>
Subject: Best practice setup for github projects on server
Date: Mon, 23 Nov 2015 11:19:00 +0000
Message-ID: <8A5E5D5720EB7347BF290277F0C633F8010C7E55DFB4@MKT-MBX01.university.ds.derby.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 12:26:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0pG6-0000O5-PZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 12:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbbKWL0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 06:26:07 -0500
Received: from mail1.bemta3.messagelabs.com ([195.245.230.164]:30878 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752460AbbKWL0G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 06:26:06 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2015 06:26:05 EST
Received: from [85.158.138.179] by server-4.bemta-3.messagelabs.com id 20/0B-09570-E26F2565; Mon, 23 Nov 2015 11:19:10 +0000
X-Env-Sender: M.Leach@derby.ac.uk
X-Msg-Ref: server-4.tower-169.messagelabs.com!1448277532!5873099!51
X-Originating-IP: [193.60.149.223]
X-StarScan-Received: 
X-StarScan-Version: 7.19.2; banners=derby.ac.uk,-,-
X-VirusChecked: Checked
Received: (qmail 19024 invoked from network); 23 Nov 2015 11:19:10 -0000
Received: from dmz-edg01.derby.ac.uk (HELO dmz-edg01.University.ds.derby.ac.uk) (193.60.149.223)
  by server-4.tower-169.messagelabs.com with RC4-SHA encrypted SMTP; 23 Nov 2015 11:19:10 -0000
Received: from MKT-HUB02.university.ds.derby.ac.uk (10.31.101.42) by
 dmz-edg01.derby.ac.uk (193.60.149.223) with Microsoft SMTP Server (TLS) id
 8.3.389.2; Mon, 23 Nov 2015 11:19:02 +0000
Received: from MKT-MBX01.university.ds.derby.ac.uk ([10.31.101.37]) by
 MKT-HUB02.university.ds.derby.ac.uk ([10.31.101.42]) with mapi; Mon, 23 Nov
 2015 11:19:01 +0000
Thread-Topic: Best practice setup for github projects on server
Thread-Index: AdEl4KXkEkhHtuO3QdOZM3Hq95C3mg==
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281579>

Hi,

I was hoping that somebody could give me advice since I'm new to git.

I'll be installing a couple of projects from github on our servers, and=
 adding some features.

Should I create a repository on our server (e.g. in /opt/git/), add the=
 github project as a remote, and create a branch?  Then on my local mac=
hine add our server as the remote and then pull / push with that?

On the server there will be two web directories: stable and dev.  I was=
 planning for these to be branches, and then just pull from the server =
repository using the local protocol.

I think it would mean sorting out merge actions on the server.  I'm hop=
ing to be able to fetch and integrate updates from the developer's gith=
ub repository, but without making things more complicated than they nee=
d to be.

Does anyone have any suggestions?  I drew a diagram if it helps (https:=
//drive.google.com/file/d/0B7JhUXLbxPT9RkVNMUV6cjJNVnc/view?usp=3Dshari=
ng)

Thanks

Matthew


Matthew Leach=A0
BSc. PhD. PGCert. FHEA
Innovation Developer

Academic Innovation Hub
Room 107, Enterprise Centre, 37 Bridge Street, Derby, DE1 3LD

The University of Derby has a published policy regarding email and rese=
rves the right to monitor email traffic. If you believe this was sent t=
o you in error, please select unsubscribe.

Unsubscribe and Security information contact:   infosec@derby.ac.uk
=46or all FOI requests please contact:   foi@derby.ac.uk
All other Contacts are at http://www.derby.ac.uk/its/contacts/
