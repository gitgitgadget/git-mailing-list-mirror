From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 15:26:21 +0100
Message-ID: <200812281526.22152.markus.heidelberg@web.de>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <200812280024.59096.markus.heidelberg@web.de> <7vr63tb1i2.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 15:27:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGwcK-00053M-Eg
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 15:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbYL1O0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 09:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYL1O0U
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 09:26:20 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:58351 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYL1O0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 09:26:19 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id BA902F84431D;
	Sun, 28 Dec 2008 15:26:18 +0100 (CET)
Received: from [91.19.28.232] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LGwav-0000AX-00; Sun, 28 Dec 2008 15:26:17 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7vr63tb1i2.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18xJxwykcPYmZ7r9Ss7vcNDqF/SJbwzqEDP0MRV
	hjxYYpVP8OotdeI1+zKMRQh4ADDtZNni6rtJhWv6ydF10oXnNM
	eT8iK17+U3Hm9Ti8aeyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104050>

Junio C Hamano, 28.12.2008:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > What's wrong with using the first line instead of the first paragraph
> > for the other pretty options and for cases where only a small subject
> > line is desired? A sentence would be broken into a small uncomplete part
> > for the subject for example. What else?
> 
> The "first line" actually was what we used to do originally.
> 
> git-native commits did not have problem with this behaviour, but it caused
> countless complaints from people looking at the history converted from
> other cultures.
> 
> The behaviour was later fixed to avoid information loss when a commit from
> a different culture begins the log with a long sentence, choped at
> mid-sentence, to continue to the second line.
> 
> Please check the list archive for the details (sorry, I am bit too lazy to
> repeat the argument myself).

I don't call this lazy. Normally I look myself and don't want others to
spend time on searching for me. Reading that there already were
discussions about this and that the current behaviour is thoughtful is
enough for me to look for details myself. Thanks.

Markus
