From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
Subject: Re: git svn clone fails
Date: Fri, 14 Aug 2015 12:38:06 +0200
Organization: Swiss Post Solutions
Message-ID: <mqkgee$ju3$1@ger.gmane.org>
References: <mpa8th$m80$1@ger.gmane.org> <mppsku$h97$1@ger.gmane.org> <mqk6mb$qi8$1@ger.gmane.org> <55CDA784.7080809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 12:38:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQCNf-0004Bf-Sd
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 12:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbbHNKib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 06:38:31 -0400
Received: from plane.gmane.org ([80.91.229.3]:44078 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754249AbbHNKi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 06:38:29 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZQCNS-0003zB-SW
	for git@vger.kernel.org; Fri, 14 Aug 2015 12:38:22 +0200
Received: from 62.154.225.82 ([62.154.225.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 12:38:22 +0200
Received: from joerg.schaible by 62.154.225.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 12:38:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.154.225.82
User-Agent: KNode/4.14.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275899>

Hi Torsten,

thanks for an answer ...

Torsten B=C3=B6gershausen wrote:

> On 2015-08-14 09.51, J=C3=B6rg Schaible wrote:
> I can't reproduce it here:
>=20
>  git svn clone http://websvn/svn/essvn/standard/java-commons/lang
> Initialized empty Git repository in /home/xx/lang/.git/
> RA layer request failed: OPTIONS of
> 'http://websvn/svn/essvn/standard/java-commons/lang': Could not resol=
ve
> hostname `websvn': Host not found (http://websvn) at
> /Users/xx/lib/perl5/site_perl/Git/SVN.pm line 143

It is unfortunately not possible to provide this Subversion repo to the=
=20
public.
=20
> In other words, is there a way to make this reproducible for others?

Actually I hoped, that my report raised some memories, because errors w=
ith=20
this symptom had been examined before and some kind of fix has been add=
ed=20
(according http://stackoverflow.com/questions/25353316/error-with-git-s=
vn-clone) to GIT 2.4.x. However, it seems there's still an issue even i=
n GIT=20
2.5.0 when the svn repo contains empty directories that have to be pres=
erved=20
=2E..

> If not, how could the problem be tracked down and fixed
> (from other people than you or somebody in your organization ?)

Actually I am not sure. I tried to create a little dummy project in a=20
Subversion test repository that contains also empty directories which h=
ave=20
to be preserved ... but the conversion for it works flawlessly. Even if=
=20
those dirs had been nested, renamed, moved and deleted.

Any idea how to proceed?

Cheers,
J=C3=B6rg
