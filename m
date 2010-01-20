From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: Dangerous new server status for deleted files
Date: Wed, 20 Jan 2010 12:16:38 -0800
Message-ID: <4B5764A6.30504@naughtydog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080903000106030908020903"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXh7z-0003uw-OR
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0ATU0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193Ab0ATU0H
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:26:07 -0500
Received: from ironport02a.scea.com ([160.33.44.43]:20772 "EHLO
	ironport02a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab0ATU0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:26:06 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jan 2010 15:26:06 EST
X-IronPort-AV: E=Sophos;i="4.49,312,1262592000"; 
   d="scan'208,223";a="8033278"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport02a.scea.com with ESMTP; 20 Jan 2010 12:16:09 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id EF2CEF017A;
	Wed, 20 Jan 2010 12:16:09 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 Jan 2010 12:16:38 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-OriginalArrivalTime: 20 Jan 2010 20:16:38.0704 (UTC) FILETIME=[78E58300:01CA9A0D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137569>

This is a multi-part message in MIME format.
--------------080903000106030908020903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Our new Perforce server (P4D/NTX64/2009.2/228098 2009/12/16) seems to be 
giving out 'move/delete' instead of the old 'delete' status for files 
that are moved within the repo. Attached is the simple patch to fix it. 
(By the way: How do you "sign off" a patch?) This is urgent, as it will 
corrupt git repos trying to track a Perforce depot.

Thanks,

PKE.

-- 
Pål-Kristian Engstad (engstad@naughtydog.com), 
Lead Graphics & Engine Programmer,
Naughty Dog, Inc., 1601 Cloverfield Blvd, 6000 North,
Santa Monica, CA 90404, USA. Ph.: (310) 633-9112.

"Emacs would be a far better OS if it was shipped with 
 a halfway-decent text editor." -- Slashdot, Dec 13. 2005.



--------------080903000106030908020903
Content-Type: text/plain;
 name="0001-git-p4-Fix-sync-errors-due-to-new-server-version.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-git-p4-Fix-sync-errors-due-to-new-server-version.patch"

RnJvbSBiYmMwY2YyZGJkMzE4ZmFhZjU3MzFiNjg0ZDY3YzViMjEyNmNiMWUwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYWwtS3Jpc3RpYW4gRW5nc3RhZCA8cGFsX2VuZ3N0
YWRAbmF1Z2h0eWRvZy5jb20+CkRhdGU6IFdlZCwgMjAgSmFuIDIwMTAgMTI6MDc6MjEgLTA4
MDAKU3ViamVjdDogW1BBVENIXSBnaXQtcDQ6IEZpeCBzeW5jIGVycm9ycyBkdWUgdG8gbmV3
IHNlcnZlciB2ZXJzaW9uLgoKTmV3IHNlcnZlciBQNEQvTlRYNjQvMjAwOS4yLzIyODA5OCAo
MjAwOS8xMi8xNikgcmVwb3J0cyAnbW92ZS9kZWxldGUnIGluc3RlYWQgb2YgJ2RlbGV0ZScu
IFRoaXMgY2F1c2VzIGZpbGVzIHRoYXQgYXJlCm1vdmVkIHRvIGxlYXZlIHRoZWlyIG9sZCBm
aWxlIGluIGdpdC4gRml4ZWQgYnkgYWRkaW5nIHRoZSBuZXcgc3RhdHVzIHN0cmluZy4KLS0t
CiBjb250cmliL2Zhc3QtaW1wb3J0L2dpdC1wNCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnRy
aWIvZmFzdC1pbXBvcnQvZ2l0LXA0IGIvY29udHJpYi9mYXN0LWltcG9ydC9naXQtcDQKaW5k
ZXggNjMwMzQ0OS4uZWY3YzIzYiAxMDA3NTUKLS0tIGEvY29udHJpYi9mYXN0LWltcG9ydC9n
aXQtcDQKKysrIGIvY29udHJpYi9mYXN0LWltcG9ydC9naXQtcDQKQEAgLTEwODksNyArMTA4
OSw3IEBAIGNsYXNzIFA0U3luYyhDb21tYW5kKToKIAogICAgICAgICAgICAgaWYgaW5jbHVk
ZUZpbGU6CiAgICAgICAgICAgICAgICAgZmlsZXNGb3JDb21taXQuYXBwZW5kKGYpCi0gICAg
ICAgICAgICAgICAgaWYgZlsnYWN0aW9uJ10gbm90IGluICgnZGVsZXRlJywgJ3B1cmdlJyk6
CisgICAgICAgICAgICAgICAgaWYgZlsnYWN0aW9uJ10gbm90IGluICgnZGVsZXRlJywgJ21v
dmUvZGVsZXRlJywgJ3B1cmdlJyk6CiAgICAgICAgICAgICAgICAgICAgIGZpbGVzVG9SZWFk
LmFwcGVuZChmKQogICAgICAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICAgICAg
IGZpbGVzVG9EZWxldGUuYXBwZW5kKGYpCi0tIAoxLjYuNS4yLjYuZ2MzYzFlLmRpcnR5Cgo=
--------------080903000106030908020903--
