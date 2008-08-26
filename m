From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: Re: git-svn dcommit gone wrong and git-fsck
Date: Tue, 26 Aug 2008 19:01:33 +0100
Message-ID: <g91gdv$qgi$1@ger.gmane.org>
References: <g91bgi$8cm$1@ger.gmane.org> <20080826173605.GA32301@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 20:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2sX-000619-5s
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 20:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758259AbYHZSBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758258AbYHZSBr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:01:47 -0400
Received: from main.gmane.org ([80.91.229.2]:36936 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758202AbYHZSBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:01:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KY2rR-0006Tj-6a
	for git@vger.kernel.org; Tue, 26 Aug 2008 18:01:45 +0000
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 18:01:45 +0000
Received: from Bruno.Harbulot by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 18:01:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: rain.gmane.org
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080826173605.GA32301@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93787>



Bj=F6rn Steinbrink wrote:
> On 2008.08.26 17:37:36 +0100, Bruno Harbulot wrote:
>> Hello,
>>
>> I had 11 consecutive commits in my local git repository that I was =20
>> trying to commit to an SVN repository, using "git-svn dcommit". The =
=20
>> first 7 worked fine, as usual. However, when sending the 8th, I got =
a =20
>> "Bus error" (on OSX -- I'm not sure what the actual cause was).
>>
>> A further "git-svn dcommit" produces this error.
>> Cannot dcommit with a dirty index.  Commit your changes first, or st=
ash =20
>> them with `git stash'.
>>  at /opt/local/bin/git-svn line 406
>=20
> 1. git checkout $your_branch
>=20
> 2. Look up the latest commit you had on your branch using "git reflog=
"
>    or "git log -g"
>=20
> 3. git reset --hard $that_commit
>=20
> 4. git svn rebase
>=20
> 5. check that your history is sane
>=20
> 6. git svn dcommit
>=20

Thanks a lot! It works.


Best wishes,

Bruno.
