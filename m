From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Sun, 29 Jan 2012 20:36:42 -0600
Message-ID: <20120130023642.GA14986@burratino>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 03:37:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrh76-0007WV-NX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 03:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab2A3Cgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 21:36:52 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38604 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab2A3Cgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 21:36:51 -0500
Received: by ghrr11 with SMTP id r11so1556567ghr.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 18:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vvcer8DJUJ0Z3evDL9sunH0iMTIQEkszkBTSWTbT+wc=;
        b=d2wol4/nspb8Jv7tC0R0QZgzCewbhX+IgcTz0q5WcDVEg81qw5IksgN4iNr0KgXUzA
         z/c0uELzcrXaLBXIhtXuwc3auZWUNj9Aoz9N2xgrAXiD6l+SjPoytMALQkeT1M+7Xax0
         Zz2CvVppTow+BbF7HpVmO6kMVAbwg6trRFuAA=
Received: by 10.236.110.110 with SMTP id t74mr10635288yhg.121.1327891010994;
        Sun, 29 Jan 2012 18:36:50 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a14sm42186496ana.20.2012.01.29.18.36.49
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 18:36:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189313>

Hi,

Felipe Contreras wrote:

> We don't need to check for GIT_DIR/remotes, right? This was removed long
> time ago.

I don't follow.  fetch, push, and remote still look in .git/remotes
like they always did, last time I checked.

Perhaps you mean that /usr/share/git-core/templates/ no longer
contains a remotes/ directory?  That's true but not particularly
relevant.  A more relevant detail would be that very few people _use_
the .git/remotes feature, though it is not obvious to me whether that
justifies removing this code from the git-completion script that
already works.
