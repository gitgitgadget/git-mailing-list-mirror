From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Query on git submodules
Date: Tue, 26 May 2015 19:01:25 +0200
Message-ID: <20150526170125.GC31115@book.hvoigt.net>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com>
 <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Frawley, Sarah" <sarah.frawley@intel.com>
X-From: git-owner@vger.kernel.org Tue May 26 19:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxIES-0004bv-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbbEZRBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 13:01:31 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:33955 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbEZRBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:01:30 -0400
Received: from [188.108.15.115] (helo=book.hvoigt.net)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YxIEJ-0006ED-1p; Tue, 26 May 2015 19:01:27 +0200
Content-Disposition: inline
In-Reply-To: <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269953>

Hi,

On Fri, May 22, 2015 at 01:46:24PM +0000, Frawley, Sarah wrote:
> I am a design automation engineer supporting 200+ designers who use
> git for hardware design.=A0 We also use the submodule feature where w=
e
> can have quite complex hierarchy's with 10+ layers.

What does this 10+ layers mean? Nested submodule repositories 10
recursion steps deep?

> We have experience issues with re-use of design projects was we move
>from one derivative to another due to the complexity of the hierarchy
>along with lack of discipline (using absolute paths in .gitmodule
>files). To enforce more discipline I am currently working on a
>pre-commit hook to check the integrity of .gitmodule files.=A0 I would=
 be
>interested in seeing how other users in the community find submodules
>for large scale projects and if there are any best known methods for
>using them.

I do not have anything to share here since our projects did not have
such problems (not that large scale). It would be interesting to see
what you come up with. Maybe we can add some of that into core git to
support such large scale projects better. So maybe you can share exactl=
y
what problems you have (only absolute paths?) or the pre-commit hooks
you will use.

Cheers Heiko
