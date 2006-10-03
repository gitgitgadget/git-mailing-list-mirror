From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Tue, 03 Oct 2006 19:19:42 +0200
Organization: At home
Message-ID: <efu62g$7f8$1@sea.gmane.org>
References: <20060929221641.GC2871@admingilde.org> <eftk98$2ii$2@sea.gmane.org> <20061003171229.GN2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 19:21:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUnwt-0007Ip-AN
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWJCRUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 13:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWJCRUu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:20:50 -0400
Received: from main.gmane.org ([80.91.229.2]:27596 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030332AbWJCRUu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 13:20:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUnvU-0006v8-9G
	for git@vger.kernel.org; Tue, 03 Oct 2006 19:19:28 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 19:19:28 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 19:19:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28280>

Martin Waitz wrote:

> On Tue, Oct 03, 2006 at 02:16:05PM +0200, Jakub Narebski wrote:
>> Martin Waitz wrote:
>> > Instead of providing the project as a ?p= parameter it is simply appended
>> > to the base URI.
>> 
>> I have just modified href() to be able to use it for actions which don't
>> need the ?p= parameter... and you didn't take into consideration the case
>> when $params{'project'} is set, but undefined.
> 
> is this handled correctly in the second patch which got committed to
> next?

I think it is (from the examining the patch, not from testing).

Perhaps we should use PATH_INFO if current URL uses PATH_INFO... 
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
