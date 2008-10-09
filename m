From: James Cloos <cloos@jhcloos.com>
Subject: ls-files [Was: Re: Fwd: git status options feature suggestion]
Date: Thu, 09 Oct 2008 17:23:45 -0400
Message-ID: <m3ej2p4g3r.fsf_-_@lugabout.jhcloos.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	<20081009061136.GA24288@coredump.intra.peff.net>
	<81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
	<81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
	<alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 23:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko37e-0000AN-Cx
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbYJIVb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbYJIVbZ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:31:25 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:39273 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960AbYJIVbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:31:25 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 17:31:24 EDT
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 5FB3D40090; Thu,  9 Oct 2008 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1223586852; bh=D+N1W2gV631/CFAnnZq0VRX72fY5AHdI/9oOqqnML
	v8=; h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPLGF4OUdf/HUTYoKs+qjThaJtkQDO7NXzL7K
	FbAM+u9ECXgoadQEwCE7vT3SgYClrsI/s0/JnEPvOR6KTeEWpdteIdxTp4VstIoMqjj
	8KcRMsYCcTpYGdrIH9x2Lge/OoQYmG2VHO7W5BIj29416uZa5LuVXBrr7E/kwm7tjc4
	=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 10F6221076A; Thu,  9 Oct 2008 21:24:09 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	(Johannes Schindelin's message of "Thu, 9 Oct 2008 11:03:31 +0200
	(CEST)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2008 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:23:081009:git@vger.kernel.org::WzbBkeTI0iWEjOJU:0000000000000000000000000000000000000000000dGJ
X-Hashcash: 1:23:081009:johannes.schindelin@gmx.de::9M/gE0b6W7Qb1y8A:00000000000000000000000000000000001nYJQ
X-Hashcash: 1:23:081009:xenoterracide@gmail.com::SJp0TOEbl9ofzHAl:00000000000000000000000000000000000000hwYx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97890>

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > How about "git ls-files -o"?
>> 
>> doh... hadn't even heard of that command.

Johannes> Which is good!  As ls-files is listed as plumbing.
Johannes> Users should not need to call ls-files,

That is a bug, then.  ls-files is one of the more important user-level
commands in git.

It is vastly more efficient than find(1) or a --recursive call to
grep(1).

Searching through a repository to find which file(s) define or use some
function, struct, class or similar is a common occurance.  Or to find
which dir(s) contain(s) file(s) matching a given regexp.  Or a number
of other uses.  (Tags might be useful if one does a lot of searching
in a given repo, but grep is quicker for infrequent searches and the
tags utils do not support all file types.)

ls-files is definitely dual-use.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
