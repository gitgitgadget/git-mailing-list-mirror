From: James Cloos <cloos@jhcloos.com>
Subject: Re: ls-files
Date: Thu, 09 Oct 2008 18:52:13 -0400
Message-ID: <m3od1t2xfv.fsf@lugabout.jhcloos.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	<20081009061136.GA24288@coredump.intra.peff.net>
	<81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
	<81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
	<alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	<m3ej2p4g3r.fsf_-_@lugabout.jhcloos.org>
	<20081009214118.GZ8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 00:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko4P6-0003kn-Eh
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 00:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbYJIWxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYJIWxd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 18:53:33 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:46032 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYJIWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 18:53:32 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id B6AD94010F; Thu,  9 Oct 2008 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1223592170; bh=zopXw8aTbKIWqSt2QjB+zk2QwyoFzM5YHdwYXuyui
	qg=; h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzeBTc4ABdJRvewMG4AcD8BPQ3lRKyOJEfoyr
	NYzq3oke0v1oIgjSl+rr3RdyaGi1jl/1tpMmbGOaqCB2xMK2E6AgNC8Q1yh3U/KPGIm
	QWnd0NQ9M2fuk85aUhIc597+eSi2HbtMvMEJ3mI7zqJtUYT3Wpc5Mw/kia/o0TnXIFA
	=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 5A68C2107AD; Thu,  9 Oct 2008 22:52:37 +0000 (UTC)
In-Reply-To: <20081009214118.GZ8203@spearce.org> (Shawn O. Pearce's message of
	"Thu, 9 Oct 2008 14:41:18 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2008 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:23:081009:git@vger.kernel.org::tIWQxUXTAaSTtwO4:000000000000000000000000000000000000000000BYU/
X-Hashcash: 1:23:081009:spearce@spearce.org::qIpluLlkO1yaSGbX:000000000000000000000000000000000000000000k6HY
X-Hashcash: 1:23:081009:johannes.schindelin@gmx.de::MHCWxLlNg7mv74I2:00000000000000000000000000000000000a2ud
X-Hashcash: 1:23:081009:xenoterracide@gmail.com::zhiclhMQs3f3ms48:000000000000000000000000000000000000001n2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97900>

>>>>> "Shawn" == Shawn O Pearce <spearce@spearce.org> writes:

>> [ls-files] is vastly more efficient than find(1) or a --recursive
>> call to grep(1).

Shawn> How about using "git grep" then?  No need for ls-files...

I often filter the list of files before passing them to xargs, so git
grep helps for some use cases, but not all.

Also, (at least as of 1.6.0.2.307.gc427), git grep does not support -P
(Perl compatible regexps) or --color.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
