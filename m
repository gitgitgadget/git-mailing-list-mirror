From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Fri, 25 Aug 2006 23:33:45 +0200
Message-ID: <e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
	 <200608252135.27894.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 23:34:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGjJS-0003vg-Dj
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 23:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWHYVdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 17:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWHYVdq
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 17:33:46 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16261 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751500AbWHYVdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 17:33:46 -0400
Received: by py-out-1112.google.com with SMTP id n25so1395116pyg
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 14:33:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p6YV/VOFR0/aORwP2ZYnCwO5NHsWvXHkwbKUT7B/LFkdBtJvCoj7rdygQaKpXabe3RIAgP/by9HiXEWy2OK0Rt7dudhW/1QbGnKsk/qIg22iIg6lPMUZdJXPG0edo7VDK/3tgh0a3Y+0EKPVHVh6Gm45ARLzDevNWJRleISREWE=
Received: by 10.35.97.17 with SMTP id z17mr5892355pyl;
        Fri, 25 Aug 2006 14:33:45 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 25 Aug 2006 14:33:45 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200608252135.27894.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26017>

>
> You can view new gitweb in work at
>   http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi
>

Very nice job!

Just a couple of suggestion regarding blame.

- Instead of commit sha perhaps is more useful to show author name
(linked to commit) and progressive number of revision.

- Original code lines, ie. imported at the beginning and never
modified, perhaps it is better to view without commit number, this
could obfuscate the view and in any case is not an accurate info
because the line was not modified during initial patch.
[Note] Also in qgit there was the annotation of the first initial
commit in case of unmodified code lines, then Ingo Molnar suggest me
to remove that line and leave it blank for the reasons I reported
above. I think he was right.

Marco
