From: "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk>
Subject: Error when pushing
Date: Wed, 7 May 2008 16:02:46 +0100
Message-ID: <4B58A837F454E14AA0453EDBADE96A62B5F606@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 17:05:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtlBJ-0000zm-F5
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758755AbYEGPC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 11:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758645AbYEGPC4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:02:56 -0400
Received: from mail.leeds-art.ac.uk ([195.195.164.241]:37622 "EHLO
	mildred.leeds-art.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757622AbYEGPCy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 11:02:54 -0400
Received: (qmail 31219 invoked from network); 7 May 2008 15:02:52 -0000
Received: from 17.130.10.172.in-addr.arpa (HELO mildred.leeds-art.ac.uk) (172.10.130.17)
  by 0 with SMTP; 7 May 2008 15:02:51 -0000
X-ECSC-UBE-ID: 31213.1210172571.1
X-ECSC-UBE-IP: 172.10.130.17
X-MimeOLE: Produced By Microsoft Exchange V6.5
x-cr-hashedpuzzle: E0Kf FdvS Frpe Gs4J HHDb Hz56 IrZi IuiH Jksg J1Pq J6/9 KlLH K4kF LYR4 MOig MQS0;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{D14699A1-1C76-45B5-9566-6F24825BB435};cgB5AGEAbgAuAHQAYQB5AGwAbwByAEAAbABlAGUAZABzAC0AYQByAHQALgBhAGMALgB1AGsA;Wed, 07 May 2008 15:02:46 GMT;RQByAHIAbwByACAAdwBoAGUAbgAgAHAAdQBzAGgAaQBuAGcA
Content-class: urn:content-classes:message
x-cr-puzzleid: {D14699A1-1C76-45B5-9566-6F24825BB435}
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Error when pushing
Thread-Index: AciwU1m6Kyxw41j+T1KtKP8woWzADAAAAWTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81444>

Hi,=20

I'm getting the following error when pushing from my dev box to my live=
 box:

ryant@brewster:/gittest$ git push ryan@bert:/webdata/gittest/
ryan@bert's password:
updating 'refs/heads/master'
=A0 from 60d4194d6d5647f1c18fb7235754984bd4e5a8d9
=A0 to=A0=A0 97c26890703c1f08e02623e4e84a40e4ca0e0a1e
Generating pack...
Done counting 4 objects.
Result has 3 objects.
Deltifying 3 objects...
=A0100% (3/3) done
Writing 3 objects...
=A0100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
*** Project description file hasn't been set
error: hooks/update exited with error code 1
error: hook declined to update refs/heads/master
ng refs/heads/master hook declined
error: failed to push to 'ryan@bert:/webdata/gittest/'

Can anybody shed any light?

Cheers

Ryan
