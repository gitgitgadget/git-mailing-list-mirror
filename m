From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t8005: use more portable character encoding names
Date: Fri, 22 May 2009 11:51:10 -0500
Message-ID: <1vlRZ6iKMvKwtgMEJxvNoDcPRfAVCJ39d4srmMwFYEWx2SenNTUkig@cipher.nrlssc.navy.mil>
References: <WnZxv4G_GKTN4oHhxHO_HuQt0cTqurrqXf2HHDiHLAzdp7wC70aKuqDot7xQ1nG9C8_NASCL1_Q@cipher.nrlssc.navy.mil> <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 18:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Xxy-0002if-6x
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 18:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbZEVQvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 12:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbZEVQvT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 12:51:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37892 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbZEVQvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 12:51:18 -0400
Received: by mail.nrlssc.navy.mil id n4MGpCVU028279; Fri, 22 May 2009 11:51:12 -0500
In-Reply-To: <7vhbzd85ux.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 22 May 2009 16:51:11.0272 (UTC) FILETIME=[82CB6A80:01C9DAFD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119742>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> ...  I hesitate to send it since it does not actually allow any
>> tests to pass which were previously failing for me.  At least the utf-8 to
>> UTF-8 shouldn't cause any harm.  The shift-jis to SJIS seems to be commonly
>> supported?  at least IRIX 6.5 and Solaris as old as 7 recognize it, but the
>> evidence is only empirical.  Modern Solaris, and of course Linux recognize
>> either.
> 
> Perhaps the test can be changed from using cp1251 (whatever that is) to
> something more common (e.g. 8859-1)?

Good idea.

> There was another more large-ish patch to the tests around this area
> recently from you.  I liked them but somehow failed to queue any of them
> yet, sorry.

You've got them in 'next'.  Did you forget? :) or don't you consider that
queued?

-brandon
