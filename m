From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sun, 16 May 2010 20:35:49 -0500
Message-ID: <20100517013549.GA19081@progeny.tock>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com>
 <4BEFFBB5.7010808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 17 03:35:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODpFB-0004Aq-T6
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 03:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0EQBfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 21:35:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51948 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0EQBfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 21:35:40 -0400
Received: by gyg13 with SMTP id 13so1884772gyg.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=02A/zegsxvdEWWBkE9RqzlOAQGs000q6i/WzZbpZ93c=;
        b=ruFleu8c0it4LYYGG0NsOTCaXZlkgb2RglZ+8Gu4DBNCg3XfIA/PYPrqG2Fi2P+c1r
         6b6EgZdMRMQeUu8wBqrfxHPdKgy16o+H68kUrnMC4BTeHypoV+feH7uqQXxTOFJ8g8UT
         oBReFjBg5iKIEpg4feQPzQEKNfeM9Es6kAEMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Plwsu3yVWxH9Bw/n8rXbf6Zt3tQfCDJlzL5Pz2piYJTn7zNvHTxwmTCaOZIiDaTbmH
         WRmuw8o/2vZU0eeapDZI4dwJrxigU69E+vayxuQvQxJWjE89oTAJ/rHSsu+4FEBFfnfp
         R6cmPn+lTEwvlmPUHx3HFhkvcQNIuT/M8fjqQ=
Received: by 10.101.106.33 with SMTP id i33mr5284520anm.161.1274060139154;
        Sun, 16 May 2010 18:35:39 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a10sm3398150anj.9.2010.05.16.18.35.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 18:35:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BEFFBB5.7010808@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147203>

Michael J Gruber wrote:

> Does the git build process call format-patch? No! The .gitignore we
> distribute is meant for things the build process creates

Ah, true.  I seem to remember a thread long ago about whether to
include editor droppings in .gitignore, but I can=E2=80=99t find it in
the git or lkml archive.

git=E2=80=99s .gitignore does not include .*.swp, \#*#, *~, indeed.

>> +[0-9][0-9][0-9][0-9]-*.patch

So nack from me as well.  It is nice that the .gitignore file we track
does not have to change with fashions, and this way each user can set
up a personal excludesfile according to choice of tools without
interference.

Maybe there should be a reasonable "default" .gitexcludes file in
gitignore.5 as an example, but that is a different topic[1].

Thanks for the reminder,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/96220/focus=3D=
96289
