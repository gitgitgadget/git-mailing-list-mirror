From: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
Subject: Re: Simple problem
Date: Mon, 28 Apr 2008 18:58:51 +0000 (UTC)
Message-ID: <fv56pb$ceb$1@ger.gmane.org>
References: <fv4u49$oks$1@ger.gmane.org>
	<18453.64747.540905.586259@lisa.zopyra.com>
	<20080428164945.GA14445@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:00:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYa6-0008Ip-AE
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935192AbYD1S7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 14:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935078AbYD1S7F
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:59:05 -0400
Received: from main.gmane.org ([80.91.229.2]:48535 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933786AbYD1S7D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:59:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JqYZ2-0001hh-H5
	for git@vger.kernel.org; Mon, 28 Apr 2008 18:59:00 +0000
Received: from pool-71-161-56-12.clppva.east.verizon.net ([71.161.56.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 18:59:00 +0000
Received: from kt-usenet by pool-71-161-56-12.clppva.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 18:59:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-161-56-12.clppva.east.verizon.net
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80586>

On Mon, 28 Apr 2008 18:49:45 +0200, Bj=C3=B6rn Steinbrink wrote:

[Snip]
> That restores the version from the index, so it will fail if you did
> "git rm file". To get the file from HEAD use "git checkout HEAD --
> file".

Thanks.  I tested this and it works as advertised.  I took a look at th=
e=20
man page and I understand what the -- is for too. =20

I had actually tried:

git checkout myfile.java

and this didn't work.



--=20
Kenneth P. Turvey <kt-usenet@squeakydolphin.com>
