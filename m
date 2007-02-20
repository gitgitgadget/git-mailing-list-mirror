From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 09:57:46 -0800
Message-ID: <86abz8sodh.fsf@blue.stonehenge.com>
References: <86sld0sq7c.fsf@blue.stonehenge.com>
	<20070220175536.GC26444@gateway.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Mouw <mouw@nl.linux.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 18:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZFn-0007OE-72
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 18:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbXBTR6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 12:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbXBTR6L
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 12:58:11 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:11253 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988AbXBTR6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 12:58:10 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1B4951DE520; Tue, 20 Feb 2007 09:57:47 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.9; tzolkin = 5 Muluc; haab = 2 Kayab
In-Reply-To: <20070220175536.GC26444@gateway.home> (Erik Mouw's message of "Tue, 20 Feb 2007 18:55:37 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40246>

>>>>> "Erik" == Erik Mouw <mouw@nl.linux.org> writes:

Erik> On Tue, Feb 20, 2007 at 09:18:15AM -0800, Randal L. Schwartz wrote:
>> I tried to install git on a system where I was a normal user.  Of course,
>> this step fails:
>> 
>> Installing /usr/perl5/site_perl/5.6.1/Error.pm
>> Installing /usr/perl5/site_perl/5.6.1/Git.pm

Erik> It gets installed in ~/share/perl/5.8.4/ when I compile as a normal
Erik> user (git-1.5.0.1):

Erik> Installing /home/erik/share/perl/5.8.4/Error.pm
Erik> Installing /home/erik/share/perl/5.8.4/Git.pm
Erik> Installing /home/erik/man/man3/private-Error.3pm
Erik> Installing /home/erik/man/man3/Git.3pm

Is that a personally-installed Perl though?  Those paths look suspicious.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
