From: David Aguilar <davvid@gmail.com>
Subject: Re:
Date: Tue, 9 Sep 2014 17:00:46 -0700
Message-ID: <20140910000045.GA12644@gmail.com>
References: <CAE8x=qW7EwO9YyrQ49vYH50BFcF7RF43eVqDeVex7FKut0oaaw@mail.gmail.com>
 <CAOqJoqGSRUw_UT4LhqpYX-WX6AEd2ReAWjgNS76Cra-SMKw3NQ@mail.gmail.com>
 <CAE8x=qVrK5-nhzL57ADwzQmD+NE-ScnJyPgum6cK6hPox5+VMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Naslund <jnaslund@gmail.com>, p.duijst@stylecncmachines.com,
	git@vger.kernel.org
To: "R. Klomp" <r.klomp@students.uu.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:00:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRVLD-00036L-5L
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 02:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaIJAAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 20:00:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58977 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbaIJAAu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 20:00:50 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so5872235pab.40
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LJYfC6Vq7LF/8cUHNW0Co8K5EC6QMomYPUk7rT8WKXQ=;
        b=cZeffQRlGuF3Z+cLyUnwrahD/qVGGld4dAP+TUCyx5pnhP3DLNVZfh/TaoS18vBef9
         vx+/XzC2NbUSi27Y5R71dHRdMJ/WdoypkInLvcpznQgS8Ipr3rt2G4Y45knY7qQIVMWq
         XTwQBMRStbXu+3QF2n+5/RmtCEpoBJnBzVnb/q3kH9V7Qm9we3iEr0uLx1uFy0t+Cfdd
         UTsCYYFXIs8Qdtr+B2tOd/MQLrdxtOdXhU+wWr3HRM3oSmRAPtZJFzojIzXIMBs41+kF
         9LsZx7gSnVdQLHO9UeCQKobZDCtJDsfBqtlMUBqQJfw7j/4pz3zYQSR6947rc3VonpID
         u4Ww==
X-Received: by 10.70.14.67 with SMTP id n3mr8073688pdc.132.1410307250076;
        Tue, 09 Sep 2014 17:00:50 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id td4sm12638994pbc.36.2014.09.09.17.00.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Sep 2014 17:00:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE8x=qVrK5-nhzL57ADwzQmD+NE-ScnJyPgum6cK6hPox5+VMg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256724>

On Mon, Sep 08, 2014 at 04:36:49PM +0200, R. Klomp wrote:
> Ok great! That indeed fixed the issue.
> Although I still don't understand why it didn't work without -solo..
> since it didn't work when no instance of Beyond Compare was running as
> well.
> 
> There must be something not quite right in either Git or Beyond Compare.
> 
> On Mon, Sep 8, 2014 at 3:37 PM, Jim Naslund <jnaslund@gmail.com> wrote:
> >
> > On Sep 8, 2014 7:39 AM, "R. Klomp" <r.klomp@students.uu.nl> wrote:
> >>
> >> It seems like there's a bug involving git difftool's -d flag and Beyond
> >> Compare.
> >>
> >> When using the difftool Beyond Compare, git difftool <..> <..> -d
> >> immidiatly shuts down once the diff tree has been created. Beyond
> >> Compare successfully shows the files that differ.
> >> However, since git difftool doesn't wait for Beyond Compare to shut
> >> down, all temporary files are gone. Due to this it's impossible to
> >> view changes made inside files using the -d flag.
> >>
> >> I haven't tested if this issue also happens with other difftools.
> >>
> >> I'm using the latest versions of both Beyond Compare 3 (3.3.12, Pro
> >> Edition for Windows) and Git (1.9.4 for Windows).
> >>
> >>
> >> Thanks in advance for your help!
> >
> > I see the same behavior. For me it had something to do with the diff opening
> > in a new tab in an existing window. Adding -solo to difftool.cmd will make
> > beyond compare use a new window which fixes the issue for me.

Interesting. Would it be worth changing difftool to use -solo by default, or
are there any downsides to doing so?

Is -solo a new feature that only exists in new versions of beyond compare?
I would be okay saying that the user should use a fairly new version.

Can we rely on -solo being available on all platforms?
If so, I'd be okay with changing the default if there are no other downsides.

The --dir-diff feature is not the only one that needs this blocking behavior.
Does this issue also happen in the normal difftool mode without -d?
-- 
David
