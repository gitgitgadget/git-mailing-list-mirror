From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 11:03:42 +0700
Message-ID: <fcaeb9bf0801152003j54b210edk450d6410109411fd@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzVc-0008Tx-Ux
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329AbYAPEDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756533AbYAPEDo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:03:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:20766 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYAPEDo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:03:44 -0500
Received: by fg-out-1718.google.com with SMTP id e21so115386fga.17
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kRl6PNoMuv6VC4A5FWfqO+MwHiqLTPTFC2BeH0UoIKM=;
        b=xl6q5uG1YasG8ArP+lYT6bqmalfsTIz7r/iZuJpgscWYRevNC5IfMOrh+MgLHiF+JNO97lrBPnIQe3XDhlMJ/XPvava9MJav+yYhQC866TUZh3NBGwTr8EEGIlvQKH1+yd1sMtcuzzAWKjfE3Lfx34wiBjJwfrYQxBk1fsfkPfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZsBkO248brN39frWrpLO20bMajJss2TitcoeZl+uqfrAr7tph36tQwCUqN5wB+py55afU6G8o6aJvywP1nKD4K3KfWxnCUp2swrqjx5IpbGkLZu1eDbaj4bLh4g+4dGUhgJOfWGTiSwVIvJrPvOlEjFfq5bgKhwlWqRQ6U2blzY=
Received: by 10.86.100.7 with SMTP id x7mr293236fgb.10.1200456222635;
        Tue, 15 Jan 2008 20:03:42 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Tue, 15 Jan 2008 20:03:42 -0800 (PST)
In-Reply-To: <478D79BD.7060006@talkingspider.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70615>

On Jan 16, 2008 10:27 AM, Mike <fromlists@talkingspider.com> wrote:
>
> I'm learning git and I'm really annoyed that the .git directory lives in
> the same directory as my code.  I don't want it there for three reasons:
>
> 1. My code lives on a development web server docroot, and I don't want
> the .git repository to end up getting published to the live site by
> accident. (I would imagine this would be a common need.)
>
> 2. If I tar/gz my code and deliver it to a client, I don't want the .git
> dir slipping into the tarball, allowing my client to be able to peruse
> the history of what we did and when.
>
> 3. The .git respository will get big, especially with binary files in
> it, and I want it someplace with a lot of disk space. And I don't want
> it to get tarred up when we migrate the site to a different server. (And
> tar isn't aware of hard links is it? wonderful.)
>
> How do I make the repository dir live somewhere else, the hell away from
> my code? Thanks

Setup GIT_WORK_TREE and GIT_DIR env variables or use --git-dir and
--work-tree together. See "man git" for more detail.
-- 
Duy
