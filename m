From: greened@obbligato.org
Subject: Re: [DOCBUG] git subtree synopsis needs updating
Date: Mon, 31 Dec 2012 20:51:41 -0600
Message-ID: <877gnx39aa.fsf@waller.obbligato.org>
References: <20121019152158.4297707b@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Tue Jan 01 03:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpryv-00065z-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab3AACwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 21:52:25 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48280 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279Ab3AACwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:52:24 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tps4r-0005aA-6a; Mon, 31 Dec 2012 20:59:42 -0600
In-Reply-To: <20121019152158.4297707b@chalon.bertin.fr> (Yann Dirson's message
	of "Fri, 19 Oct 2012 15:21:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Yann Dirson <dirson@bertin.fr> writes: > As the examples in
    git-subtree.txt show, the synopsis in the same file should > surely get a
    patch along the lines of: > > -'git subtree' add -P <prefix> <commit> > +'git
    subtree' add -P <prefix> <repository> <commit> > > Failure to specify the
    repository (by just specifying a local commit) fails with > the cryptic:
   > > warning: read-tree: emptying the index with no arguments is deprecated;
    use --empty > fatal: just how do you expect me to merge 0 trees? [...] 
 Content analysis  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212394>

Yann Dirson <dirson@bertin.fr> writes:

> As the examples in git-subtree.txt show, the synopsis in the same file should
> surely get a patch along the lines of:
>
> -'git subtree' add   -P <prefix> <commit>
> +'git subtree' add   -P <prefix> <repository> <commit>
>
> Failure to specify the repository (by just specifying a local commit) fails with
> the cryptic:
>
>  warning: read-tree: emptying the index with no arguments is deprecated; use --empty
>  fatal: just how do you expect me to merge 0 trees?

Specifying a local branch works fine, though, as does a raw commit
hash.  What do you mean by "local commit?"

I have updated the documentation and will submit it tonight or tomorrow.

Any invalid refspec should be caught early and a more useful message
will be displayed.

> Furthermore, the doc paragraph for add, aside from mentionning <repository>, also
> mentions a <refspec> which the synopsis does not show either.

Fixed.

> As a sidenote it someone wants to do some maintainance, using "." as repository when
> the branch to subtree-add is already locally available does not work well either
> (fails with "could not find ref myremote/myhead").

Seems to work for me.  Can you give me the command you're using when you
see the problem?

Thanks for the report!

                          -David
