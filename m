From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug with gitweb on kernel.org
Date: Tue, 24 Apr 2007 03:06:51 +0200
Organization: At home
Message-ID: <f0jkvm$31p$1@sea.gmane.org>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home> <1177286943.24896.14.camel@localhost.localdomain> <alpine.LFD.0.98.0704222112040.28339@xanadu.home> <1177294925.24896.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 03:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9RA-0005mC-1g
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 03:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031014AbXDXBDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 23 Apr 2007 21:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031008AbXDXBDR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 21:03:17 -0400
Received: from main.gmane.org ([80.91.229.2]:48740 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031014AbXDXBDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 21:03:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hg9Qt-0001lA-RF
	for git@vger.kernel.org; Tue, 24 Apr 2007 03:03:03 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 03:03:03 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 03:03:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45398>

J.H. wrote:

> Well the only difference in the pages being served is the mime type
> application/html vs. application/xhtml+xml. =A0Does anyone know the
> original impetus to using application/xhtml+xml (despite the fact tha=
t
> it's technically the correct choice) vs. just using application/html =
for
> everything? =A0I'm sure there was a good reason behind it and I'd rat=
her
> know what that reason was before I got changing things

The idea was to serve application/xhtml+xml to browsers which _explicit=
ely_
support it. But coupled with the fact that gitweb on kernel.org is modi=
fied
gitweb with caching, and it looks like it caches also HTTP headers...
I think simplest solution would be to remove complication, and always s=
erve
text/html (at least for kernel.org gitweb with caching modifications).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
