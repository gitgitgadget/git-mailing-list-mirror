From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] git-gui wording suggestions
Date: Fri, 27 Jul 2007 13:42:19 +0200
Message-ID: <20070727134219.wjkkfyg0g888ooss@webmail.tu-harburg.de>
References: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de>
	<20070727044009.GF20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 13:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEODR-0000DZ-8O
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 13:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934465AbXG0Lmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 07:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765629AbXG0Lmh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 07:42:37 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:34254 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759553AbXG0Lmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 07:42:36 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6RBgKDS013758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 27 Jul 2007 13:42:20 +0200
Received: from webmail.tu-harburg.de (ocs3.rz.tu-harburg.de [134.28.202.66])
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6RBgKQC012257;
	Fri, 27 Jul 2007 13:42:20 +0200
Received: by webmail.tu-harburg.de (Postfix, from userid 1001)
	id E5B25E50349; Fri, 27 Jul 2007 13:42:19 +0200 (CEST)
Received: from hansjoerg.sick.de (hansjoerg.sick.de [62.180.123.245]) by
	webmail.tu-harburg.de (Horde MIME library) with HTTP; Fri, 27 Jul 2007
	13:42:19 +0200
In-Reply-To: <20070727044009.GF20052@spearce.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53918>

Quoting "Shawn O. Pearce" <spearce@spearce.org>:
>> Unifiy wording to say "to stage" instead of "to add" always.
> ...
>> With this patch I'd propose to talk every only about "stage" instead
>> of "add". IMHO that's just the logical conclusion of the above wording
>> decision. What do you think?
>
> Yes, I agree.  This is a necessary change, the current wording is
> very confusing.  I would apply this earlier than the other i18n
> stuff, but this patch is written based upon the current i18n work.
> :-|

Well, of course I have supplied this patch on top of the current i18n  
markup work... on the other hand, back-porting the string changes to  
the non-i18n code means that the i18n changes themselves won't merge  
anymore. For that reason I wouldn't suggest to apply this separately  
from the i18n commits, unless you would want to adapt the i18n patches  
as well.

I'd rather suggest to consider the i18n changes rather soon by now,  
even if the actual translations will be merged later. The [mc...]  
calls itself don't change the behaviour of the application, so I don't  
think it would be very risky do merge them sooner than later.  
Eventually, that's of course up to you.

Christian
