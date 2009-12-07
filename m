From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 0/2] git-add/rm documentation
Date: Mon, 07 Dec 2009 19:26:42 +0100
Message-ID: <4B1D48E2.9020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 19:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHiIO-00039V-J5
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 19:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017AbZLGS0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 13:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757866AbZLGS0k
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 13:26:40 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53610 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857AbZLGS0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 13:26:39 -0500
Received: by ewy19 with SMTP id 19so791269ewy.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=pMUdtMXjMdqBRqrGZroBxSG6fwyfuwSKSMEn3huXEg4=;
        b=B5kxTfwn9+aWqOXhUlWteFzArr2W6vjtzdVTc9TbT7XgdbyxF8iyFsjkFCHbohaBpK
         HW6BNHKwi6clhnKhZv7lHI5Ne48sEb2s7notU5BBfNXXqhnNWFdxsdw4SMNrV/t/bKWn
         2zxhjx4u9/P1DmPd2NVDFDFzaoBuRvVc1zMbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=l2lM7SobbtIFFBWVAzbG9s4dW1JIvZCQPg9v/KjU8MVQL3SfZbvS5xMZjqQY7wJ3eh
         VejJRHFYVOSjd8LWl1rBpIXh1LqoidnBrq1heNi9VRA+fNTVEg9Jn6wjCgWLz010qkLS
         K6p26j75c/lwaMg0+ZjQgU190QjDjC9MIgwqg=
Received: by 10.213.25.79 with SMTP id y15mr324501ebb.74.1260210404586;
        Mon, 07 Dec 2009 10:26:44 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 13sm83928ewy.9.2009.12.07.10.26.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 10:26:43 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134770>

The following patch series can be applied on top
of bg/maint-add-all-doc in 'pu'.


Bj=C3=B6rn Gustavsson (2):
  git-add/rm doc: Consistently back-quote
  git-rm doc: Describe how to sync index & work tree

 Documentation/git-add.txt |   24 +++++++++---------
 Documentation/git-rm.txt  |   59 +++++++++++++++++++++++++++++++++++++=
++++---
 2 files changed, 67 insertions(+), 16 deletions(-)
