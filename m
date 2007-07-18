From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 23:32:50 -0300
Message-ID: <46a038f90707171932m67c51388jb2304f0b1873e3a6@mail.gmail.com>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
	 <20070717212103.11950.10363.julian@quantumfyre.co.uk>
	 <20070718015138.GR32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 04:33:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAzLY-0005rp-2Q
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 04:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757892AbXGRCcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 22:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbXGRCcz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 22:32:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:7619 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446AbXGRCcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 22:32:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so34961wxd
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 19:32:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tQZTHfamTN4/XwPlqCnoOs9/Lju9c2VUc1JheeuaylrJMoxyv93C23Nt7cFJk09Ri+HLyI9R3+dnuaL7ETBxAfKdyYMFpQkJ8a32wHL6oiPRs8pAGwzOkK+3WI0KWURKsuRj51w5cvMg/T/EYsndCTHqFcQvp8VOoDINalTz3pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t2w3lfMvwn95aEL2tcneIeyzyJlaNVxh4FThjA30D3niXPmJFCvpwY9R8W/RLz2jyeU4AAOo9L7D58z4JfzXrK2GRTJcfzQ02Gi36rinc/XJm5x9yC/bJdN94EXvGNtK68+3ddREwzhGMRaLD17uVpu9qClGcjTEFyGDoX1KG7I=
Received: by 10.90.81.14 with SMTP id e14mr1065137agb.1184725970813;
        Tue, 17 Jul 2007 19:32:50 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Tue, 17 Jul 2007 19:32:50 -0700 (PDT)
In-Reply-To: <20070718015138.GR32566@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52821>

On 7/17/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>   Applying git-gui: Handle git versions of the form n.n.n.GIT
>

I'm far from an authority on things TCL, but I don't think this patch
should be merged as is. Julian is reporting it as a "fixes my symptom"
patch, and that's barely what it does.

The regex should be more liberal, imho. With this superficial fix:

 - Builds from a dirty tree have a broken git gui

 - Builds from a repo with a nonstandard (local) tagname tagname  have
a broken git gui

cheers,


martin
