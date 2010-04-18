From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 19:50:17 +0200
Message-ID: <201004181950.19610.jnareb@gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org> <201004180324.54722.jnareb@gmail.com> <20100418021223.GP10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Apr 18 19:50:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3Ydx-0008Ee-6Q
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 19:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243Ab0DRRug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 13:50:36 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:64307 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab0DRRuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 13:50:35 -0400
Received: by bwz25 with SMTP id 25so4697344bwz.28
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=H7MWXYuDB3S7jd3bcjKz71cJyV5W+lX+Fgp3BSxcetA=;
        b=YwKEAVdYyvZfjQEKQ+wA4aOggQsBLELLEnF6oTb0mAp8Zk2hVFXJeCv3M3gBLwrgba
         PI2O3gWI8w0Iq2KL+Gxf62m3Oo1udUsVGs+OY85l3u0l4t36T7XYiEoixUJafBZxlq6c
         FXF2yGPJTNnnAgEex8ngWA1W8PgmHHl+WCsXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=Wd2v7XYC82s3VeIpgaXffxX+hN+J9L06YDTS1RD7u+c0nLROZZA+suQFgLpzq4dmsO
         fTWdhiauzcNrX3SxrgskVzm1+2djd2fuPH/y7RHUok+3vOHZUdjLdjifmXQ9GHsdpmht
         +Ag+DyueJzNWKSnFkzfuzuPjcqVEz4hHKkNFs=
Received: by 10.102.237.3 with SMTP id k3mr2757507muh.125.1271613032573;
        Sun, 18 Apr 2010 10:50:32 -0700 (PDT)
Received: from [192.168.1.13] (abwr2.neoplus.adsl.tpnet.pl [83.8.241.2])
        by mx.google.com with ESMTPS id 12sm23868167muq.1.2010.04.18.10.50.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 10:50:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100418021223.GP10939@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145223>

On Sun, Apr 18, 2010, Petr Baudis wrote:
> On Sun, Apr 18, 2010 at 03:24:53AM +0200, Jakub Narebski wrote:
>> On Sun, Apr 18, Petr Baudis wrote:
>>> On Sun, Apr 18, 2010 at 02:46:16AM +0200, Jakub Narebski wrote:
 
>>>> Or is it
>>>> meant as web analogue of git-gui: a committool, with ability to create
>>>> new commits, perhaps to edit files (and add them, delete them, move them
>>>> around), a bit like ikiwiki with Git backend, or other Git based wikis
>>>> and blogs?
>>> 
>>> Yes. Though it is probably supposed to be real Git frontend with Git
>>> semantics, not something more abstract with Git under the hood.
>> 
>> Hmmm... doesn't look so easy.  What to do about simultaneous access
>> (what webmin does?), and working directory (what ikiwiki does?)?
> 
>   I would expect it to work the same as if you work in single working
> copy from multiple shells. If multiple people want to collaborate, each
> should have their own clone to begin with.

So it is intended, I guess, more like git-instaweb or webmin, not like
administrative parts of Girocco (or repo.or.cz), GitHub, Gitorious or
InDefero.  Probably authentication and authorization would not be needed
then, if it is to be run as web interface but locally...
 
>> Well, you can always add some of "Web Client" functionality directly
>> to gitweb (for example dispatch must be, I think, in gitweb).
> 
> But I don't think you can reasonably separate a major portion of web
> client that would not depend on gitweb functions like href(), format*()
> etc. all over the map.

Well, there is also copy'n'paste of code as a last resort.  

I guess that git-gui and gitk duplicate some of their functionality
(and only git-gui is split; gitk is monolitic single file, even larger
than gitweb: 320KB vs 220KB).

>> Or you
>> can (ab)use "do $gitwebgui_pm;" instead of "require $gitwebgui_pm;",
>> like in http://repo.or.cz/w/git/jnareb-git.git/commitdiff/261b99e3#patch3
>> (second chunk).
> 
> This already occured to me, yes. It's tempting to have this as the
> emergency way out, shall other things fail. But .
                                              ^^^^^^^^^^-- ???
But what?

Yes, it is not as elegant as "require", and you have to catch errors
in "do"-ed file yourself (as described at the end of `perldoc -f do`).

>> OTOH we can always make gitweb "use Git;" and move some of its routines,
>> to it after generalization (e.g. config management using single run of
>> "git config -l -z", unquoting paths, parsing commit/tag/ls-tree/difftree
>> etc., date parsing and conversion).
> 
> Yes, but not things like href(), git_header_html() and other absolutely
> essential routines.

True.

>>>> 3. Split Gitweb, add "Web Client" as one of modules.  Might be best
>>>>    from the purity point of view, but is practical only if it is
>>>>    integrated in gitweb.  That would require getting gitweb maintainer
>>>>    out of GSoC.   Also I am not sure how feaible this approach would be.
>>> 
>>> Would it be really required to get gitweb maintainer out of GSoC in
>>> order to go this way? Why?
>> 
>> Well, at least someone who would be able to manage integrating split
>> gitweb.  I think that splitting gitweb, and doing it well, is quite
>> outside this GSoC 2010 proposal: it would be too much. 
> 
> This was my hesitation at the beginning, but I'm not really sure if
> it's really so hard, _if_ we resist the temptation to snowball unrelated
> cleanups on top of it. Conceptually, it isn't really hard to do, is it?
> The only tricky thing would be making sure instaweb still works and
> installation is still easy, but I don't see anything really difficult in
> this area either...?

Currently to install gitweb you have to copy *one* script, and a few
static files (2 x image, CSS, JavaScript).  You can configure it using
"make gitweb" with appropriate options, you can simply edit gitweb script,
or you can leave this to the gitweb config file.

There are quite a few requirements that gitweb should fulfill:
* It must be able to install without admin rights, and requirng to
  install Perl modules system wide.  We can rely on core Perl modules,
  on git core and possibly on perl-Git being installed.
* It must be able to install without editing web server config file,
  nor setting environment variables for the user account that is used
  by the web server (e.g. 'apache', or 'web', or 'nobody').
* Possibly also it should be easy to install gitweb "by hand", without
  requirng to use build system.
* Any automatic installation target must take into account that gitweb
  must run on many web servers (Apache as CGI, Apache as mod_perl, nginx,
  lighttpd, IIS, Moongose, Webrick,...) and on many distributions and
  operating systems (where location of server, and server configuration
  might differ).  But I guess we can borrow some code from git-instaweb.sh


Also there is a question _how_ to split gitweb into modules, 
e.g. whether to follow SVN::Web example on how gitweb (Git::Web?) should
be split.  But I guess any splitting would suffice; we need to provide
a way to build and install split gitweb.  

Split can be as simple as:

  Makefile, or Makefile.PL, or Build.PL
  gitweb.perl
  static/git-logo.png
  static/git-favicon.png
  static/gitweb.css
  static/gitweb.js
  lib/Gitweb/Utils.pm   (Gitweb::Utils)
  lib/Gitweb/Editor.pm  (Gitweb::Editor, for GSoC2010, if it gets accepted)

-- 
Jakub Narebski
Poland
