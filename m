From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitosis-lite
Date: Tue, 25 Aug 2009 14:05:16 +0200
Message-ID: <200908251405.17644.jnareb@gmail.com>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com> <m363cdm4pm.fsf@localhost.localdomain> <2e24e5b90908242253v411ad5f3t8a2802079914d0bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 14:05:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfumX-0007ef-IN
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbZHYMFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 08:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbZHYMFb
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 08:05:31 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:40879 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZHYMFa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 08:05:30 -0400
Received: by bwz19 with SMTP id 19so2017654bwz.37
        for <git@vger.kernel.org>; Tue, 25 Aug 2009 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=af9y4JV8Bdo0jkvNma4/gr/KrjjQLlpgKsSOjUyivd4=;
        b=KDX0ah1me2R9pCGE5LnJ+mCpwC15IUMjreXOSfOkcBW0LbTHI5IEDSg2To0sWgAnTj
         7lr7mrTN6baI/6Ms1S0zRegsBCQdyV4jmlm51YOPB2EQyKMjhYcNjs0WUraK+4LEgzmB
         a8OdH1RTVsvXI/MNsG87NmS5AXvzDHHWh+UX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uTgvjbQXf0XiPGujJO4FGxrQBtjYD9NX0zAoH2dUT5I8cUpgqdqOceGbt0LB1GxsH5
         grty/2q1jmukiipPX7kYyrQkotCxSUWBJxZDeigYTXJVttmMfQHtMM2X8c1SyfnMODlB
         igMsYbgGOKZcsuMudEtUBB4nA1v1WOgFwz0DI=
Received: by 10.103.50.22 with SMTP id c22mr2574567muk.54.1251201929787;
        Tue, 25 Aug 2009 05:05:29 -0700 (PDT)
Received: from ?192.168.1.13? (abvm114.neoplus.adsl.tpnet.pl [83.8.210.114])
        by mx.google.com with ESMTPS id e10sm1061860muf.14.2009.08.25.05.05.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Aug 2009 05:05:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <2e24e5b90908242253v411ad5f3t8a2802079914d0bf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127017>

Sitaram Chamarty wrote:
> On Tue, Aug 25, 2009 at 12:14 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> 
> > A few comments about the code, taking gl-auth-command as example.
> 
> > Wouldn't it be better to use "use warnings" instead of 'perl -w'?
> 
> I'm not sure what is the minimum perl required for git
> itself.  Has it needed perl > 5.6.0 for more than a year at
> least?  The only real difference between these two is scope,
> which is a non-issue here, so I played safe.

I think that git requires Perl at least version 5.6
 
> > It would be, I think, better if you have used POD for such
> > documentation.  One would be able to generate manpage using pod2man,
> > and it is no less readable in source code.  See e.g. perl/Git.pm or
> > contrib/hooks/update-paranoid.
> 
> Hmm... I've been spoiled by Markdown's sane bullet list
> handling.  Visually, POD forces everything other than code
> to be flush left -- any sort of list is definitely less
> readable in source code as a result.  IMHO of course.

How it is relevant to the issue at hand?  I was talking about replacing
documentation comments in the header with POD markup.

Also you usually document top-level structures with POD.


> > > # first, fix the biggest gripe I have with gitosis, a 1-line change
> > > my $user=$ENV{GL_USER}=shift;       # there; now that's available everywhere!
> >
> > Eh?  This is standalone script, isn't it?  Shouldn't it be
> >
> >   my $user = $ENV{GL_USER} = $ARGV[0];       # there; now that's available everywhere!
> 
> Hmm... I didn't know there was a difference, other than
> depleting @ARGV, if you're outside a subroutine.  I'll take
> a relook at it.

It is, I think, the matter of taste.  IMHO using @ARGV to get _program_
parameters is better than use 'shift' which is used to get subroutine
arguments.

BTW. have you tried using Perl::Critic or http://perlcritic.com on your
code (but remember that those best practice recommendations do not need
to be followed blindly)?

> > > open(LOG, ">>", "$GL_ADMINDIR/log");
> > > print LOG "\n", scalar(localtime), " $ENV{SSH_ORIGINAL_COMMAND} $user\n";
> > > close(LOG);
> >
> > It is better practice to use lexical variables instead of barewords
> > for filehandles:
> 
> Good catch; thanks!  I guess I'm showing my age :)  Fixed
> all of them!
> 
> > Don't forget to check for error.
> 
> Hmm.. well I'm still debating if a log file write error
> should block git access / push, but there were two more
> important closes (again in gl-compile-conf) that were
> unguarded.  Fixed, thanks.

I was thinking about not writing to log file if you can't open it.
 
-- 
Jakub Narebski
Poland
