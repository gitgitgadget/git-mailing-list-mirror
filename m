From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg branch --delete doesn't work
Date: Fri, 21 Sep 2007 11:48:30 +0200
Message-ID: <20070921094830.GB26307@diana.vm.bytemark.co.uk>
References: <cc723f590709202140y677a17d0y504b8cfa8b66606b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, catalin.marinas@gmail.com
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 11:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYf81-0006QM-6q
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 11:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbXIUJsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755086AbXIUJsi
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 05:48:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3970 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbXIUJsh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 05:48:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IYf7f-0006zH-00; Fri, 21 Sep 2007 10:48:31 +0100
Content-Disposition: inline
In-Reply-To: <cc723f590709202140y677a17d0y504b8cfa8b66606b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58837>

On 2007-09-21 10:10:45 +0530, Aneesh Kumar wrote:

> [review@linux-review-ext4]$ git checkout master
> Switched to branch "master"
> [master@linux-review-ext4]$ stg branch --delete --force review
> Deleting branch "review" ...
> fatal: Needed a single revision
> stg branch: refs/heads/review does not exist
>
> And it leaves in .git/config
> [branch "test2.stgit"]
>         stackformatversion =3D 2
>
> So a later stg init also fails.

Ow! You'd think we'd have a test for that ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
