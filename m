From: David Aguilar <davvid@gmail.com>
Subject: Re: [BUG] "git-mergetool -t emerge" does not fully die on Ctrl-C
Date: Wed, 27 May 2009 23:05:08 -0700
Message-ID: <20090528060508.GB21329@gmail.com>
References: <49338.10.0.0.1.1242121084.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Thu May 28 08:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Yk0-0002Ki-AF
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 08:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759634AbZE1GFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 02:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758635AbZE1GFO
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 02:05:14 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:47799 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbZE1GFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 02:05:13 -0400
Received: by pxi29 with SMTP id 29so806084pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 23:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bYwBp4MA2TS6ck2rAhwoBLY68qvpAIJXKON2f4cs+r8=;
        b=b9gDju5zvHVVe/vJHJj6Mt+jd6byRXuarRlMD1ydlNo3TVAHWSVTJsHFwEUj7CJ2Ns
         66CFp2qtVxLKGOkJdPiZ+jiFfbyKNOAMBE76M3fL+VqftpM1uTuV3A+EwOgA7FEoltn0
         NfkKqZ4CV9AbET7iyFgCzvhFqmIi5pL7pHBp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RnbhKSiqx2AK6dIDxDW3vtjETl60+bfIV3ZvMVoY8Dfr2Ju2OytcmaYyvQWXqv+FEE
         Mg86dstf4aHpN+I/DyBHynii5lI5q0/eL7qwZdPBZuXO/UqK1RmnFGqoqm1qhQFs2BtQ
         BRg+6fX7uVID6pTpyIWFNEVcDHZyDHwH04NJU=
Received: by 10.114.72.1 with SMTP id u1mr579373waa.154.1243490715168;
        Wed, 27 May 2009 23:05:15 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v9sm3889154wah.1.2009.05.27.23.05.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 23:05:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49338.10.0.0.1.1242121084.squirrel@intranet.linagora.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120154>

On Tue, May 12, 2009 at 11:38:04AM +0200, Yann Dirson wrote:
> While playing with the various tools supported by mergetool, I noticed
> that, while with most tools you can just use Ctrl-C and git-mergetool as
> well as the external tool get killed, the behaviour with emerge looks
> buggy: whereas the toplevel "git" process gets killed, the children
> git-mergetool as well as emacs are not impacted, and the merge continues
> in the background.

Sorry for the late reply (your email got lost in the traffic).

We don't do anything particularly special for emerge.
Can you identify a specific flag or setting that might be
causing this?

I just tried emerge with difftool and it worked just fine.
What platform are you on, etc.?

-- 

	David
