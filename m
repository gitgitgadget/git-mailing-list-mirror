From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 2/3] git-gui: fix PATH environment for mingw 
	development environment
Date: Sun, 28 Feb 2010 13:46:46 +0100
Message-ID: <20100228124645.GB35071@book.hvoigt.net>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> <20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com> <20100227204108.GA33000@book.hvoigt.net> <20100227204549.GB33000@book.hvoigt.net> <20100227204741.GC33000@book.hvoigt.net> <a5b261831002271657n41ab0f37sc0af50d3a768bfd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: 3umWKSwYKB_Ueslfdqeslfdq.kbqjpvpdfqdlldibdolrmp.Zlj@groups.bounces.google.com Sun Feb 28 13:47:10 2010
Return-path: <3umWKSwYKB_Ueslfdqeslfdq.kbqjpvpdfqdlldibdolrmp.Zlj@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gw0-f58.google.com ([74.125.83.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3umWKSwYKB_Ueslfdqeslfdq.kbqjpvpdfqdlldibdolrmp.Zlj@groups.bounces.google.com>)
	id 1NliYA-0005EM-8U
	for gcvm-msysgit@m.gmane.org; Sun, 28 Feb 2010 13:47:10 +0100
Received: by gwb11 with SMTP id 11sf2466222gwb.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Feb 2010 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition:content-transfer-encoding;
        bh=GqusVavP7+jRuKSXbKHxXMTjmMnmrlL61VwHp6llZnQ=;
        b=yYwZAfguxj0fqOdaQB34Zobs0rI6tKlAE+RKxyFxYddA+t3lY7SYKqaTatrxgS5FGq
         1cMHvN3JUvCunBqnCBSPUf/u7uIklE17NiMd4s21Q9zMqGwFRqnfswY93jxDUbow+l5I
         RtBryAiH51GRu6zISajj7zdsmiNL+JFWl4AZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition:content-transfer-encoding;
        b=47N+jiGqw5tQecnN9QrvC7vQf567hqtSOc7kouRcKhrfLwHRY4PdJGvwUnCP+kNKD9
         KKfFujudCZmlAUdu7efdIv6pl570IvsCrI+itKwOOxG0DgbQnNi+7y73yR4WKLCZlwl2
         Oev9iQHAv3a9XR+QwOrjLxECZIa4oRK8wLzfc=
Received: by 10.91.82.19 with SMTP id j19mr380807agl.7.1267361210196;
        Sun, 28 Feb 2010 04:46:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.2.201 with SMTP id 9ls533359bkk.1.p; Sun, 28 Feb 2010 
	04:46:47 -0800 (PST)
Received: by 10.204.13.216 with SMTP id d24mr124950bka.36.1267361207408;
        Sun, 28 Feb 2010 04:46:47 -0800 (PST)
Received: by 10.204.13.216 with SMTP id d24mr124949bka.36.1267361207383;
        Sun, 28 Feb 2010 04:46:47 -0800 (PST)
Received: from darksea.de (darksea.de [83.133.111.250])
        by gmr-mx.google.com with SMTP id 17si186872bwz.15.2010.02.28.04.46.47;
        Sun, 28 Feb 2010 04:46:47 -0800 (PST)
Received-SPF: neutral (google.com: 83.133.111.250 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=83.133.111.250;
Received: (qmail 4924 invoked from network); 28 Feb 2010 13:46:46 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 28 Feb 2010 13:46:46 +0100
In-Reply-To: <a5b261831002271657n41ab0f37sc0af50d3a768bfd1@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	83.133.111.250 is neither permitted nor denied by best guess record for 
	domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
X-Original-Sender: hvoigt@hvoigt.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/4c7a1dab6e91ada7
X-Message-Url: http://groups.google.com/group/msysgit/msg/27caad7c7a5a79bc
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141251>

On Sun, Feb 28, 2010 at 12:57:14AM +0000, Pat Thoyts wrote:
> On 27 February 2010 20:47, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > When creating a desktop shortcut from the gui the shortcut directly
> > starts wish with the git-gui script. In the msysgit development
> > environment some dll's reside in the mingw/bin directory which causes
> > that git can not start because libiconv2.dll is not found.
> >
> > When using such a link the error is even more cryptic stating:
> > "child killed: unknown signal"
> >
> > Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> > ---
> > I am not sure whether this is the most elegant solution, but making this
> > work would definitely ease the development workflow.
[...]
> > -set bindir [file dirname \
> > +set basedir [file dirname \
> >             [file dirname \
> >              [file dirname [info script]]]]
> > -set bindir [file join $bindir bin]
> > +set bindir [file join $basedir bin]
> > +set bindir "$bindir;[file join $basedir mingw bin]"
[...]

> I have not tried to test this - I use cmd shell all the time so I
> always run this using 'git gui' which runs the git.cmd script in
> ProgramFiles\Git\cmd or in the development environment in
> msysgit\cmd\. It makes me wonder if the Windows shortcut shouldn;t be
> pointing to the cmd script rather than to a tcl script like this as
> the cmd script does some quite extensive environment setup. It assigns
> HOME if it is not set, extends the PATH to include the git
> installation locations, sets the PLINK_PROTOCOL and the codepages for
> the console.

Problem here is that AFAIK the cmd script is part of msysgit and not
upstream git which would break the desktop icon on cygwin. So this
solution seems to me the most unintrusive one because on cygwin (and
installed msysgit) you just end up having one obsolete path in PATH.
And the current heuristic does not always work. Depending on where you
put your prefix variable in your make call you have to manually add to
your path. For example if you, like me, usually install git in your home
directory.

Of course if we had a way to tell where the dll's of git are stored that
would be a way nicer solution.

> Probably only the PATH and HOME fixups are necessary for
> git-gui and in fact tcl's configuration of "~" in the path as HOME
> probably deals with that too.
> This is just for the development setup right? An installation of
> msysGit doesn't have a mingw\bin directory.

Yes it is for development only. But we have this paths in other locations
as well: For example I noticed that even the installation of msysgit has
/mingw/bin in PATH (from etc/profile probably) when starting git bash.

We need something for the development setup. Otherwise testing bugfixes
in this area becomes very tedious. And as stated above the error message
you get is way worse than my patch ;)

cheers Heiko
