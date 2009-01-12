From: Andreas Ericsson <ae@op5.se>
Subject: Re: git submodule merge madness
Date: Mon, 12 Jan 2009 14:27:16 +0100
Message-ID: <496B4534.9020809@op5.se>
References: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 14:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMMqS-0004Xe-6X
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 14:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZALN1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 08:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZALN1U
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 08:27:20 -0500
Received: from mail.op5.se ([193.201.96.20]:56966 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbZALN1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 08:27:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 40FD21B800B1;
	Mon, 12 Jan 2009 14:28:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLCeKWyvTDin; Mon, 12 Jan 2009 14:28:10 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5B4241B81512;
	Mon, 12 Jan 2009 14:28:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105341>

Ask Bj=F8rn Hansen wrote:
> Hi,
>=20
> We've (again) replaced a few directories with submodules.  Man, it's=20
> madness!
>=20
> The typical problem is that we get an error trying to merge a=20
> "pre-submodule" branch into master:
>=20
>     fatal: cannot read object 894c77319a18c4d48119c2985a9275c9f588358=
4=20
> 'some/sub/dir': It is a submodule!
> Mark Levedahl wrote an example in July, but I don't think he got any=20
> replies:  http://marc.info/?l=3Dgit&m=3D121587851313303
> Any ideas?   Is there something we can do?    I see a strong correlat=
ion=20
> between adding a new submodule and the number of "git sucks" messages=
 on=20
> our internal IRC server.
>=20

Well, reworking the repository structure (which is essentially what you=
're
doing) should be a flag day. Merge stuff before that and mark it in som=
e
way so that you don't run into the problems you're seeing now.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
