From: Jim Greenleaf <james.a.greenleaf@gmail.com>
Subject: Re: git stash deletes/drops changes of
Date: Thu, 23 May 2013 16:57:23 +0000 (UTC)
Message-ID: <loom.20130523T185301-635@post.gmane.org>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 19:00:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfYsA-0008Uh-6S
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 19:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757143Ab3EWRAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 May 2013 13:00:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:42124 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862Ab3EWRAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 13:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UfYrz-0008Nw-Fs
	for git@vger.kernel.org; Thu, 23 May 2013 19:00:04 +0200
Received: from 112.205.196.58.pldt.net ([112.205.196.58.pldt.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 May 2013 19:00:03 +0200
Received: from james.a.greenleaf by 112.205.196.58.pldt.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 May 2013 19:00:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 112.205.196.58 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225267>

Adeodato Sim=C3=B3 <dato <at> net.com.org.es> writes:

> I was unpleasantly surprised to discover yesterday that doing `git
> stash` on a repository where I had previously run `git update-index
> --assume-unchanged FOO` completely lost all changes I had in file FOO=
=2E

I just ran into this today.

Was a decision about this behavior reached in the intervening time?
