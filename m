From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Git crash in Ubuntu 12.04
Date: Wed, 10 Apr 2013 09:44:29 +0200
Message-ID: <87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Sivaram Kannan <siva.devel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 09:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPpht-0006jR-A6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 09:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935623Ab3DJHod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 03:44:33 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:17102 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934966Ab3DJHoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 03:44:32 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 10 Apr
 2013 09:44:27 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 10 Apr 2013 09:44:29 +0200
In-Reply-To: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	(Sivaram Kannan's message of "Wed, 10 Apr 2013 12:11:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220672>

Sivaram Kannan <siva.devel@gmail.com> writes:

> Hi,
>
> I am using git with Gitlab/Gitolite configuration. Git version is
> 1.7.9.5 in Ubuntu 12.04. There has been a consistent git crash
> recently and have attached the /var/crash/_usr_lib_git-core_
> git.1001.crash file.
>
> The crash output is pasted in the following link
>
> http://pastebin.com/uAQS81BX
>
> I removed some long binary information at the end of the file as
> pastebin does not allow more than 500k pasting. The crash is
> consistently happening and I am planning on for a debian deployment of
> gitlab.

Can you tell us what command you ran, and also try to get a readable
backtrace from your installation?

It seems that the paste would have contained a core dump (you snipped
it9, but it would be pretty useless without the corresponding binary
anyway.  Once you have the coredump in hand (as a file) you can use

  gdb $(which git) the_coredump_file

and then in the GDB prompt, enter 'backtrace' and paste its output, to
give us an idea what is going on.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
