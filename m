From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Digging through old vendor code
Date: Sun, 13 Jan 2008 12:04:17 -0500
Message-ID: <9e4733910801130904n7f311915tba4aa5b766c7a9bc@mail.gmail.com>
References: <20080113162806.13991.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: "linux@horizon.com" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:04:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE6GT-0004Sc-Pr
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 18:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbYAMREU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 12:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYAMREU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 12:04:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:55401 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbYAMRES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 12:04:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1508950rvb.1
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 09:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NwbvJ1PgedpGTXk8Vjdd+uFoLxjecxaiL7kb8L2NxzI=;
        b=bthRbpUcjWglvwjNzfH3LLNuQJbrZZSZxHAqdbJ/1tNzlQYSANzcGuG7EyCRYX0KiNVk826wOYeulSle/2i6f7/ZSXtLoLA0p+17XYUIzG6dDQRAtNlroClX0iy0kgXrrTICOPWNXinYUZF/hp/EksxLkPx8O83D02+jkZJMXec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4ruCFvYhOEYRn7RkVrlguX4HBN+DrbO+9tX4ztW/7A3u561lnvM+nMQBX38Lwu5nLN5URAYEPB++8t5HWJXn2Rl8G1gVg8pvLlITGj1chvWxa7XwNl5qfqb3adBhEIrldv6TqKMWgaGyBBb6lz5Y+1q/kfRookc1HcNta/BTSA=
Received: by 10.140.170.12 with SMTP id s12mr3250888rve.101.1200243857276;
        Sun, 13 Jan 2008 09:04:17 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Sun, 13 Jan 2008 09:04:17 -0800 (PST)
In-Reply-To: <20080113162806.13991.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70399>

The vendor gave me an edited file with support for their device. The
original was copied from the kernel somewhere around 2.6.15 and then
edited. Nobody remembers what the source file was but there are a
couple of fairly close matches.

Diffing against the current kernel mixes the two sets of changes -
what the vendor did and what changed in the core kernel. I'm sorting
this out by hand but it is 3,000 lines of diffs.

It is an interesting problem to use the git history to try and
discover the original source file.

-- 
Jon Smirl
jonsmirl@gmail.com
