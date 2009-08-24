From: Johan Herland <johan@herland.net>
Subject: Re: git list binary and/or non-binary files?
Date: Tue, 25 Aug 2009 00:14:03 +0200
Message-ID: <200908250014.03585.johan@herland.net>
References: <2729632a0908241450m1651c77ata9744058c5d42672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: skillzero@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 00:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfhnr-0002ye-P5
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbZHXWOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbZHXWOF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:14:05 -0400
Received: from smtp.getmail.no ([84.208.15.66]:35817 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753515AbZHXWOE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 18:14:04 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW00K9TJ3G2JD0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 25 Aug 2009 00:14:04 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOW006J2J3FHM30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 25 Aug 2009 00:14:04 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.24.220032
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <2729632a0908241450m1651c77ata9744058c5d42672@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126975>

On Monday 24 August 2009, skillzero@gmail.com wrote:
> Is there a way to list the files git considers binary in a repository
> (and alternatively, the ones it considers text)? I have a large
> repository and I want to fix line endings for text files that were
> accidentally checked in using CRLF and can't just use the file
> extension alone because some files with the same extension may be
> binary and others not (e.g. UTF-8 .strings file is text, but a UTF-16
> .strings file is binary...git already figured out based on the content
> that one is binary).
>
> I thought maybe git ls-files, but I didn't see anything in there I can
> use for binary vs text.

I use the following to list files that contain CRs, but that are not 
considered binary by Git:

  git grep --cached -I -l -e $'\r'

'git help grep' explains all the options...


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
