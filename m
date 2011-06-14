From: Edmondo Porcu <Edmondo.Porcu@gottexbrokers.com>
Subject: RE: Objects deleted before first commit
Date: Tue, 14 Jun 2011 14:46:00 +0000
Message-ID: <8269100C7056D24A91B672AF7E5E48492D963B@exchange.GottexBrokers.local>
References: <8269100C7056D24A91B672AF7E5E48492D959E@exchange.GottexBrokers.local>
	<BANLkTikSPNVbGFRUVh5eSFsxabVWT7SVVA@mail.gmail.com>
	<8269100C7056D24A91B672AF7E5E48492D95BB@exchange.GottexBrokers.local>
	<BANLkTik1jTq6otRvHwbo342oH7Dwy+vs_w@mail.gmail.com>
 <BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: PJ Weisberg <pjweisberg@gmail.com>,
	David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 16:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWUsc-0007B3-AU
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1FNOqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:46:05 -0400
Received: from webmail.gottexbrokers.com ([212.203.71.151]:29624 "EHLO
	Edge.gottexbrokers.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab1FNOqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 10:46:03 -0400
Received: from exchange.GottexBrokers.local (212.203.71.150) by
 Edge.gottexbrokers.com (212.203.71.151) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Tue, 14 Jun 2011 16:46:01 +0200
Received: from exchange.GottexBrokers.local ([fe80::2516:9680:eb73:c7b9]) by
 exchange.GottexBrokers.local ([fe80::2516:9680:eb73:c7b9%12]) with mapi id
 14.01.0218.012; Tue, 14 Jun 2011 16:46:01 +0200
Thread-Topic: Objects deleted before first commit
Thread-Index: Acwqj7T+SjxTfmyrQwaDHlzYRmVyZAAANDGQ///ixwD//95WEIAAJDIAgAAbLID//948oA==
In-Reply-To: <BANLkTin9_jfvtYdCsJLiWAoOvO2e1f=9SA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.11.12.203]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175775>

Dear all,
I have tried to copy my objects folder into my git root folder.

D:\vce\GottwareNet>git cat-file -p 00\1cd91a8a3a3c99ca7aea73c96b3d2174430947
fatal: Not a valid object name 00\1cd91a8a3a3c99ca7aea73c96b3d2174430947

D:\vce\GottwareNet>ls 00\1cd91a8a3a3c99ca7aea73c96b3d2174430947
00\1cd91a8a3a3c99ca7aea73c96b3d2174430947

Please help me we are talking about thousands of line of code!!! :(

Edmondo Porcu
Financial  software architect



Avenue de Rhodanie 48
1007 Lausanne
Switzerland.

Dir  +41 (0) 21  560 30 82
Fax +41 (0) 21  617 71 55
Email : edmondo.porcu@gottexbrokers.com

The information in this email is confidential and may be legally privileged. If you are not the intended recipient, you must not read, use or disseminate the information. Although this email and any attachments are believed to be free of any virus or other defect that might affect any computer system into which it is received and opened, it is the responsibility of the recipient to ensure that it is virus free and no responsibility is accepted by the Gottex Group of Companies for any loss or damage arising in any way from its use.


-----Original Message-----
From: PJ Weisberg [mailto:pjweisberg@gmail.com] 
Sent: mardi 14 juin 2011 16:44
To: David Barr
Cc: Edmondo Porcu; git@vger.kernel.org
Subject: Re: Objects deleted before first commit

On Tuesday, June 14, 2011, David Barr <davidbarr@google.com> wrote:
> On Tue, Jun 14, 2011 at 11:00 PM, Edmondo Porcu
> <Edmondo.Porcu@gottexbrokers.com> wrote:
>> dangling blob 43cb00bb9f23b73afc874c4105b136f8c426e4a5
>> dangling blob 48ef642adb1549ee1d4040ec9337d3a47c19d422
> [...]
>
> Was it 'rm -rf' or 'git rm -rf'?
> If just the non-git command, maybe 'git checkout -- <missing paths>'?

Not if it was never checked in, unfortunately.

'git cat-file -p <hash>' prints the contents of the file.  It's up to
you to figure out which is the version you want and what the filenames
were.

-- 

-PJ

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
