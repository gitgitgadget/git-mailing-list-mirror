From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: git log --stat FILE
Date: Sun, 08 Aug 2010 14:35:48 +0200
Message-ID: <yf9bp9ds2mz.fsf@chiyo.mc.pp.se>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se>
	<AANLkTikKwp9gS9nt=JnsdyXMgx+PxrhHhNFftYFqX+M_@mail.gmail.com>
	<yf9d3tts438.fsf@chiyo.mc.pp.se> <201008081426.21705.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 14:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi56b-0008NA-GT
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 14:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab0HHMfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 08:35:52 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:45274 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0HHMfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 08:35:51 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 23FF7E95F;
	Sun,  8 Aug 2010 14:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1281270950; bh=04d++gvKMLg/uxYE1s6MakAjOZZMFFEc6RxgH7tPkf4=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LjGqzBA05h3WkOkbOTgNL5TiVi7JeGr8rmeZL
	k4rnx3Bsjn6SIYMlhPuSx5t/QjoieZQdYIkdZIa3+OlCaIgVOQ4Pfx6b+BrlCD8cVuU
	mOPIN39fkvSmnmnNyixhj3XH1Dvqd/SoBWsZRKCmCX7Z0kWKF2tl6H3GUlH/kcWWTPI
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Oi56T-00059A-75; Sun, 08 Aug 2010 14:35:49 +0200
In-Reply-To: <201008081426.21705.jnareb@gmail.com> (Jakub Narebski's message of "Sun, 8 Aug 2010 14:26:21 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152904>


Jakub Narebski <jnareb@gmail.com> writes:

> Diffstat is just a diff format (a way of presenting diff); '--stat'
> is described in "Common _diff_ options" of git-log(1) manpage.
>
> But whats obvoud to me might not be obvious to everyone.

To me (and probably many others), a "diff" is the output of the
command "/usr/bin/diff".  I notice that git seems to refer to this as
a "patch" instead.  Nevertheless, the documentation of --full-diff
explicitly talks about "log -p", rather than "diffs" in general.  So
it's not clear from the documentation that it affects other types of
diffs than those produced by -p ("patches").


  // Marcus
