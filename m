From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] Add glossary that can be converted into a po file for
	each language.
Date: Tue, 24 Jul 2007 11:34:35 +0200
Message-ID: <20070724113435.gd8xunvbk8o4wsss@webmail.tu-harburg.de>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707212150.49351.stimming@tuhh.de>
	<7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
	<200707232216.40300.stimming@tuhh.de>
	<7vk5sqi91m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:34:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGn2-0004Ku-Ta
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbXGXJeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760024AbXGXJeq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:34:46 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:42644 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985AbXGXJep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 05:34:45 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6O9YZhM011582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 24 Jul 2007 11:34:36 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6O9YZVT018454;
	Tue, 24 Jul 2007 11:34:35 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id A2D19E50349; Tue, 24 Jul 2007 11:34:35 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Tue, 24 Jul 2007
	11:34:35 +0200
In-Reply-To: <7vk5sqi91m.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53548>

Quoting Junio C Hamano <gitster@pobox.com>:
>> +++ b/po/glossary/git-gui-glossary.txt
>> @@ -0,0 +1,34 @@
>> +"English Term (Dear translator: This file will never be visible to  
>>  the user!)"	"English Definition (Dear translator: This file will   
>> never be visible to the user! It should only serve as a tool for   
>> you, the translator. Nothing more.)"
>> +"amend"	""
>> +"annotate"	""
>> +"branch [noun]"	"A 'branch' is an active line of development."
>> +"branch [verb]"	""
>> +"checkout [noun]"	""
>> +"checkout [verb]"	"The action of updating the working tree to a   
>> revision which was stored in the object database."
>> +"commit [noun]"	"A single point in the git history."
>
> I wonder.... couldn't this be written as a Tcl array that maps
> word to its definition, marked with [mc] 'gettext'ese, perhaps,
> glossary.tcl?  Then perhaps git-gui can include it and have a
> user-visible glossary as part of its help system.

I'm not so sure about this idea. I'd expect the glossary definitions  
for the translators to emphasize other issues than what a user-visible  
glossary would explain. For the user, the glossary should explain what  
each term means and what the user can *do* with this. For the  
translator, the glossary should explain what each term means and where  
it appears in the project (and which other terms it should be  
distinguished from). Also, the translator glossary IMHO should collect  
warnings about potential ambiguities as well (including the very clear  
distinction between noun and verb). Whereas the user glossary is  
probably much more verbose in what it explains, but doesn't emphasize  
as much the clear differences between verb and noun and so on.

> Am I dreaming, or too drunk?

You tell me :-)

Christian
