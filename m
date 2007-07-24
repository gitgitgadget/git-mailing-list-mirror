From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] Fix translation of strings in foreach lists.
Date: Tue, 24 Jul 2007 17:20:28 +0200
Message-ID: <20070724172028.mdfuj6fpeokw0800@webmail.tu-harburg.de>
References: <1282.25717.qm@web38901.mail.mud.yahoo.com>
	<20070724112701.ndpm5fxaocks804s@webmail.tu-harburg.de>
	<20070724150136.GM32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 17:21:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDMCK-00067j-Ef
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 17:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406AbXGXPUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 11:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbXGXPUy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 11:20:54 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:55681 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbXGXPUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 11:20:53 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6OFKS9j006971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Jul 2007 17:20:28 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6OFKSbG009447;
	Tue, 24 Jul 2007 17:20:28 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id 667BDE50349; Tue, 24 Jul 2007 17:20:28 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Tue, 24 Jul 2007
	17:20:28 +0200
In-Reply-To: <20070724150136.GM32566@spearce.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53608>

Quoting "Shawn O. Pearce" <spearce@spearce.org>:
>> >I not sure if it's worth changing, but you don't necessarily need
>> >those [append]'s in there.
>>
>> Thanks for the info. It is basically up to Shawn to decide which style
>> he likes more.
>
> "[mc Foo]\n\n$err"
>
> is much shorter.  So I'd prefer that over [append [mc Foo] "\n\n$err"].

Err, but the usual case is that the argument to [mc] is more than one  
word, and (additionally) that argument has to be quoted by  
double-quotes (as opposed to braces) because otherwise xgettext  
doesn't extract the message correctly. Hence, the only possibility  
here were

   "[mc "Some Text"]\n\n$err"

Is this valid Tcl? Being a newcomer to this language I have to says  
the quotes here look rather strange :-)

> Its not like you've saved a dq-eval either, as you still have to do one
> for the \n\n.  But either way is valid Tcl, and works, and the append
> version is not so bad that I'd reject a patch that used it.

Ok, thanks.

Christian
