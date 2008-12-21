From: James Cloos <cloos@jhcloos.com>
Subject: Re: how to check remote git repo for updates without pull/fetch
Date: Sun, 21 Dec 2008 04:53:38 -0500
Message-ID: <m38wq9zwee.fsf@lugabout.jhcloos.org>
References: <494BC89F.9070107@gmail.com> <m3skoi21m3.fsf@lugabout.jhcloos.org>
	<402731c90812201541r510170tbe1d56b7261e8146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ivan Zorin" <ivan.a.zorin@gmail.com>, git@vger.kernel.org
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 10:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEL31-0001je-G6
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 10:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbYLUJyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 04:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYLUJyU
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 04:54:20 -0500
Received: from eagle.jhcloos.com ([207.210.242.212]:39812 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYLUJyT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 04:54:19 -0500
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 3A21D40090; Sun, 21 Dec 2008 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1229853258; bh=pkWtLG72RJk1VoOBpJh15XcawTTURF8d5m+aIaFZ4
	fE=; h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xz7VD+cnVU6jDzrL1UuatclLYeX6l+ukdzdM0
	l9sqb4Zq5NrWfDbO6PipvzwA2ue4UU//WM0QLpq/yccor9iXlwuIR3VaJ8xb52Vc7lA
	gvZPPbiNjud3k6Q9O3hGWFlneT8Eg7fhYJ9yHgVq0vRTyoTi3MYCIkbvWbUXffQpzus
	=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id C06D7FEC1E; Sun, 21 Dec 2008 09:54:01 +0000 (UTC)
In-Reply-To: <402731c90812201541r510170tbe1d56b7261e8146@mail.gmail.com>
	(David Aguilar's message of "Sat, 20 Dec 2008 15:41:13 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2008 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:23:081221:davvid@gmail.com::fiR8igsqmutHq5aJ:09wuW
X-Hashcash: 1:23:081221:ivan.a.zorin@gmail.com::WTGZmN/IGlvAcYtB:000000000000000000000000000000000000000jI4z
X-Hashcash: 1:23:081221:git@vger.kernel.org::jodk8M61yQ130y8l:0000000000000000000000000000000000000000016s/r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103694>

>>>>> "David" == David Aguilar <davvid@gmail.com> writes:

David> Your script will report false positives if you run that in a branch
David> where you've made local commits since git log's output will list a
David> commit that's not on the remote side.

Ah.  Yes.  I forgot to mention that.  Good catch.

I wrote the script specifically for use with the repos created by Gentoo's
git eclass (used when installing packages from git repos rather than from
tars or the like).  As such, it only needed to deal with pristine clones.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
