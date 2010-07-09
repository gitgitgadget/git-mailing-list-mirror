From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Handling tags/branches after git-svn fetch during SVN to Git 
	conversion
Date: Thu, 8 Jul 2010 23:01:18 -0400
Message-ID: <AANLkTilnoIyrKg4PLSL71RDU-vyvIeNEtJ8STkOd9Lcq@mail.gmail.com>
References: <AANLkTim56UOYQJfX3M5Jpt0vXD8iTnkLuG68IjQG39Xn@mail.gmail.com>
	<AANLkTinAhxIKD6U3u4OpPnt5kDMPGTyhDhhCRaFtU-gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 05:01:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX3qA-0004rO-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab0GIDBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 23:01:21 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63020 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab0GIDBU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 23:01:20 -0400
Received: by qyk38 with SMTP id 38so3017844qyk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 20:01:19 -0700 (PDT)
Received: by 10.224.58.101 with SMTP id f37mr5122819qah.158.1278644478843; 
	Thu, 08 Jul 2010 20:01:18 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Thu, 8 Jul 2010 20:01:18 -0700 (PDT)
In-Reply-To: <AANLkTinAhxIKD6U3u4OpPnt5kDMPGTyhDhhCRaFtU-gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150632>

In your example, does "remote2" represent the name of my remote Git
repo? What is "origin/branch-foo" and does the path
"refs/heads/branch-foo" need to actually exist in my .git directory?

On Thu, Jul 8, 2010 at 10:54 PM, Jacob Helwig <jacob.helwig@gmail.com> =
wrote:
> On Wed, Jul 7, 2010 at 06:36, Bradley Wagner
> <bradley.wagner@hannonhill.com> wrote:
>> Do I need to convert these remote tags/branches into local Git
>> tags/branches before pushing them to my remote Git repo or is there =
a
>> way to push remote branches directly to my remote Git repo?
>>
>
> You don't need to "convert" the branches to local ones. =A0git-push w=
ill
> accept any ref your local repo knows about when you do a push. =A0For
> example "git push remote2 origin/branch-foo:refs/heads/branch-foo"
> works just fine, even if you don't have a "local" branch called
> "branch-foo", and it will push the branch-foo branch out to the
> remote2 remote repository.
>
> The tags, you'll need to convert to _actual_ tags, instead of just
> branches under a tags/ namespace. =A0Unless you're fine with them
> staying as pseudo-tags, then you can just push them out as you would
> any other branch.
>
> -Jacob
>



--=20
Hannon Hill - Put Us to the Test
bradley.wagner@hannonhill.com | http://www.hannonhill.com
