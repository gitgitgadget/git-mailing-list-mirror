From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Fri, 15 Jun 2007 15:31:12 -0700
Message-ID: <1621f9fa0706151531w7878b7b0kf35d615563f4cd07@mail.gmail.com>
References: <11818254621527-git-send-email-madcoder@debian.org>
	 <20070615090104.B20266@mrwint.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Josef Jeff Sipek" <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: "Derek Fawcus" <dfawcus@cisco.com>
X-From: git-owner@vger.kernel.org Sat Jun 16 00:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzKKC-0004zS-T1
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 00:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757064AbXFOWbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 18:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757191AbXFOWbQ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 18:31:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:47280 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756981AbXFOWbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 18:31:14 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1092680nzf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 15:31:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xt2DtYQ6p/CvPonc0uGDhPs0r2Y7GTVCyQGlvrzjJ1/08kYf5yyOCddft+X/6iQYVTfvVGkfLa1w/dEz/27qDiNAVedoN+up7xNcArCxoszhevc3qhkLuA9ghazyq2qGT9QEiVq6FrLtH0Rid5acnoNhUpCkMaoCFb7Ak4EMr8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kUQAFH6Mv/wV3/7jOc6JF0X2zobRCLqIXUDkD6C7WVImzvvfu7xdxRB74M9S6VhJ56SeWdPm/txZQgej9BW6JBuJ6mCRN/qLPTA6b6VJxftKQnYwQpZjDXBwEyu3aAhbs9Mr0b8rGGQcwWPos75QY0TUHMKsGHCjmLvovneW9JY=
Received: by 10.143.45.8 with SMTP id x8mr178410wfj.1181946672508;
        Fri, 15 Jun 2007 15:31:12 -0700 (PDT)
Received: by 10.142.108.1 with HTTP; Fri, 15 Jun 2007 15:31:12 -0700 (PDT)
In-Reply-To: <20070615090104.B20266@mrwint.cisco.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50280>

On 6/15/07, Derek Fawcus <dfawcus@cisco.com> wrote:
> On Thu, Jun 14, 2007 at 02:50:55PM +0200, Pierre Habouzit wrote:
> > This patch series makes guilt be able to work with a standard posix shell.
> >
> > This has been tested with bash, zsh, dash and posh acting as /bin/sh.
>
> Well if you want to try with a 'real' bourne shell,  there is always the
> heirloom sh or the v7 shell...
>
> http://heirloom.sourceforge.net/sh.html

>From the main page
'''
interactive use. The Bourne shell provides job control if it is
invoked as jsh and runs on a terminal. Of course, it lacks fancy
features such as a command history, command line completion, etc. But
working with these features tends to distract the user's attention.
After a familiarization phase, use of the Bourne shell can lead to a
more even-tempered, concentrated working style. Give it a try.
Seriously.
'''

I love it. I acknowledge that you have to be fairly well concentrated
if you want to type
/usr/lib/python2.5/site-packages/spambayes/resources/ (as an example)
without missing one char.

:)
Benjamin.


> http://www.collyer.net/who/geoff/v7sh.tar
> http://minnie.tuhs.org/UnixTree/V7/usr/src/cmd/sh/
>
> DF
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
