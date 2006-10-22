From: "Tim Webster" <tdwebste@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 15:49:06 +0800
Message-ID: <72877ab10610220049i602ab936m11181f1a2daf2aee@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <vpqwt6wsmb5.fsf@ecrins.imag.fr>
	 <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
	 <45379A02.1010105@utoronto.ca>
	 <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
	 <45384B0F.4040901@utoronto.ca>
	 <20061021123027.GB29843@artax.karlin.mff.cuni.cz>
	 <ehd5u7$c5g$1@sea.gmane.org> <453A513B.1070006@utoronto.ca>
	 <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 09:49:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbY53-00010b-HJ
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 09:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423134AbWJVHtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 03:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423135AbWJVHtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 03:49:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:27396 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423134AbWJVHtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 03:49:08 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1016516ugd
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 00:49:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=htN+7LQP2UeXyKPXu9DZxa/gJfW4RIhdM6EdMTMwlYfuG5JtH82ROzDlF7QiFXkOnoSCpPM0mVnCtlUo7Yt0lMqBEZgqV44YMmfBjRqJyAWYQrl4OB0k3R4vYKY2/PITHmWLmWvOXAFXelkilFt+koEadhSVIXn2SVX0Ijpa0z8=
Received: by 10.67.30.6 with SMTP id h6mr3566477ugj;
        Sun, 22 Oct 2006 00:49:07 -0700 (PDT)
Received: by 10.67.100.9 with HTTP; Sun, 22 Oct 2006 00:49:06 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610211007320.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29711>

On 10/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sat, 21 Oct 2006, Aaron Bentley wrote:
> >
> > Any SCM worth its salt should support that.  AIUI, that's not what Tim
> > wants.  He wants to intermix files from different repos in the same
> > directory.
> >
> > i.e.
> >
> > project/file-1
> > project/file-2
> > project/.git-1
> > project/.git-2
>
> Ok, that's just insane.
[snip]
> Anyway. Git certainly allows you to do some really insane things. The
> above is just the beginning - it's not even talking about alternate object
> directories where you can share databases _partially_ between two
> otherwise totally independent repositories etc.


Perhaps this is insane, but it does not make sense to track all config
files in etc as though they belong in a single repo. Each
application/pkg has a set of associated config files. Actually in some
cases it is easy to track which files belong in each application/pkg
repo. For example dpkg list conffiles per pkg. Additional config files
not in the application/pkg maintainer repo branch are easily added to
the application/pkg local repo branch.

My question is where should file metadata be stored in git? With hook
scripts, the file metadata can be captured and applied appropriately.

If a similar thing can be done with bzr as Linus described for git, I
am all ears.
