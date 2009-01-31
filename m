From: Brian Moran <bmoran@onehub.com>
Subject: Re: Bus Error- git merge
Date: Fri, 30 Jan 2009 16:05:52 -0800
Message-ID: <C5A8D5E0.E29D%bmoran@onehub.com>
References: <alpine.DEB.1.00.0901301950100.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 31 01:07:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT3OP-0005Lh-4e
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZAaAF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 19:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbZAaAF7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 19:05:59 -0500
Received: from server515f.exghost.com ([72.32.253.82]:4823 "EHLO
	server515.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752137AbZAaAF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 19:05:58 -0500
Received: by server515.appriver.com (CommuniGate Pro PIPE 5.2.7)
  with PIPE id 124060404; Fri, 30 Jan 2009 18:05:56 -0600
Received: from FE3.exchange.rackspace.com ([72.32.49.36] verified)
  by server515.appriver.com (CommuniGate Pro SMTP 5.2.7)
  with ESMTP id 124060398; Fri, 30 Jan 2009 18:05:52 -0600
Received: from 34093-C5-EVS1.exchange.rackspace.com ([192.168.1.96]) by FE3.exchange.rackspace.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 18:05:53 -0600
Received: from 69.84.249.99 ([69.84.249.99]) by 34093-C5-EVS1.exchange.rackspace.com ([192.168.1.105]) via Exchange Front-End Server owa.mailseat.com ([192.168.1.53]) with Microsoft Exchange Server HTTP-DAV ;
 Sat, 31 Jan 2009 00:05:53 +0000
User-Agent: Microsoft-Entourage/12.12.0.080729
Thread-Topic: Bus Error- git merge
Thread-Index: AcmDN63avd7LSpzr6E+Y5rJ+qWRZcA==
In-Reply-To: <alpine.DEB.1.00.0901301950100.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 31 Jan 2009 00:05:54.0018 (UTC) FILETIME=[AF0E9C20:01C98337]
X-Policy: GLOBAL - onehub.com
X-Policy: GLOBAL - onehub.com
X-Primary: bmoran@onehub.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: bmoran@onehub.com ALLOWED
X-Virus-Scan: V-
X-Note: Spam Tests Failed: 
X-Country-Path: UNITED STATES->PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.49.36
X-Note-Reverse-DNS: 
X-Note-WHTLIST: bmoran@onehub.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 94 95 96 97 101 102 170 
X-Note: Mail Class: ALLOWEDSENDER
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107890>

With subsequent changes to the merged-to repository, the bug does not
manifest. I will attempt to reproduce when we encounter it next.
=20


On 1/30/09 10:57 AM, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
wrote:

> Hi,
>=20
> On Fri, 30 Jan 2009, Brian Moran wrote:
>=20
>> I am getting a bus error on a git merge, including the more recent v=
ersions.
>> Following the instructions from a bug August, I got the latest sourc=
es,
>> compiled them up, and executed the merge in the debugger to repro. H=
ere=B9s
>> what I found:
>=20
> Is it possible that your branch has submodules?
>=20
