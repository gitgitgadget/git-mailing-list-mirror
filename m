From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Tue, 03 Oct 2006 18:43:14 +0200
Organization: At home
Message-ID: <efu3u4$tc9$1@sea.gmane.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 18:43:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUnMf-0005xV-5W
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWJCQn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 12:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJCQn0
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 12:43:26 -0400
Received: from main.gmane.org ([80.91.229.2]:6580 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932251AbWJCQnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 12:43:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUnM4-0005oo-Or
	for git@vger.kernel.org; Tue, 03 Oct 2006 18:42:53 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 18:42:52 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 18:42:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28278>

Junio C Hamano wrote:

> Martin Waitz <tali@admingilde.org> writes:
> 
>> Instead of providing the project as a ?p= parameter it is simply appended
>> to the base URI.
>> All other parameters are appended to that, except for ?a=summary which
>> is the default and can be omitted.
> 
> Supporting PATH_INFO in the sense that we do sensible things
> when we get called with one is one thing, but generating such a
> URL that uses PATH_INFO is a different thing.  I suspect not
> everybody's webserver is configured to call us with PATH_INFO,
> so this should be conditional.

Or perhaps we should use PATH_INFO if the URL of current page uses
PATH_INFO too. The only place where we have to decide is the projects
list page (i.e. no arguments).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
