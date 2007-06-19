From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Versioning file system
Date: Tue, 19 Jun 2007 18:52:22 +0200
Organization: At home
Message-ID: <f591k5$odb$2@sea.gmane.org>
References: <OF7FA807A1.64C0D5AF-ON882572FE.0061B34C-882572FE.00628322@us.ibm.com> <6E9A6F9E-8948-40F2-9129-1F1491D49D83@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759805AbXFSRB5@vger.kernel.org Tue Jun 19 19:02:12 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759805AbXFSRB5@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0h5h-0008Tl-TZ
	for glk-linux-kernel-3@gmane.org; Tue, 19 Jun 2007 19:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759805AbXFSRB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 19 Jun 2007 13:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbXFSRBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jun 2007 13:01:48 -0400
Received: from main.gmane.org ([80.91.229.2]:51595 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489AbXFSRBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jun 2007 13:01:48 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I0h3i-0004Dz-J5
	for linux-kernel@vger.kernel.org; Tue, 19 Jun 2007 19:00:02 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2007 19:00:02 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2007 19:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50497>

Kyle Moffett wrote:
> On Jun 18, 2007, at 13:56:05, Bryan Henderson wrote:

>>> The question remains is where to implement versioning: directly in =
=A0
>>> individual filesystems or in the vfs code so all filesystems can =A0
>>> use it?
>>
>> Or not in the kernel at all. =A0I've been doing versioning of the =A0
>> types I described for years with user space code and I don't =A0
>> remember feeling that I compromised in order not to involve the =A0
>> kernel.
>>
>> Of course, if you want to do it with snapshots and COW, you'll have =
=A0
>> to ask where in the kernel to put that, but that's not a file =A0
>> versioning question; it's the larger snapshot question.
>=20
> What I think would be particularly interesting in this domain is =A0
> something similar in concept to GIT, except in a file-system
[cut]

How it relates to ext3cow versioning (snapshotting) filesystem,
for example? ext3cow assumes linear history, which simplifies things
a bit.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
