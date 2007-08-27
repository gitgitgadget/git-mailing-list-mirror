From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Mon, 27 Aug 2007 15:34:09 +0000 (UTC)
Message-ID: <loom.20070827T172150-191@post.gmane.org>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 17:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgbr-0001k0-Uv
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbXH0Pec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbXH0Pec
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:34:32 -0400
Received: from main.gmane.org ([80.91.229.2]:37825 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686AbXH0Peb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:34:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPgbc-0006JT-Io
	for git@vger.kernel.org; Mon, 27 Aug 2007 17:34:20 +0200
Received: from creinus-web.us.es ([150.214.9.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:34:20 +0200
Received: from scallegari by creinus-web.us.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 17:34:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 150.214.9.245 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20061201 Firefox/2.0.0.6 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56849>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Dmitry Kakurin <dmitry.kakurin <at> gmail.com> writes:
> 
> > 1. It may be better to combine all these files into one (.gitmeta) with
different sections
> 

Sorry about entering this discussion so late.
I am just wondering about one thing.

Couldn't all this directory/ownership/permission tracing be easily done by
using hooks?
E.g. Having a pre-status and pre-commit hook one could fire up a program/script
to collect all the extra info he wants to trace and store it somewhere
(typically in some traced file).
The other way round one could have a post-checkout hook and he could arrange
it to fire up some program to look into the extra-info file to set up
all the meta-data he wants.

This would be very flexible and would permit to manage absolutely /any/ kind
of the metadata leaving absolute freedom about how to do so.

Am I missing something here?

Sergio
