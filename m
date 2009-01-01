From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] doc/git-send-email: mention sendemail.cc config variable
Date: Fri, 2 Jan 2009 00:40:40 +0100
Message-ID: <200901020040.41399.markus.heidelberg@web.de>
References: <200812290037.25890.markus.heidelberg@web.de> <200812291400.08924.trast@student.ethz.ch>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 02 00:41:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXAm-0002YU-6K
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159AbZAAXka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbZAAXka
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:40:30 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:40436 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbZAAXk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 18:40:29 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id F07F9F878172;
	Fri,  2 Jan 2009 00:40:26 +0100 (CET)
Received: from [89.59.70.163] (helo=pluto)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LIX9O-0003II-00; Fri, 02 Jan 2009 00:40:26 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200812291400.08924.trast@student.ethz.ch>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19uqly9LokCSxTsF4kJK3dziJMpz9OAtNvK8VTJ
	hertSyjOM4bQVI2PCaX3xFBrUM+RMn5GCSZ5N4AilH8Q3tjGSF
	8PWUjS9gyaYsr0L6QQHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104341>

Thomas Rast, 29.12.2008:
> Markus Heidelberg wrote:
> >  	Specify a starting "Cc:" value for each email.
> > +	Default is the value of 'sendemail.cc'.
> >  +
> >  The --cc option must be repeated for each user you want on the cc list.
> 
> Judging from the source, this is not a default value that you can
> override: any recipients listed in sendemail.cc configuration(s) are
> always added to the Cc list.  The same goes for --bcc and
> sendemail.bcc however, which uses the exact same formulation.

I just tested it with --dry-run: the command line options for all three
header lines (to cc bcc) override the corresponding config settings. So
the formulation is correct: the settings are only default values.

Markus
