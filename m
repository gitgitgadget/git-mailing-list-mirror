From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Something strange has happened to my git HEADs.
Date: Sat, 15 Mar 2008 19:44:29 +0100
Message-ID: <m3ve3n3jzm.fsf@maximus.localdomain>
References: <m38x0j51bw.fsf@maximus.localdomain>
	<7vwso3n8i5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 19:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JabNh-0003PP-2F
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 19:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYCOSod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYCOSod
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 14:44:33 -0400
Received: from khc.piap.pl ([195.187.100.11]:56522 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbYCOSoc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 14:44:32 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id DA769659F3; Sat, 15 Mar 2008 19:44:29 +0100 (CET)
In-Reply-To: <7vwso3n8i5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 15 Mar 2008 11\:32\:18 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77337>

Junio C Hamano <gitster@pobox.com> writes:

>> lrwx 1      30 2007-10-09 00:55 config -> ~/scm/linux-2.6/config
>> lrwx 1      35 2007-08-24 18:33 description -> ~/scm/linux-2.6/description
>> -rw- 1     126 2008-02-01 21:39 FETCH_HEAD
>> lrwx 1      19 2008-03-15 17:52 HEAD -> refs/heads/eelogger
>> -rw- 1 2220597 2008-03-15 17:56 index
>> drwx 2    4096 2008-03-15 17:57 info
>> -rw- 1   21482 2008-03-15 17:57 info/refs
>> lrwx 1      28 2007-08-24 18:33 logs -> ~/scm/linux-2.6/logs
>> lrwx 1      31 2007-08-24 18:33 objects -> ~/scm/linux-2.6/objects
>> -rw- 1      41 2008-03-15 17:56 ORIG_HEAD
>> -rw- 1   17909 2008-03-15 17:56 packed-refs
>> lrwx 1      28 2007-08-24 18:33 refs -> ~/scm/linux-2.6/refs
>
> This is wrong.  How did you set this up initially?

By hand, I'm using that from the beginning (with some incremental
changes). Are only info and packed-refs missing?

> If you are putting a work tree by symlinking contents of its .git
> directory, info and packed-refs are alsy symlinked.

Info seems to have been dropped somehow or maybe never linked in this
directory, but it's not a problem unless I see it again. I just didn't
know about packing references, linking packed-refs made it work.

How about the error message? Seems serious, though git-rebase did its
work.
-- 
Krzysztof Halasa
