From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Potential bug in git client
Date: Tue, 17 Jun 2014 11:17:15 +0200
Message-ID: <53A0079B.1030602@alum.mit.edu>
References: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?V29qY2llY2ggUHJ6eWJ5xYI=?= <przybylwojciech@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 11:24:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwpcv-0006Cc-2y
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 11:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbaFQJYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 05:24:21 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:62176 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932603AbaFQJYU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 05:24:20 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jun 2014 05:24:20 EDT
X-AuditID: 12074411-f794c6d000000b6d-6d-53a0079d35d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.3D.02925.D9700A35; Tue, 17 Jun 2014 05:17:17 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2181.dip0.t-ipconnect.de [93.219.33.129])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5H9HGuF001119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Jun 2014 05:17:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <CAKY5LXywixV3dWcCcVPTvyFrScJjLd8eoVs=RA1VRcrzUgtThQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1J3LviDY4FGHkUXXlW4mizO/m9gc
	mDx2zrrL7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8bh78uZCg4LVzxZd569gbGPv4uRk0NCwERi
	846P7BC2mMSFe+vZuhi5OIQELjNKTHl5hQnCOc8k8amzn7GLkYODV0BboqsvE8RkEVCV+L6o
	AKSXTUBXYlFPMxOILSoQJDH78zywmbwCghInZz5hASkXEUiS+PqRESQsLKAhsWXNRrCBQgIB
	Eue22YCEOQUCJRp/vmEFCUsIiEv0NAaBmMwC6hLr5wmBVDALyEs0b53NPIFRYBaS8bMQqmYh
	qVrAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyQ4BXcwzjgpd4hRgINR
	iYf3gez8YCHWxLLiytxDjJIcTEqivJE/gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeIVeAeV4
	UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtSi2CyMhwcShK8QsAoFBIsSk1PrUjLzClB
	SDNxcIIM55ISKU7NS0ktSiwtyYgHRWd8MTA+QVI8QHuPsgK18xYXJOYCRSFaTzEqSonz9oEk
	BEASGaV5cGNhKecVozjQl8K839iAqniA6Qqu+xXQYCagwSoT54EMLklESEk1MNrFrA5z/FVQ
	O2+OqALzjEUv+IrOOy1WsduywyNiXueU1a8qj00SENF/f1lw9m+T5Lq7Ly91GM2a/UZW/QdX
	1pstG1YY2LtsWpm6Q+Kke/2V6j9d31KPuslwLypr68taePvsW0999wdi5jtuW3Gs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251855>

On 06/11/2014 12:21 PM, Wojciech Przyby=C5=82 wrote:
> When I was tagging, I think I might have discovered a git client bug.
> [...]
> HOW TO REPRODUCE:
> - Clone a repo into 2 separate directories. Presume there is a tag
> "v0.1" already in there and it is set on say 10 commits ago.
>=20
> - In first directory change the tag to a different place and push it
> to the server:
> git tag -d v0.1
> git tag v0.1
> git push --tags origin master
>=20
> - In second directory try to update the tag...
> git pull --all --tags
> git fetch -all --tags
> THIS DOES NOT WORK, tag is still at old place, but it says "Already u=
p-to-date".
>=20
> - I noticed when I use:
> git fetch --tags
> it works fine and updates the position of the tag, or if I remove tag
> from local git manually (rm .git/refs/tags/v0.1) and update again.
>=20
> Is it a bug or I am doing something wrong? I use git version 1.7.9.5.

Tag fetching changed quite a bit in v1.9.0.  Here is a similar test
using Git 2.0.0:

$ git init main
Initialized empty Git repository in /home/mhagger/tmp/tagexp/main/.git/
$ cd main
$ git commit --allow-empty -m Initial
[master (root-commit) fdcd35b] Initial
$ git tag t
$ git commit --allow-empty -m Second
[master 88f7d4a] Second
$ cd ..
$ git clone main clone1
Cloning into 'clone1'...
done.
$ git clone main clone2
Cloning into 'clone2'...
done.
$ cd clone1
$ git tag -d t
Deleted tag 't' (was fdcd35b)
$ git tag t
$ git push --tags origin master
To /home/mhagger/tmp/tagexp/main
 ! [rejected]        t -> t (already exists)
error: failed to push some refs to '/home/mhagger/tmp/tagexp/main'
hint: Updates were rejected because the tag already exists in the remot=
e.

So, it is impossible to overwrite tags on the server by pushing with th=
e
--tags option.  But we can use a force push:

$ git push origin +refs/tags/t
Total 0 (delta 0), reused 0 (delta 0)
To /home/mhagger/tmp/tagexp/main
 + fdcd35b...88f7d4a t -> t (forced update)
$ cd ../clone2
$ git pull --all --tags
=46etching origin
=46rom /home/mhagger/tmp/tagexp/main
 - [tag update]      t          -> t
Already up-to-date.

So, the tag is now updated but with a visible display of what happened.
 Similarly with fetch:

$ git update-ref refs/tags/t HEAD^
$ git fetch --all --tags
=46etching origin
=46rom /home/mhagger/tmp/tagexp/main
 - [tag update]      t          -> t

Is this closer to the behavior that you want?

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
