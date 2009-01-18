From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: is gitosis secure?
Date: Sun, 18 Jan 2009 14:25:04 +0100
Message-ID: <87skngoifj.fsf@mid.deneb.enyo.de>
References: <200812090956.48613.thomas@koch.ro>
	<1228813453.28186.73.camel@maia.lan>
	<873afgsul8.fsf@mid.deneb.enyo.de>
	<200901180650.06605.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 14:26:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOXfk-0005q0-Ja
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 14:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbZARNZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 08:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbZARNZI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 08:25:08 -0500
Received: from mail.enyo.de ([212.9.189.167]:49495 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756830AbZARNZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 08:25:07 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1LOXeD-0002Jm-By; Sun, 18 Jan 2009 14:25:05 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1LOXeC-0002lj-US; Sun, 18 Jan 2009 14:25:04 +0100
In-Reply-To: <200901180650.06605.bss@iguanasuicide.net> (Boyd Stephen Smith,
	Jr.'s message of "Sun, 18 Jan 2009 06:50:06 -0600")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106185>

* Boyd Stephen Smith, Jr.:

> On Sunday 18 January 2009, Florian Weimer <fw@deneb.enyo.de> wrote 
> about 'Re: is gitosis secure?':
>>* Sam Vilain:
>>> Restricted unix shells are a technology which has been proven secure
>>> for decades now.
>>Huh?  Things like scponly and rssh had their share of bugs, so I can
>>see that there is some concern.  (And restricted shells used to be
>>circumvented by things like Netscape's print dialog.)
>
> From my understanding, a restricted shell is a difficult thing to escape 
> from unless a user is able to run binaries that they have written.  FWIW, 
> I don't remember sftp or scponly having this particular vulnerability.

scponly issues due to interpretation conflicts:

CVE-2002-1469   scponly does not properly verify the path when finding the (1) scp or ...
CVE-2004-1162   The unison command in scponly before 4.0 does not properly restrict ...
CVE-2005-4533   Argument injection vulnerability in scponlyc in scponly 4.1 and ...
CVE-2007-6350   scponly 4.6 and earlier allows remote authenticated users to bypass ...
CVE-2007-6415   scponly 4.6 and earlier allows remote authenticated users to bypass ...

rssh has fewer such issues, only CVE-2004-1161 seems to be intrinsic
to the program's purpose (but some of the other issues might be used
as circumvention devices, too).

That's why I think it's not totally outlandish to assume that
restricted shells are usually not very helpful for
compartmentalization purposes.
