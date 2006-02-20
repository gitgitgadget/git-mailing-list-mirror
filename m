From: Paul Jakma <paul@clubi.ie>
Subject: Re: [PATCH] Makefile tweaks: Solaris 9+ dont need iconv / move up
 uname variables
Date: Mon, 20 Feb 2006 23:53:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0602202347410.31425@sheen.jakma.org>
References: <Pine.LNX.4.64.0602202335020.31425@sheen.jakma.org>
 <7v3bid8umq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 00:52:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBKpG-0001gB-F5
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 00:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbWBTXwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWBTXwO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 18:52:14 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:19332 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S964853AbWBTXwN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 18:52:13 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX18FYo8eGCNV8ej8LTqDi0XZz/I34YxMpY8@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k1KNpuN2011880;
	Mon, 20 Feb 2006 23:52:08 GMT
X-X-Sender: paul@sheen.jakma.org
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bid8umq.fsf@assigned-by-dhcp.cox.net>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16511>

On Mon, 20 Feb 2006, Junio C Hamano wrote:

> The latter two makes sense to me.

Yeah, it's handy for installs to shared volumes, e.g. I like to set 
bindir to $(prefix)/arch/$(uname_P)/bin.

> I'd appreciate independent confirmations from people with Solaris 8 
> and/or Solaris 9 boxes.

Seems wise ;).

Note that it doesn't change things for S8. Also, I've tested this on 
Solaris 10 and fairly recent Solaris dev snapshots (snv_31). I didn't 
try a test compile on S9, however I did check on an S9u7 box and 
there is no libiconv to link against.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
"Ada is the work of an architect, not a computer scientist."
- Jean Icbiah, inventor of Ada, weenie
