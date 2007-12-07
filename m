From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: In future, to replace autotools by cmake like KDE4 did?
Date: Fri, 7 Dec 2007 15:42:31 +0100
Message-ID: <998d0e4a0712070642u6ae75232t9cb5bfd0920b2439@mail.gmail.com>
References: <998d0e4a0712061810k18e6388jde9d7bc5bd006b57@mail.gmail.com>
	 <m3lk86u2fq.fsf@roke.D-201> <47594021.40200@op5.se>
	 <200712071456.11019.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, gcc@gcc.gnu.org,
	git@vger.kernel.org, "David Miller" <davem@davemloft.net>,
	"Daniel Berlin" <dberlin@dberlin.org>,
	"Ismail Donmez" <ismail@pardus.org.tr>,
	"Marcel Holtmann" <marcel@holtmann.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 15:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ePt-0005ok-79
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 15:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXLGOme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 09:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXLGOme
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 09:42:34 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:16584 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXLGOmd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 09:42:33 -0500
Received: by wr-out-0506.google.com with SMTP id c49so544323wra
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 06:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wRkUGSG2Y69SsCNNjfM82XXwb7/kiNlqlWrEfqRw1d4=;
        b=D7gNjjkcbDeyjdjkPr6N1Zl/Vt2HlbP7uEDjirHcoTo4Mr0OGUJ8flJRxNvP8heKoBu17r01zJMFlvaPl6W9jrs3k+lFNW9FGdGXqfFnNTEV7wQPKSIy/rN9CX4ljL7HgGAlWbeJj88vBKT6KGqEPfaAuI7k9y9MbfNeHnuuhMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EYbzRv5D64PdMTez02fA9s+TIeAsKkc7y4H8f889H2IJEEvXMoWMg3FAgol02k/iXZEaYLMRtWhavZVoLZuDoesNK7xh2nKujp7XxbkJEi8Sj6AnlpWlNBTVFUbFZV86H19SyqEq80uiD/hVTYbse6IiO5VRrUGrXinuVWNyiCg=
Received: by 10.70.77.17 with SMTP id z17mr5241292wxa.1197038551566;
        Fri, 07 Dec 2007 06:42:31 -0800 (PST)
Received: by 10.70.54.17 with HTTP; Fri, 7 Dec 2007 06:42:31 -0800 (PST)
In-Reply-To: <200712071456.11019.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67428>

On 2007/12/7, Jakub Narebski <jnareb@gmail.com> wrote:
> Andreas Ericsson wrote:
> > Jakub Narebski wrote:
> > >
> > > Although there was some talk about whether giw should use autotools,
> > > or perhaps CMake, or handmade ./configure script like MPlayer IIRC,
> > > instead of its own handmade Makefile...
> > >
> >
> > To tell the truth, I'd be much happier if everything like that got
> > put in a header file or some such. 95% of what we figure out by looking
> > at "uname" output can already be learned by looking at the various
> > pre-defined macros.
> >
> > Fortunately, there's a project devoted solely to this, so most of
> > the tedious research need not be done. It can be found at
> > http://predef.sourceforge.net/
>
> Code talks, bullsh*t walks.
>
> Pre-defined macros cannot tell us if one have specific libraries
> installed, cannot tell us if formatted IO functions support 'size
> specifiers' even though compiler claim C99 compliance or even though
> compiler doesn't claim C99 compliance but supports this, etc.
>
> But perhaps the "uname" based compile configuration could be replaced
> by testing pre-defined macros... at least for C code, and git is not
> only C code.
>
> --
> Jakub Narebski
> Poland
>

A powerful tool can do better things that old generators-based tools
(as autotools).

To imagine, there are many scripts in subdirectories or subprojects:

* Before: (many copy and paste of code as below paragraph)
A_VARIABLE_OS = `uname -a | grep .... `  # <- slow
case "$A_VARIABLE_OS" in
   *linux*) ... ;;
   *bsd*) ... ;;
   *aix*) ... ;;
   *) ...;;
esac
m4 foo.sh.m4 > bar.sh # <- very slow
./bar.sh

* Later: (with the powerful tool that had cached many predefined variables in
                   a ramdisk's file or in a daemon's memory)
# call once at 1st time to internal uname of powerful tool for all ocurrences of
# below predefined variable from many scripts:
case "$FOO_VARIABLE_OS" in
   *linux*) ... ;;
   *bsd*) ... ;;
   *aix*) ... ;;
   *) ...;;
esac
# i don't need to generate more scripts to inspect still more it.

   J.C.Pizarro
