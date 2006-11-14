X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bhavesh Davda" <bhavesh@vmware.com>
Subject: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Tue, 14 Nov 2006 12:55:16 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701A11D63@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7082F.2FB22B3E"
NNTP-Posting-Date: Tue, 14 Nov 2006 20:55:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Thread-Index: AccILxcdf3W0JUjKQIOUo7t+V8sjPg==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31374>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk5JY-0004Kf-TT for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966352AbWKNUzT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 15:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966258AbWKNUzT
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:55:19 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:39104 "EHLO
 mailout1.vmware.com") by vger.kernel.org with ESMTP id S966354AbWKNUzQ (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:55:16 -0500
Received: from mailhost2.vmware.com (mailhost.vmware.com [10.16.64.160]) by
 mailout1.vmware.com (Postfix) with ESMTP id 8FC4E6018 for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 12:55:33 -0800 (PST)
Received: from PA-EXCH03.vmware.com (pa-exch-node04.vmware.com
 [10.16.64.143]) by mailhost2.vmware.com (Postfix) with ESMTP id 2EB4790549
 for <git@vger.kernel.org>; Tue, 14 Nov 2006 13:00:59 -0800 (PST)
To: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7082F.2FB22B3E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Noticed this when trying to use qgit on Linus's kernel git repository. =
The
script git-status depends on git-runstatus being in the path.

Adding git-runstatus to the PROGRAMS list in the Makefile, so that it =
gets
installed along with the other git executables.

After a "sudo make install", qgit is now happy, since git-status is now =
able
to find git-runstatus in /usr/bin.

Thanks

- Bhavesh

Bhavesh P. Davda



------_=_NextPart_001_01C7082F.2FB22B3E
Content-Type: application/octet-stream;
	name="git-makefile.patch"
Content-Transfer-Encoding: base64
Content-Description: git-makefile.patch
Content-Disposition: attachment;
	filename="git-makefile.patch"

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggMzZjZThjZC4uMjRhMGRjNyAx
MDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTIwMiw3ICsyMDIsNyBAQCBQ
Uk9HUkFNUyA9IFwKIAlnaXQtdXBsb2FkLXBhY2skWCBnaXQtdmVyaWZ5LXBhY2skWCBcCiAJZ2l0
LXBhY2stcmVkdW5kYW50JFggZ2l0LXZhciRYIFwKIAlnaXQtZGVzY3JpYmUkWCBnaXQtbWVyZ2Ut
dHJlZSRYIGdpdC1pbWFwLXNlbmQkWCBcCi0JZ2l0LW1lcmdlLXJlY3Vyc2l2ZSRYIFwKKwlnaXQt
bWVyZ2UtcmVjdXJzaXZlJFggZ2l0LXJ1bnN0YXR1cyRYIFwKIAkkKEVYVFJBX1BST0dSQU1TKQog
CiAjIEVtcHR5Li4uCg==

