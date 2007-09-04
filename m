From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Tue, 4 Sep 2007 00:56:15 -0700 (PDT)
Message-ID: <670495.22199.qm@web31807.mail.mud.yahoo.com>
References: <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, jnareb@gmail.com, ltuikov@yahoo.com
To: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 04 09:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISTGv-0005eE-4h
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 09:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbXIDH4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 03:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbXIDH4R
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 03:56:17 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:30275 "HELO
	web31807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751567AbXIDH4Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 03:56:16 -0400
Received: (qmail 22202 invoked by uid 60001); 4 Sep 2007 07:56:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=32PNt+2ZFQP9N9/eCUwoiVjQk7dLjmIuefirhyYpmO1yYJC7aVLnBuYbu6YDNOa0JjcEMCVIGwUM/blWiGuNO+u6yVmrKqwpkvfRHqsZh7TfwPFkOMWF0ITAbahHiTb2tRZhcShKHQSaMaSmWPn5xoan2JMNQZBHVAkYbMJ5918=;
X-YMail-OSG: MOSuotMVM1mupv6KkOO7AMigkcafd0cTIFmy_dhdb0F8NrwmaL7RDAhK56Jpn9rWTr3IA5M7wC46bZ3QeDKZA07HVGu8VDs9vZoLkup04VKPWc0-
Received: from [68.186.53.107] by web31807.mail.mud.yahoo.com via HTTP; Tue, 04 Sep 2007 00:56:15 PDT
In-Reply-To: <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57538>

--- Junio C Hamano <gitster@pobox.com> wrote:
> Here is my impressions on patches in:
> 
> 	git://repo.or.cz/git/gitweb.git/ next
> 
> * Removal of git_blame
> 
>   I think this makes sense; we do not need two not-so-different
>   implementations, and the other one has been the default for
>   quite some time.

My impression of the running gitweb installation at said site
is that it doesn't implement 244a70e608204a515c214a11c43f3ecf7642533a.
It is very easy to verify that it is not supported.

This is a data mining feature that I use regularly.

     Luben


> 
> * Extra columns in blame
> 
>   I can see why some people especially with wide screen would
>   want this, and toggling the display for extra columns is also
>   a good idea.  But this makes me wonder if the single button at
>   the very top is easy to locate (maybe explain what [+] does?)
>   and easy to access (maybe have it at the top and at least at
>   the bottom as well?).
> 
> * Incremental blame
> 
>   It does not seem to break the blame, but at least from where I
>   sit accessing repo.or.cz this does not look incremental to me.
>   The entire browser session freezes until the blame page
>   displays in full.  My local installation behaves the same way.
> 
> 
> 
>   
> 
