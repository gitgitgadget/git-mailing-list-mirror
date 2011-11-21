From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Feature requset: listing of current stash in git gui
Date: Mon, 21 Nov 2011 11:53:03 +0100
Message-ID: <4ECA2D8F.4060005@atlas-elektronik.com>
References: <201111211100.52367.dexen.devries@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: dexen deVries <dexen.devries@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 11:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSRUu-0005Tw-KL
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 11:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab1KUKxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 05:53:06 -0500
Received: from mail96.atlas.de ([194.156.172.86]:16663 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab1KUKxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 05:53:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id C850710074;
	Mon, 21 Nov 2011 11:53:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id Z7vOahbFGBL4; Mon, 21 Nov 2011 11:53:03 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon, 21 Nov 2011 11:53:03 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 4213A2717B;
	Mon, 21 Nov 2011 11:53:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <201111211100.52367.dexen.devries@gmail.com>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185740>

Am 21.11.2011 11:00, schrieb dexen deVries:
> Hi,
> 
> 
> please consider listing modifications stored in git's stash somewhere in git 
> gui window. Perhaps above the `Staged Changes' subframe. Format of the listing 
> similar to output of `git stash list'. Available operations would be Pop, 
> Apply, Save and Drop.

You can simply put the following in your ~/.gitconfig:

[guitool "Stash/show"]
	cmd = git stash show -p
[guitool "Stash/list"]
	cmd = git stash list
[guitool "Stash/pop"]
	cmd = git stash pop
[guitool "Stash/drop"]
	cmd = git stash drop
	confirm = yes

That will give you a new sub-menu in the 'Tools' menu of git gui.

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: Dreams are free, but you get soaked on the connect time.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
