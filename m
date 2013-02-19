From: David Wade <DAWAD@statoil.com>
Subject: RE: Is this a bug?
Date: Tue, 19 Feb 2013 10:32:12 +0100
Message-ID: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jZE-0003si-1F
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758572Ab3BSJcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:32:19 -0500
Received: from st-mailscan02.statoil.com ([143.97.143.37]:53672 "EHLO
	st-mailscan02.statoil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758567Ab3BSJcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 04:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=statoil.com; s=dkim; c=relaxed/simple;
	q=dns/txt; i=@statoil.com; t=1361266334; x=1363858334;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iJGAGIJ+xkGSGGmmIS2lJ4BFlXE/GcB44kfZ5vVwzag=;
	b=DEe0RFHDIoAv69EobcD6xDuaSsMugRI425zWtT0PHMl1FiS9w34cTr8/c7c+CFHh
	v0cobfRDsj7kkUbCBROuyPNE0twRHLOFHXcUON+I3saesfmhHLMMNRAt4Ky9uOTe
	NF4KuavNoirq3Be0AFEkLP9GCNKHTKNG9loEnGDmi0A=;
X-AuditID: 8f618f25-b7f8d6d000005772-94-5123469e537d
Received: from st-w570.statoil.net (Unknown_Domain [143.97.237.252])
	by st-mailscan02.statoil.com (Symantec Messaging Gateway) with SMTP id 34.5E.22386.E9643215; Tue, 19 Feb 2013 10:32:14 +0100 (CET)
Received: from st-w568.statoil.net (143.97.97.152) by st-w570.statoil.net
 (143.97.97.154) with Microsoft SMTP Server (TLS) id 8.3.297.1; Tue, 19 Feb
 2013 10:32:13 +0100
Received: from ST-EXCL29.statoil.net ([fe80::84d7:ff32:4aaa:43a2]) by
 st-w568.statoil.net ([fe80::9d4c:f94:f089:6912%12]) with mapi; Tue, 19 Feb
 2013 10:32:13 +0100
Thread-Topic: Is this a bug?
Thread-Index: Ac4OgNckyRhofbCPQh6fW/0V3Fpb9AAAxyxw
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXSn/j2j+48N+VAg7bfohZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4MrYdfEvW8EHjop1B2cwNTDOZu9i5OSQEDCRWH6yhQXCFpO4cG89
	G4gtJHCSUeJ4T04XIxeQvYZRYuGaF6wQzgpGifmXT4JVsQmoSOxddwGom4NDREBfou+CKEiY
	RUBV4u3/VWAlwgLSEjverQSzRQRkJD6sv88KYRtJbL+5F+wIXgE/iTn//jKC2IxAR3w/tYYJ
	xGYWEJe49WQ+E8RxAhJL9pxnhrBFJV4+/scKUS8qcad9PSNEvZ7EjalT2CBsbYllC18zQ8wX
	lDg58wkLxGNyEgd6bzNOYBSdhWTFLCTts5C0z0LSvoCRZRWjZHGJbm5iZk5xcmKegZFecUli
	SX5mjl5yfu4mRnBk9KvuYDy4XvsQowAHoxIPr4eLUqAQa2JZcWXuIUYJDmYlEd75lsqBQrwp
	iZVVqUX58UWlOanFhxilOViUxHlPvD4XICSQnliSmp2aWpBaBJNl4uCUamB0PH1t1tsTpr0X
	gm3c10hKNWxby5zY2XSqP+Jda8gL+3WyeqGdkXmyzV9swwI1qkUM63S2C+dnKBm98lJXWHvl
	3P7npffE1/rvX7jZstT4UUly4ubuM/KeaWtCt2scPDX3+gauKbK/4+/ceZptee5y7Lx/e3W7
	dq1+Fbbe89aF7m+d1S5BsxWVWIozEg21mIuKEwHxO8Z7iAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216581>

Hi,

I wrote a commit message beginning with a hash (#) character, like this: 'git commit -m "#ifdef ...." '

Everything went okay when committing, but then I tried 'git commit -amend' and without editing the commit message I was told I had an empty commit message.

Is this a problem with my text editor (vim 7.2) or git itself? (git version 1.7.2.2 under RedHat 5.8) Or something I'm not supposed to do ;-) ?

Thanks!

David Wade
Analyst, Seismic Imaging Development
ITC SUB RES
Statoil ASA

Mobile: +47 97572157
Email: dawad@statoil.com

Visitor address: Vassbotnen 23, Forus, Norway
Incorporation number: NO 923 609 016 MVA
www.statoil.com
Please consider the environment before printing this e-mail.


-------------------------------------------------------------------
The information contained in this message may be CONFIDENTIAL and is
intended for the addressee only. Any unauthorised use, dissemination of the
information or copying of this message is prohibited. If you are not the
addressee, please notify the sender immediately by return e-mail and delete
this message.
Thank you
