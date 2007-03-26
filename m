From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Subproject status
Date: Mon, 26 Mar 2007 15:46:58 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703261541370.14387@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0703251304280.6485@iabervon.org><20070326093906.G
 F22773@admingilde.org> <Pine.LNX.4.64.0703261920070.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzJU-0004XM-5e
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933846AbXC0ANU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933850AbXC0ANU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:13:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36937 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933846AbXC0ANT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:13:19 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 26 Mar 2007 16:13:19 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 26 Mar 2007 17:13:07 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0703261920070.6485@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43216>

On Mon, 26 Mar 2007, Daniel Barkalow wrote:

>
> So, I had the nutty idea that it would be convenient if I could make
> different files in a single directory come from different projects. But I
> can't think of a sane user interface, so I think that this isn't
> practical from that direction, so it's probably not worth worrying about
> from the data structure end, either. (Answer for the usecase:
> "ln -s make/Makefile Makefile; git add Makefile", and mock systems that
> don't handle symlinks).
>

this would definantly be useful (managing files in /etc or /home are easy 
examples

for this sort of thing doing 'git add file -index project' would be a fair 
first-cut at a UI. later on how about creating a dummy .git directory that would 
record 'file X is part of project Y' so that you could get away with only 
specifying it once, and then either have a default, or have git add complain if 
there are multiple places to put things and you don't specify which one (and if 
you add fules to multiple projects at the same time then you could either prompt 
for additional checkin comments as needed, or use the same comment for all 
projects)

David Lang
