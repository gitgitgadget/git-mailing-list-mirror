From: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 21:36:39 +0200
Message-ID: <462521C7.2050103@softax.com.pl>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 17 21:54:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdtkx-0004Xq-BG
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 21:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbXDQTyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 15:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbXDQTyT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 15:54:19 -0400
Received: from bozon2.softax.com.pl ([83.238.10.48]:47970 "EHLO
	bozon2.softax.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161140AbXDQTyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 15:54:18 -0400
X-Greylist: delayed 1141 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Apr 2007 15:54:18 EDT
Received: from bozon2.softax.pl (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 78791DC00A
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 21:35:16 +0200 (CEST)
Received: from 127.0.0.1 (127.0.0.1)
 by bozon2.softax.pl (F-Secure/fsigk_smtp/488/bozon2.softax.pl);
 Tue, 17 Apr 2007 21:35:16 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/488/bozon2.softax.pl)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 5FC8BDC00E
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 21:35:16 +0200 (CEST)
Received: from bozon2.softax.com.pl ([127.0.0.1])
 by localhost (bozon2.softax.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17630-06 for <git@vger.kernel.org>;
 Tue, 17 Apr 2007 21:35:15 +0200 (CEST)
Received: from [192.168.1.100] (195-tar-2.acn.waw.pl [212.76.49.195])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 3AAD7DC00A
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 21:35:15 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <20070417173007.GV2229@spearce.org>
X-Virus-Scanned: amavisd-new at softax.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44812>

Let me add some salt. At the moment, there are at least two immediate 
show-stoppers
for using git in many organizations:

a) Windows are unsupported
b) Learning curve is too steep. Unclear relationship git-vs-cogito makes 
it even worse.

Third is also very likely:

c) Lack of reasonable subproject support (plus detailed permission model).

 From tools similar to git, Mercurial performs significantly better (at 
least it works
on Win and is easy to learn, although some GUI would be needed in most cases
before it could be truly implemented).

PS I am in related pos, long years ago I introduced CVS to my org - 
replacing
CMS on VMS, RCS on Unix and manual copies on Win, now I am sensing 
possibilities, but...

PS2 I am not sure whether git aims to handle corporate cases, or even 
whether it should,
those remarks are addressed rather to those who consider using it in 
such situation, than
to those who wrote it.
