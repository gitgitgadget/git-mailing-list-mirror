From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-1.6.2-rc2 problems on t4034-diff-words.sh
Date: Fri, 27 Feb 2009 20:43:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902272041510.6600@intel-tinevez-2-302>
References: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com> <alpine.DEB.1.00.0902271936090.6600@intel-tinevez-2-302> <alpine.LNX.2.00.0902271216090.19082@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8eD-0005Xu-Ir
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbZB0Tnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756911AbZB0Tnz
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:43:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:33949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756903AbZB0Tny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:43:54 -0500
Received: (qmail invoked by alias); 27 Feb 2009 19:43:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 27 Feb 2009 20:43:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lo+x+AorlPwLeB4Y+LnIJpyJRBvhY8WivdzcL5j
	9XkifYk9E3XLfW
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LNX.2.00.0902271216090.19082@suse104.zenez.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111703>

Hi,

On Fri, 27 Feb 2009, Boyd Lynn Gerber wrote:

> On Fri, 27 Feb 2009, Johannes Schindelin wrote:
> 
> > But as I did not forget your kind words, I'll try to help.
> >
> > > * FAIL 6: use regex supplied by driver
> > >
> > >
> > >                 word_diff --color-words
> 
> Does the test suite use bash as it's shell?  I seem to have to use bash 
> now to run the test.  I do not remember having to use bash on earlier 
> 1.6.0

No, bash should not be required.

> > It might be a regex related issue.  Could you
> >
> > - run the test with -i -v (and if that does not help, "sh -x t...")?
> 
> I have to use bash to run the test or I get
> 
> $ ./t4034-diff-words.sh
> ./t4034-diff-words.sh: syntax error at line 52: `(' unexpected

Could you tell me what your version of t4034 has at line 52?  Mine does 
not have a single parenthesis on that line.

> But if I run
> 
> $ bash ./t4034-diff-words.sh
> *   ok 1: setup
> *   ok 2: word diff with runs of whitespace
> *   ok 3: word diff with a regular expression
> *   ok 4: set a diff driver
> *   ok 5: option overrides .gitattributes
> * FAIL 6: use regex supplied by driver
> 
> 
>                 word_diff --color-words

Could you run it again after appending "-i -v" to the command line?

Ciao,
Dscho
