From: Petr Baudis <pasky@ucw.cz>
Subject: Re: "True" git merge in git-pasky
Date: Tue, 19 Apr 2005 10:09:49 +0200
Message-ID: <20050419080949.GA2393@pasky.ji.cz>
References: <20050419035107.GB5554@pasky.ji.cz> <20050419054307.GA1528@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 10:06:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNnjw-00065M-Mh
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 10:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDSIJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 04:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVDSIJx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 04:09:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37817 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261388AbVDSIJu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 04:09:50 -0400
Received: (qmail 2796 invoked by uid 2001); 19 Apr 2005 08:09:49 -0000
To: bert hubert <ahu@ds9a.nl>
Content-Disposition: inline
In-Reply-To: <20050419054307.GA1528@outpost.ds9a.nl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 07:43:07AM CEST, I got a letter
where bert hubert <ahu@ds9a.nl> told me that...
> On Tue, Apr 19, 2005 at 05:51:07AM +0200, Petr Baudis wrote:
> > 	http://pasky.or.cz/~pasky/dev/git
> 
> I pulled the tar.bz2 and did make:
> gcc -g -O3 -Wall -o merge-cache merge-cache.o libgit.a libgit.a -lssl -lz
> gcc -g -O3 -Wall   -c -o unpack-file.o unpack-file.c
> gcc -g -O3 -Wall -o unpack-file unpack-file.o libgit.a libgit.a -lssl -lz
> make: commit-id: Command not found
> Generating gitversion.sh...
> 
> Is this bad?

It will cause a 40-digit hexadecimal number missing in your git help and
git version output.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
