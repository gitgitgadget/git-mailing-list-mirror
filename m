From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 16:29:52 -0500
Message-ID: <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
	 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: David <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Cgk-0007Bf-3O
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbXLKVaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbXLKV3z
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:29:55 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:39965 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbXLKV3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:29:54 -0500
Received: by an-out-0708.google.com with SMTP id d31so517868and
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 13:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Bk1l6I51rYvTEvGU5+h7YekoH57kT52+6BvfBs/OGDs=;
        b=ffuHBEgFKHMPmmk9q1AFpMo03kX+2+Io85K9eCU6cfYec0X4AlkIC3ahjN0e5oGd3cYLocWfdxUFuXlGKYVugflXquc6qOKbBDeHLwaApU49z/D1b04T4lX0XYM6hPSfyESoBZtJ2+jvH3q4KA2Om4oiVDstGtT158IAzRxaRN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=inh9J5MQ/TsdiYoSR6/NuLPpR4tMD8MUk9d1552qTUMbsUQyTWflmdj1cadASThfrA35tOmnS8j/SdCqphalgTziA9a6a64FtDM4viywrLXNfhGnqdjh0VLRWHmVCTebe+BsBOL0LGnngI/bCvFj27PJWTjFgqAtWDkrjMP3um8=
Received: by 10.101.67.11 with SMTP id u11mr17239313ank.1197408592945;
        Tue, 11 Dec 2007 13:29:52 -0800 (PST)
Received: by 10.101.66.17 with HTTP; Tue, 11 Dec 2007 13:29:52 -0800 (PST)
In-Reply-To: <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67950>

On Dec 11, 2007 3:54 PM, David <davvid@gmail.com> wrote:
> > On Dec 11, 2007 8:14 PM, Jason Sewall <jasonsewall@gmail.com> wrote:
> >
> > I re-installed without the prefix and that error disappeared, but now I get
> > Traceback (most recent call last):
> >   File "/usr/local/bin/ugit", line 12, in <module>
> >     view = GitView (app.activeWindow())
> >   File "../py/views.py", line 15, in __init__
> >   File "default/ui/Window.py", line 43, in setupUi
> > AttributeError: setLeftMargin
>
> As for the setLeftMarginError -- That could be because you have py/qt
> 4.2.  The ui files were generated with designer-qt4 (4.3.x) so you
> might need a more recent pyqt4.  I'll see if I can grab an older
> version of pyqt and use it for all of the ui designs  (.ui files are
> probably forward but not backwards compatible).

That was it - as a matter of fact, the package updater for my distro
was asking me to upgrade.

Well done, though I don't think I'm going to abandon git-gui quite yet.

The most valuable thing git-gui does, IMHO, is give you fine control
over what you stage in a commit. The two-paned view of staged and
unstaged changes with the view of the actual changes makes it really
easy to see exactly what you are committing. And the graphical
"{Un}stage hunk for commit" business, which ugit seems to lack so far,
is really excellent - it's much easier to use than git add -i for
partial adds.

I would like to see git add -i's hunk-splitting functionality in a
graphical tool for that matter.

Anyway, ugit is very good for a first draft; its text display beats
whats in git-gui in a big way (and I would *hope* qt4 would beat
Tcl/Tk at that at least).

One suggestion:
For Westerners like me, having "staged" on the left and "unstaged" on
the right seems a little unnatural; I'd be curious to hear others'
opinions on that.

Jason
