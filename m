From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Fwd: Re: "Integrated Web Client for git" GSoC proposal
Date: Sat, 17 Apr 2010 12:52:52 +0530
Message-ID: <p2ue72faaa81004170022q2fc3a490u83ad6e325b91e139@mail.gmail.com>
References: <201004130403.42179.chriscool@tuxfamily.org>
	 <201004150204.42813.jnareb@gmail.com>
	 <1271293123.6248.147.camel@denix>
	 <201004161118.32163.jnareb@gmail.com> <1271473792.3506.30.camel@denix>
	 <loom.20100417T081957-371@post.gmane.org>
	 <r2we72faaa81004170021z9920e6e9k4c3aa06fe46431b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 17 09:23:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O32N0-0004NE-DG
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 09:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973Ab0DQHWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Apr 2010 03:22:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43792 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826Ab0DQHWy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 03:22:54 -0400
Received: by gwaa18 with SMTP id a18so1747528gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=S5PGDElO6xU4y3PLBF3MBRLhSm3TJiM+E8oda3c+OTE=;
        b=h0qLbQp8ztZ3Y3HMH2oXK8a8H0duSNs6dSsru9XE3XPCoK2SLWDdN2upRpkSVSo5vh
         rWbsn/BSpW4aQl3YbcmiTXZ4hhuGd+RKrkrXI4NrdJWn194Puj9mJgvh/qv/LUDTZNPP
         8lpedK5B0IgP+3oumGUqYsaQiA3dT9tJMbw5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=gOvLDd80nr5phdawp/DU+RZ7MyVC1wv5CQh997AUcHL4uFmYn/FR+zRYKwe+Q3DzyO
         ifLeSDZBkxiFU12ALt19SXfHKCaupXpnEOukInlFWzQ/6zg2CXYrkXNBgOjGzdrph4Cr
         dKvv3Xyr3Kmu2QexZBgF4pHdTeVinGmEiFuhM=
Received: by 10.90.118.4 with HTTP; Sat, 17 Apr 2010 00:22:52 -0700 (PDT)
In-Reply-To: <r2we72faaa81004170021z9920e6e9k4c3aa06fe46431b0@mail.gmail.com>
Received: by 10.91.51.2 with SMTP id d2mr1547328agk.31.1271488972303; Sat, 17 
	Apr 2010 00:22:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145119>

On Sat, Apr 17, 2010 at 11:57 AM, Tatsuhiko Miyagawa
<miyagawa@bulknews.net> wrote:
>
> Sam Vilain <sam <at> vilain.net> writes:
>
> > > of CGI.pm, perhaps also using one of URI dispatchers[5][6]. =A0Pl=
ack/PSGI
> > > looks like the future of Perl web scripting... but is currently q=
uite new,
> > > at version 0.9930.
>
> I admit that it's quite new - not old anyway, but don't get fooled by=
 its
> version number. It's already adapted by almost all perl frameworks an=
d
> used by lots of companies on production.
>
> > Ok so PSGI is the port of Python's WSGI to Perl. =A0Plack is the re=
ference
> > implementation, and also quite heavy at 2.5MB tarball.
>
> No, the tarball just contains 2.4MB of .jpeg file for large-file down=
load
> and upload testing. Its =A0dependencies are kept minimal - only requi=
res
> LWP, URI and some pure perl modules.
>
> > required. =A0Dancer however seems to stand out at only 94kB tarball=
, minimal
> > non-core dependencies and support for PSGI. =A0The HTTP::Server::Si=
mple::PSGI
> > dependency should let it support the 'instaweb' case with pure perl=
=2E
>
> You can already use CGI::Emulate::PSGI (via Plack::App::CGIBin) to ru=
n
> gitweb.cgi on Plack, or whatever web server that supports PSGI - like
> HTTP::Server::Simple::PSGI you just mentioned.
> http://gist.github.com/346068
>
> > It should be possible for the script to figure out what filesystem =
path it
> > is being run from, perhaps find a local lib/ dir and then add that =
to @INC.
> > In shell scripts you just use FindBin, I don't know whether that is=
 still
> > expected to work from eg mod_perl but there's bound to be a solutio=
n for
> > that. =A0So yeah I'd say just aim to ship lots of .pm files in a ne=
arby dir
> > alongside the script...
>
> Or use App::FatPacker.
>
> --
> Tatsuhiko Miyagawa
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

We need to keep gitweb dependancies as less as possible. So, using
frameworks will be a bad idea, as everybody might don't want to use
them.

Coming to splitting of gitweb, as Jakub said installing a split web
script would be a problem, but we can have a solution the problem by
using proper algorithms. First, we parse the URL and get to know which
function to be implemented and then we include the necessary file and
call the function which will then execute and return the proper HTML
output.

This way, we can no longer worry about installing the split webscript.
All we need is to install the basic gitweb.pl file which does all this
basic parsing and calling other perl files. The other files just
needed to be in the path.

-pavan
