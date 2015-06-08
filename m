From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: GIT for Microsoft Access projects
Date: Mon, 8 Jun 2015 19:14:58 +0300
Message-ID: <20150608191458.9f6a93b0259a8ca0324c8dc0@domain007.com>
References: <20150608094517.GY06Y.31914.root@txifep02>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: <hackerp@suddenlink.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:15:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zhf-0007YZ-Go
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbbFHQPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:15:07 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:52934 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbFHQPF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:15:05 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t58GEw6u003876;
	Mon, 8 Jun 2015 19:15:00 +0300
In-Reply-To: <20150608094517.GY06Y.31914.root@txifep02>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271063>

On Mon, 8 Jun 2015 9:45:17 -0500
<hackerp@suddenlink.net> wrote:

[...]
> My question is, will GIT work with MS access forms, queries, tables,
> modules, etc?
[...]

Git works with files.  So in principle it will work with *files*
containing your MS access stuff.

But Git will consider and treat those files as opaque blobs of data.
That is, you will get no "fancy diffing" like asking Git to graphically
(or otherwise) show you what exact changes have been made to a
particular form or query between versions X and Y of a given MS access
document -- all it will be able to show you is commit messages
describing those changes.

So... If you're fine with this setting, Git will work for you,
but if not, it won't.

One last note: are you really sure you want an SCM/VCS tool to manage
your files and not a document management system (DMS) instead?
I mean stuff like Alfresco (free software by the way) and the like.
