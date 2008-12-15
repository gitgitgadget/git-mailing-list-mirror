From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: hooks/post-update execs git-update-server-info
Date: Mon, 15 Dec 2008 09:06:20 -0800 (PST)
Message-ID: <m3zlixcqrb.fsf@localhost.localdomain>
References: <gi600m$tts$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:07:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGuz-0005Xy-Ro
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbYLORGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYLORGY
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:06:24 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:58487 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbYLORGX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:06:23 -0500
Received: by ewy10 with SMTP id 10so3147714ewy.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 09:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=eM7/01kLXyusgq/GJHDe+Vxj4+qCYi7b+3rRUUE7pJA=;
        b=uNv/MRTTE4tgZUjy1dAWrXgk0GCrO+MnY2JIqW0D3xRWyslfMNSD9mn0qyT0f/1weS
         noFDOmvZMWhm+gu2Uhu2ORI6omX/BFmsSs0h8BJ/n8/saGpcG2Mc5AbVKcq9EGgfI+ng
         3os8x5bZHlLelUGW5q6mkH52PlNOTMXBUaQpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=uzo+25VJkhhXorZo2kEYbQs2kGIihnkfcxAGu2yhKGvNVkcIyK8LZBZNDqdndV/zDr
         qnrjafXROsyKgy+vjXwZOPjOvVufheDPl2EVoTd72SLkrDsw/YOT4hgzkSFdjszCa7Ev
         MNwuBRHpOHyxYoGKLiCr7G/gX0iGafL8T2fv4=
Received: by 10.210.67.4 with SMTP id p4mr7989219eba.150.1229360781178;
        Mon, 15 Dec 2008 09:06:21 -0800 (PST)
Received: from localhost.localdomain (abva128.neoplus.adsl.tpnet.pl [83.8.198.128])
        by mx.google.com with ESMTPS id 3sm1078612eyj.55.2008.12.15.09.06.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Dec 2008 09:06:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBFH6IvO003638;
	Mon, 15 Dec 2008 18:06:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBFH6HsP003635;
	Mon, 15 Dec 2008 18:06:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <gi600m$tts$2@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103184>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> shouldn't .git/hooks/post-update contain "exec git
> update-server-info" (note the space not hyphen) instead of
> "exec git-update-server-info"?
> 
> Either I am horribly confused or HTTP pulls have not been
> working on post 1.6 gits and no one has noticed till now :-)

If I understand correctly hooks run with GIT_EXEC_PATH prepended to
PATH, so everything should work; and it has to work to not force users
to upgrade their (perhaps customized) hooks after upgrading git.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
