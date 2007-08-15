From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: Restoring files from old commits
Date: Thu, 16 Aug 2007 02:28:42 +0900
Message-ID: <f9vd4l$dj6$1@sea.gmane.org>
References: <4698BD17.5080205@random-state.net>	 <20070714123754.GA29622@piper.oerlikon.madduck.net>	 <20070714143233.GC2544@steel.home>	 <7vbqeeizue.fsf@assigned-by-dhcp.cox.net>	 <20070715084141.GA2568@steel.home> <6bcc356f0708151022v6cb8c348nb19690c81e489c5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 19:29:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILMgK-0001Wd-L3
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 19:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbXHOR3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 15 Aug 2007 13:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756297AbXHOR3Q
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 13:29:16 -0400
Received: from main.gmane.org ([80.91.229.2]:50394 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbXHOR3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 13:29:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILMg5-0000WN-PR
	for git@vger.kernel.org; Wed, 15 Aug 2007 19:29:05 +0200
Received: from 221x115x75x108.ap221.ftth.ucom.ne.jp ([221.115.75.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 19:29:05 +0200
Received: from salikh by 221x115x75x108.ap221.ftth.ucom.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 19:29:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 221x115x75x108.ap221.ftth.ucom.ne.jp
User-Agent: Thunderbird 2.0.0.4 (X11/20070708)
In-Reply-To: <6bcc356f0708151022v6cb8c348nb19690c81e489c5d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55930>

Nikodemus Siivola =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> So what I'd like is something like
>=20
>  git cat-path <commit> <path-in-the-tree-referenced-by-that-commit>
>=20
> Does this exist, or is this scripting time?

Have you tried

   git show <commit>:<path>

?
