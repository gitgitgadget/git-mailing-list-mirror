From: Drew Northup <drew.northup@maine.edu>
Subject: Gitweb != HTTP back-end {Was: Re: The future of gitweb - part 2:
	JavaScript}
Date: Wed, 20 Apr 2011 14:24:52 -0400
Message-ID: <1303323892.20895.22.camel@drew-northup.unet.maine.edu>
References: <201102142039.59416.jnareb@gmail.com>
	 <201104170019.07997.jnareb@gmail.com>
	 <20110416225729.GB5739@external.screwed.box>
	 <201104171211.14118.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:25:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCc67-00059z-Py
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 20:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab1DTSZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 14:25:50 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:45509 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1DTSZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 14:25:49 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3KIOvIG001533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Apr 2011 14:24:57 -0400
In-Reply-To: <201104171211.14118.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3KIOvIG001533
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1303928714.48419@wIYLxP2B6o5cLHgASUianw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171870>


On Sun, 2011-04-17 at 12:11 +0200, Jakub Narebski wrote:
> On Sun, 17 Apr 2011, Peter Vereshagin wrote:
> > 2011/04/17 00:19:07 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

> > JN> > - the routing of the request, the deciding what to do with the particular
> > JN> >   HTTP request, becomes more obfuscated. First, web server decides what CGI
> > JN> >   should approve it. Plus two more decision makers are those 2 CGI, all different.
> > JN> > 
> > JN> > It's just why I never supposed git to have 2 different native web interfaces,
> > JN> > especially in sight of plumbing vs porcelain contrast in cli, sorry for
> > JN> > confusion.
> > JN> 
> > JN> Those are not two _web interfaces_.  Gitweb is one of web interfaces
> > JN> to git repositories; more at
> > JN>   https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Web_Interfaces
> > JN> 
> > JN> Fetching and pushing via HTTP is not web interface, is HTTP _transport_.
> > 
> > But HTTP is an application protocol, not a transport protocol.

Forgive me, but this is seriously off-base. 
HTTP := Hyper-Text Transport Protocol. 
It is a generic, stateless, way of moving text (Base-64 encoded for
binary data) over the wire. Sure, the ISO/OSI model may classify it as
an "application," but that term does not mean the same thing in all
contexts. As far as Git is concerned it is a transport; as far as the
ISO/OSI model of networking is concerned it is an application. We aren't
talking here about the latter.
Or perhaps you are confusing an HTTP-speaking "application" (Gitweb) and
the Git-over-HTTP back-end. They do not have the same purpose. As far as
I'm aware only the "cgit" web interface supports the Git-over-HTTP
"client" directly (and only the dumb one apparently). This may be what
has you confused.

> 
> Fetching via "smart" HTTP protocol is actually git-over-http, with
> some extra work due to the fact that HTTP is stateless.

...and Base-64 encoded, and chunked, and so on...

None of this has anything to do with Javascript.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
