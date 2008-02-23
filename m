From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: unexpected behavior of 'git rebase'
Date: Sat, 23 Feb 2008 04:48:40 -0800 (PST)
Message-ID: <m3ejb3dejg.fsf@localhost.localdomain>
References: <1203693047.6429.11.camel@pc6411.psi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch>
X-From: git-owner@vger.kernel.org Sat Feb 23 13:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JStof-00014A-Vn
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 13:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYBWMsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 07:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbYBWMsp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 07:48:45 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:25832 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYBWMso (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 07:48:44 -0500
Received: by py-out-1112.google.com with SMTP id u52so1307142pyb.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 04:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=aJo1IQgCwWEMriaN/2NcFXUVyxQrVm6jwIJoP8krB7Q=;
        b=Dh3m5JUvhwcQKDos2+dXgoKFIXgeJfS8PR1RTJyE7osku/WpM1mZI71W2dQQ+y2Hpy/s+M+RNN83qtXKn3bDys351gHrNzlEuZ6EP3g7qbXJOcK5htKYvS0j5n+PLmzlbN9gFZgWZT/MtUH+lMZyDfcR/yrVWB5TCQTFxKgdlWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=nGRNHA/nEcqbqDUaZg+xkRTEcrVskxdgPF5fHrDjQJ1/eeiLvuBS0JsR3vBPt5a26/2lYF0SDpgmFFeteAgQBd3Ht1MeETTTJ+nrY+9Dpvf6sqTbeS8mu7ZMgXQNXBLkVJzn9vM2ZCCkSZ21lH8DUVGWT2XBgkOQQJcUmjJGe94=
Received: by 10.64.233.12 with SMTP id f12mr858395qbh.64.1203770921640;
        Sat, 23 Feb 2008 04:48:41 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.83])
        by mx.google.com with ESMTPS id 7sm81440nfv.35.2008.02.23.04.48.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 04:48:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1NCmaCe012531;
	Sat, 23 Feb 2008 13:48:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1NCmZip012528;
	Sat, 23 Feb 2008 13:48:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1203693047.6429.11.camel@pc6411.psi.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74817>

"Alxneit-Kamber Ivo" <ivo.alxneit@psi.ch> writes:

> I found that 'git rebase' does not include stashed stuff.

This, I think, is caused mainly by the fact that stash is currently
global per repository, and not per-branch thing.

You can always rebase stash on top of after-rebase branch.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
