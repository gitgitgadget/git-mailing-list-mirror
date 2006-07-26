From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: Wed, 26 Jul 2006 10:59:31 -0700 (PDT)
Message-ID: <20060726175931.37750.qmail@web31810.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0607261702500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 26 19:59:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5nfW-0001Cy-7O
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 19:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWGZR7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbWGZR7e
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 13:59:34 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:54898 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751725AbWGZR7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 13:59:33 -0400
Received: (qmail 37752 invoked by uid 60001); 26 Jul 2006 17:59:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BpHgeqC0GiCbBfaB0HI8qwGKlGIc5Q5cOgzY8zxJKzL32g6IMFDuMKVX0vd+hUWBTuk1ZkO7pG5D2i5Qm5pVigj5QhUGPEWcSIjQS6D7BqCH6QqL9HR2CGRuRSiJOFibq4X97cuAELzjM402wfZop1Z7RmXpXGNGSIHG2uuoya4=  ;
Received: from [71.80.231.253] by web31810.mail.mud.yahoo.com via HTTP; Wed, 26 Jul 2006 10:59:31 PDT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <Pine.LNX.4.63.0607261702500.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24230>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> [please do not remove me from the Cc: when replying to my mail]
> 
> On Wed, 26 Jul 2006, Jakub Narebski wrote:
> 
> > Johannes Schindelin wrote:
> > 
> > > Seriously, I still believe that proof-of-concepts in Bash or Perl or even 
> > > Python are fine. But they are not for real work, so one of my long-term 
> > > goals for git is to get rid of them.
> > 
> > I don't think that we would want to rewrite gitweb in C, for example.
> > And Perl for porcelanish commands is all right, IMVVHO.

I agree with Jakub.  Both on the deployment side and on the maintenance
and upkeeping side.  Small and fast engine in C and porcelain in whatever
makes sense: Perl, Python, Bash, or even C, etc.

> This is true as long as you do not have problems with Perl. As soon as you 
> start having too many problems with Perl, you want to get rid of it as 
> soon as possible.

The normal thing to do is to post an email to the mailing list describing
the problems you see with Perl, and describing your solution to them, possibly
accompanied with a patch.  But to just post a "convert-to-C" patch is hardly
constructive (to the actual problem you had).

> Think missing modules. Think ActiveState. Think corporate environment. 
> Think other platforms. Think having to mix compilers. Or to support 
> another one, because you cannot mix. Etc. etc.

Yep, exactly _those_ reasons you outlined, tell me that some things are
_better_ off staying in Perl/Python/etc.

    Luben
