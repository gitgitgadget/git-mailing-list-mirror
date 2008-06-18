From: =?ISO-8859-15?Q?Martin_R=F6hricht?= <public@felicis.org>
Subject: Re: bare init and gitweb
Date: Wed, 18 Jun 2008 08:14:39 +0200
Message-ID: <4858A7CF.5060005@felicis.org>
References: <g38t49$lgr$3@ger.gmane.org> <m3bq1zolh6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 08:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8qxX-0007jR-G0
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 08:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075AbYFRGO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 02:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759094AbYFRGO7
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 02:14:59 -0400
Received: from main.gmane.org ([80.91.229.2]:36222 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759038AbYFRGO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 02:14:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K8qwX-0007z5-5N
	for git@vger.kernel.org; Wed, 18 Jun 2008 06:14:53 +0000
Received: from i72archimedes.tm.uni-karlsruhe.de ([141.3.71.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 06:14:53 +0000
Received: from public by i72archimedes.tm.uni-karlsruhe.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 06:14:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: i72archimedes.tm.uni-karlsruhe.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <m3bq1zolh6.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85364>

Hi Jakub,

On 06/17/2008 10:27 PM, Jakub Narebski wrote:
> Martin R=F6hricht <public@felicis.org> writes:
>=20
>> in order to use git for some projects via WebDAV I followed the
>> instructions given in
>> http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-serv=
er-over-http.txt
>=20
> [...]
>> Whenever I clone the server's repository somewhere else, I get the
>> README file as expected. But when I use gitweb to show me the conten=
ts
>> of the repository, all I get is this:
>>=20
>> -------------------------8<------------------------
>> projects /
>>=20
>> 403 Forbidden - No projects found
>> -------------------------8<------------------------
>>=20
>> The projectroot variable within /etc/gitweb.conf points to my
>> ~/gitrepo.git, and whenever I use "git init", add and commit some
>> files locally on the server I see the contents as expected by using
>> gitweb, but never by using a repository created with "git --bare ini=
t".
>>=20
>> Can someone help me out? I would really appreciate any help.
>=20
> The $projectroot variable should point to the _common root_ of all
> projects, in your case it could be one directory up your repository,
> for example
>=20
>   our $projectroot =3D /home/nick
>=20
> not
>=20
>   our $projectroot =3D /home/nick/gitrepo.git

thank you very much -- you solved my problem and it works like a charm.=
 :-)

Have a nice day,
Martin
