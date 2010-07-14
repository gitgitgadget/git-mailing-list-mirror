From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [BUG] git-svn returning "Incomplete data: Delta source ended 
	unexpectedly"
Date: Wed, 14 Jul 2010 22:16:51 +0000
Message-ID: <AANLkTil-QOQHNYIRvqDzfwicjo9SLXJPwgby-Z0b9rlT@mail.gmail.com>
References: <AANLkTiljzOuaEToKscBxlc4qGilyNRiUtjoBxW1lJZlp@mail.gmail.com>
	<20100714210940.GA7803@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 15 00:17:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZAGC-00083U-NS
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 00:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab0GNWQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 18:16:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39037 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab0GNWQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 18:16:54 -0400
Received: by iwn7 with SMTP id 7so247857iwn.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=csS0mpzKWmvyc+wZ753edGsDXfcuseEN04wEq4Q23u4=;
        b=UNC6f3azoZtzdRH5TwEpTndmSlc/y/SYURqP8E8V5ggK1AXg16m1QMBhQBbW/ZBmLt
         EYrBRWA08d9D2kFzIK2IcENOI5wInzmMk2Q9KHHHlL9EXcg04cNfT7xEqUT17PBiA3D9
         Ao9tE75yGcI0IslhCNAHEfOLZQ70+5vA48rnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UtctSXBvU6zqoL+4uv8wIWIInrduw78y6pzRoSqSaiE/nRvnW3N/Ky5TslQIVDyoKW
         0eEIKwP0kqQduK99EPfLp4RAz1lxoYFNPbpjygTAZHGJTkCsASlFrwjzK7t1iJx/yrSc
         OSvGE+UAiPMHXZrEpKOiazVII9qctEpSFH8hQ=
Received: by 10.231.37.140 with SMTP id x12mr12222239ibd.190.1279145811956; 
	Wed, 14 Jul 2010 15:16:51 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 14 Jul 2010 15:16:51 -0700 (PDT)
In-Reply-To: <20100714210940.GA7803@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151039>

On Wed, Jul 14, 2010 at 21:09, Eric Wong <normalperson@yhbt.net> wrote:

> Something went wrong with your mirror script (the way you're doing
> externals is probably screwing it up, badly).
>
> Compare the "git svn log" output of your in-progress repository
> with the "svn log http://josm.openstreetmap.de/svn/trunk"
>
> The revision numbers/commit messages don't sync up at all.

Sorry for the false alarm, I didn't check that. Thanks for looking at
it, and sorry for wasting your time.
