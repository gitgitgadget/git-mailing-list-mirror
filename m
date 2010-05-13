From: Adam Monsen <haircut@gmail.com>
Subject: request for help with buildnumber-maven-plugin git integration
Date: Thu, 13 May 2010 23:22:48 +0000 (UTC)
Message-ID: <loom.20100514T010951-900@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 01:23:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OChkp-000859-9V
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 01:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab0EMXXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 19:23:04 -0400
Received: from lo.gmane.org ([80.91.229.12]:35792 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221Ab0EMXXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 19:23:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OChk0-0007hY-KX
	for git@vger.kernel.org; Fri, 14 May 2010 01:22:56 +0200
Received: from c-67-183-136-182.hsd1.wa.comcast.net ([67.183.136.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 May 2010 01:22:56 +0200
Received: from haircut by c-67-183-136-182.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 May 2010 01:22:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.136.182 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100402 Ubuntu/9.10 (karmic) Firefox/3.5.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147036>

Justin(?) said, on May 11th:
> Ah yes I also got that. I disabled the "itest"
> section of the pom.
> 
> I'll send it to you soon.
> 
> Regards
> Justin

Antony Stubbs wrote, on Tue, May 11, 2010 at 12:53 PM:
> I use my build every day, it definitely works for me. However,
> yes, I noticed the failure and disabled the tests! ;) but yes, the
> git integration works fine. I welcome a patch to fix the
> integration tests...
> 
> Regards
> Antony
> 
> On 12/05/2010, at 4:06, Adam Monsen wrote:
> > Hi there! Sorry to trouble you all. I ran across
> > http://stackoverflow.com/questions/2685069/maven-buildnumber-plugin-git
> > , and it led me to you folks. I'm a software engineer on Mifos.
> >
> > Do any of you have a working version of buildnumber-maven-plugin
> > with git support? I tried building from 14001f of
> > http://github.com/astubbs/buildnumber-maven-plugin/ , but I get
> > an "embedded error". I think an integration test is failing, and
> > I forget how to debug these integration tests. The build passes
> > for me for the upstream code (r11906 of
> > http://svn.codehaus.org/mojo/trunk/mojo/buildnumber-maven-plugin
> > ).
> >
> > Anyway, I'd like to help, let me know if you'd like to
> > collaborate.

(also asked on <users@maven.apache.org>)

Maven is a build system used by many Java-based projects. Some folks
have added Git support, allowing the inclusion of build identifiers
(like branches and commit hashes) in products of Maven builds. But
they need help to complete it. Is anyone interested in helping?

This is something we (Mifos) need, so if you do help, know that
you'll be helping to end world poverty.
