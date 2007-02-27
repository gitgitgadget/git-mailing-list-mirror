From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 22:27:05 +0100
Organization: Dewire
Message-ID: <200702272227.05244.robin.rosenberg.lists@dewire.com>
References: <877iu3q13r.fsf@latte.josefsson.org> <200702271257.37437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9pE-0001uv-Nn
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbXB0VZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbXB0VZa
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:25:30 -0500
Received: from [83.140.172.130] ([83.140.172.130]:21696 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbXB0VZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:25:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C17BE80339E;
	Tue, 27 Feb 2007 22:20:24 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04483-09; Tue, 27 Feb 2007 22:20:24 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 742B6802E29;
	Tue, 27 Feb 2007 22:20:24 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <200702271257.37437.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40807>

tisdag 27 februari 2007 13:57 skrev Andy Parkins:
> On Tuesday 2007 February 27 11:41, Simon Josefsson wrote:
> 
> > * How do I discard all locally modified or added files?  'cvs upd -C'
> >   does some of that, but I've been using a tool 'cvsco' which quickly
> >   restore a CVS checkout into a pristine state.
> 
> Not that I know of, but git has some lovely log generation tools, so I'm sure 
> it could be easily done with a snippet of perl - or perhaps a change to git's 
> own log generator to support
> 
>  git-rev-list --pretty=gnucl
> 
gir-rev-list ??

Extend git-shortlog with --gnucl instead. What seems missing is the grouping
of changes by date. git-shortlog only groups by author.

-- robin
