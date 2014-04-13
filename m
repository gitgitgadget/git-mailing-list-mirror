From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Get all tips quickly
Date: Sun, 13 Apr 2014 21:20:25 +0200
Message-ID: <534AE379.7000705@alum.mit.edu>
References: <4A7A3A96-DC10-4748-BBCC-F52F48977022@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stanislav.Erokhin@jetbrains.com
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 21:22:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZPyo-0005uN-RE
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 21:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823AbaDMTWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2014 15:22:06 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51585 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755348AbaDMTU3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2014 15:20:29 -0400
X-AuditID: 1207440f-f79326d000003c9f-57-534ae37caf90
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.F6.15519.C73EA435; Sun, 13 Apr 2014 15:20:28 -0400 (EDT)
Received: from [192.168.69.130] (p4FC961C4.dip0.t-ipconnect.de [79.201.97.196])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3DJKQsk024635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 13 Apr 2014 15:20:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <4A7A3A96-DC10-4748-BBCC-F52F48977022@jetbrains.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqFvz2CvY4Mk5BYuuK91MFu/ub2Wx
	2PFmOasDs8fceW9YPT5vkgtgiuK2SUosKQvOTM/Tt0vgzvh0bQ9LwXqpijsH1jE2MF4R6WLk
	5JAQMJG4Ovs3G4QtJnHh3nogm4tDSOAyo8ScJ3tYIJzzTBKtBzsYQap4BbQlJkx9C2azCKhK
	fP+ynwnEZhPQlVjU0wxkc3CICgRJ/DmrCFEuKHFy5hMWEFtEwEfi8uetrCA2s4CyRO/zNWCL
	hQUUJW7cXQQ2RkjAQeLwkQ9sIGM4BRwl/i6WBzElBMQlehqDIDr1JHZc/wU1RV6ieets5gmM
	grOQLJuFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3MULCmH8H
	Y9d6mUOMAhyMSjy8Cds9g4VYE8uKK3MPMUpyMCmJ8jY88goW4kvKT6nMSCzOiC8qzUktPsQo
	wcGsJMK7LQMox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4O0FGSpY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPit74YmD8gqR4gPY2gbTzFhck5gJFIVpP
	MepybNi2ppFJiCUvPy9VSpxXBaRIAKQoozQPbgUsab1iFAf6WJh3MkgVDzDhwU16BbSECWjJ
	pcnuIEtKEhFSUg2MfqzHJC5JuP5hF17XVpVtV7uC6dBBdsMJL0wUlqb169b8OxMgqeRU7LZ/
	SbdUDsfBqkfK8quCo4V9Ir+ZR3vML6ptrS/KlJF44jPdzkrTz2D7UZPVLO0TNfev 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246210>

On 04/13/2014 04:19 PM, Kirill Likhodedov wrote:
> What is fastest possible way to get all =93tips=94 (leafs of the Git =
log
> graph) in a Git repository with hashes of commits they point to?
>=20
> We at JetBrains are tuning performance of Git log integration in our
> IntelliJ IDEA and want to get all tips as fast as possible. Currently
> we use 'git log =97branches --tags --remotes --no-walk=92, but the
> problem is that it is slow if there are a lot of references. In our
> repository we have about 35K tags, and therefore the tags is the main
> slowdown. On the other hand, we have just a couple of dozens of tips
> as well as branch references, and `git log --branches --remotes` is
> very fast.
>=20
> So we are searching a way to get tags pointing to the graph leafs
> faster.

The fastest ways to get all references plus the commits that are pointe=
d
at by annotated references would probably be `git show-ref -d`.  The
funny-looking entries like "refs/tags/v1.7.0^{}" are the annotated tags
peeled to the object that they ultimately refer.  But this command
doesn't tell the types of the objects, and there can be trees and blobs
mixed in.

If your question is also to figure out the minimum set of references
that are needed to include all tips (i.e., commits with no descendants)=
,
then the answer is trickier.  There is a command that should do what yo=
u
say:

    git merge-base --independent <commit>...

but (1) with a lot of references, your arguments wouldn't all fit on th=
e
command line (recursive use of xargs might be needed), (2) I don't know
if "merge-base --independent" is programmed to work efficiently on so
many inputs, and (3) I don't know of a cheap way of getting a list of
all commits referred to by references (i.e., dereferencing annotated
tags but ignoring references/annotated tags that refer to trees or blob=
s).


Another approach is to start by finding the leaf commits by SHA-1.  You
can do this by listing all commits, and listing all commits' parents,
and then finding the objects that appear in the first list but not the
second.  This could look like

    comm -23 \
        <(git log --all --pretty=3Dformat:'%H' | sort -u) \
        <(git log --all --pretty=3Dformat:'%P' | tr ' ' '\n' | sort -u)

If you want reference names corresponding to these SHA-1s, you could us=
e
name-rev to convert the SHA-1s into refnames:

    git rev-parse --symbolic-full-name $(
        comm -23 \
            <(git log --all --pretty=3Dformat:'%H' | sort -u) \
            <(git log --all --pretty=3Dformat:'%P' | tr ' ' '\n' | sort=
 -u) |
        git name-rev --stdin --name-only
        )

The "rev-parse --symbolic-full-name" is needed because "name-ref" seems
only able to emit abbreviated reference names.


In practice, you might want to cache some of the results to avoid havin=
g
to do a full tree traversal every time.

> We also tried to read tags by manually parsing .git files (it is
> faster than invoking git log), but unfortunately annotated tags in
> .git/refs/tags/ are written without the hashes they point to (unlike
> .git/packed-refs).

I strongly recommend against parsing these files yourselves.  Your
software would not be robust against any future changes to the file
formats etc.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
