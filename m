From: Thomas Wichern <nordertom@gmx.de>
Subject: Re: git 1.7.10.msysgit.1: different behaviour in ".gitignore" and ".git/info/exclude"
Date: Wed, 30 May 2012 12:52:33 +0200
Message-ID: <799289647.20120530125233@gmx.de>
References: <96434119.20120530104356@gmx.de> <4FC5F661.6090105@viscovery.net>
Reply-To: Thomas Wichern <nordertom@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git-mailing <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 30 12:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZgW8-00083b-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 12:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2E3Kwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 06:52:36 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:48948 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752425Ab2E3Kwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 06:52:36 -0400
Received: (qmail invoked by alias); 30 May 2012 10:52:34 -0000
Received: from unknown (EHLO w7-wic.gdsdom.inet) [80.150.227.58]
  by mail.gmx.net (mp071) with SMTP; 30 May 2012 12:52:34 +0200
X-Authenticated: #35162558
X-Provags-ID: V01U2FsdGVkX18vEMMT+QEveOQ56i0WhNtBSxZOIt5Y6PXk2KjXLI
	EEIbRi/HBfZ7Hw
X-Priority: 3 (Normal)
In-Reply-To: <4FC5F661.6090105@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198796>

Hi Hannes,

thanks a lot - it was my fault and you're right.
It works with "(*)/" very well!

Horrido,
Thomas


> Am 5/30/2012 10:43, schrieb Thomas Wichern:
>> If you have a ".gitignore" - file that contains the pattern "/(*)/", a
>> directory that matches the pattern is ignored completely.
>> 
>> If you put the same pattern into the ".git/info/exclude" - file, the
>> pattern does not work - these directories still show up.
>> 
>> I expected that all directories anywhere the repository that match the
>> pattern to be ignored.

> The first slash in the pattern means: Match only in this directory, not in
> subdirectories. For patterns in .git/info/exclude, "this directory" is the
> top-level of the repository.

>> Am I doing something wrong? Is the pattern not correct?

> Perhaps you need "(*)/", i.e., without the first slash.

> -- Hannes
