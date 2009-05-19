From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: Re: committing to a checked out branch
Date: Tue, 19 May 2009 12:01:00 -0500
Message-ID: <bbd12f0f0905191001iad76a64id648780547b43b34@mail.gmail.com>
References: <bbd12f0f0905181733h6a9537d2hf4e6b7a1384fa32d@mail.gmail.com>
	 <76718490905181917u1f41e06dq9cf527a1dac9bea5@mail.gmail.com>
	 <bbd12f0f0905190809k3dc13c3ak170535a5c0eed9b9@mail.gmail.com>
	 <76718490905190821p1776905bn53610c0e8acd0113@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 19:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Sgh-000426-As
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 19:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbZESRBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZESRBA
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 13:01:00 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:60707 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbZESRBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 13:01:00 -0400
Received: by bwz22 with SMTP id 22so3955102bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 10:01:00 -0700 (PDT)
Received: by 10.204.59.18 with SMTP id j18mr213130bkh.206.1242752460684; Tue, 
	19 May 2009 10:01:00 -0700 (PDT)
In-Reply-To: <76718490905190821p1776905bn53610c0e8acd0113@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119551>

On Tue, May 19, 2009 at 10:21 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> On Tue, May 19, 2009 at 11:09 AM, Jeff Brown <jeff@jeffandbetsy.net> =
wrote:
>> When I create a new repo on my server I have been creating an empty
>> directory, then git init, then git add some file and commit. =A0I ex=
pect
>> that is the long/wrong way to initialize a repo, especially if I wan=
t
>> it to be bare. =A0What is the best approach to creating a cloneable =
bare
>> repo?
>
> server$ mkdir /path/to/newrepo.git
> server$ cd /path/to/newrepo.git && git init --bare
> laptop$ git clone ssh://server/path/to/newrepo.git
> laptop$ cd newrepo
> laptop$ # add; commit; add; commit; ...
> laptop$ git push origin master
>
> (This may only work with recent versions of git as I believe earlier
> versions used to complain about cloning an empty repository.)
>

git init --bare

That is the bit I needed.

Thanks again!



jb

--=20
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
=46ind The Cause ~ Find The Cure
http://www.autismspeaks.org/
