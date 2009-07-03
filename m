From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: requirements to compile git-svn support
Date: Fri, 03 Jul 2009 11:51:02 +0200
Message-ID: <h2kkec$7ra$1@ger.gmane.org>
References: <alpine.DEB.2.00.0907021352300.24169@vinegar-pot.mit.edu> <h2kjg8$5at$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 11:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMfSd-0003Ce-GC
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 11:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbZGCJx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 05:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZGCJx0
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 05:53:26 -0400
Received: from main.gmane.org ([80.91.229.2]:40021 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbZGCJxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 05:53:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MMfSS-0005ay-Qn
	for git@vger.kernel.org; Fri, 03 Jul 2009 09:53:28 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 09:53:28 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 09:53:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <h2kjg8$5at$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122694>

Graeme Geldenhuys wrote:
> I run 'git svn', I get the following output on my system.
> 
> ==============================
> $ git svn
> Can't locate SVN/Core.pm in @INC (@INC contains: 
> /usr/local/share/perl/5.8.8 /etc/perl /usr/local/lib/perl/5.8.8 
> /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8 
> /usr/local/lib/site_perl .) at /usr/local/libexec/git-core/git-svn line 29.
> ==============================


I did some more Google'ing and finally found the answer. All that was 
missing was libsvn-perl.  The following command installed it and solved 
my problem. :-)

  $ sudo apt-get install libsvn-perl


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
