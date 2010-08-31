From: Craig de Stigter <craig.destigter@koordinates.com>
Subject: merging branches with separate but identical history
Date: Wed, 1 Sep 2010 09:01:09 +1200
Message-ID: <AANLkTikTzZe=c=RaEYSr_wjfHht4PZihggnV9vEOehvy@mail.gmail.com>
References: <AANLkTikoDkhKTRmob=B_NYJSYoby0J3Zo-Qp43AU9WfZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 23:01:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqXxF-00047g-Ld
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 23:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab0HaVBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 17:01:12 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56223 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab0HaVBL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 17:01:11 -0400
Received: by eyb6 with SMTP id 6so224335eyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 14:01:10 -0700 (PDT)
Received: by 10.216.159.195 with SMTP id s45mr6856693wek.43.1283288469957;
 Tue, 31 Aug 2010 14:01:09 -0700 (PDT)
Received: by 10.216.195.131 with HTTP; Tue, 31 Aug 2010 14:01:09 -0700 (PDT)
In-Reply-To: <AANLkTikoDkhKTRmob=B_NYJSYoby0J3Zo-Qp43AU9WfZ@mail.gmail.com>
X-Google-Sender-Auth: yaoBc4E_FxEW0z2Dt0NBINTrVuM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154980>

Hi list

I have two branches which start with the same commits, and I want to me=
rge them.
I believe the two branches were individually pulled from the same SVN
repo, so they look like this:

branch1: a--b--c--d--e--f--1--3--5
branch2: a--b--c--d--e--f--2--4--6

If I do:
> git checkout branch1
> git merge branch2
Merge made by recursive

The merge succeeds but the commits in each branch aren't squashed
together (git log shows two commits for each actual commit)
=A0i.e., now my history looks like this:

a--a--b--b--c--c--d--d--e--e--f--f--1--2--3--4--5--6

Is there a way to do this without the duplicates? (perhaps a way to
mark the branch as merged up to 'f', without actually performing a
merge?)

Thanks
Craig de Stigter
--
Koordinates Ltd
PO Box 1604, Shortland St, Auckland, New Zealand
Phone +64-9-966 0433 Fax +64-9-969 0045
Web http://www.koordinates.com
