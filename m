From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Sun, 29 Jan 2012 21:27:39 -0600
Message-ID: <20120130032739.GB10618@burratino>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
 <1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
 <20120130023642.GA14986@burratino>
 <CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 04:27:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrhuI-0007Qu-FT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 04:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062Ab2A3D1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 22:27:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39999 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab2A3D1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 22:27:45 -0500
Received: by ggnb1 with SMTP id b1so1624721ggn.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 19:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R8CIOtLePIgrW/24rOsBt0UHZpjhDY4tHa0gYEWDZfI=;
        b=AYDYuTVWGz59x/3ruh19VFEQ2T6KVt+HBYZYjqWydolPJvMubjjN0mIXNkT6QJ25PM
         3N2HA4x10jkonvuYrTSzRKH1BfbMaJsXPkuZHC3IdVvo0oWg7D7+AMRB5RLZN8TJTJDk
         r2kYxqPcnSeRt+M7fDgz8RytdxpM18prtxLlM=
Received: by 10.101.101.6 with SMTP id d6mr6861184anm.8.1327894064869;
        Sun, 29 Jan 2012 19:27:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p63sm28909081yhj.22.2012.01.29.19.27.43
        (version=SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 19:27:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189317>

Felipe Contreras wrote:

> Anyway, aren't there easier ways to get this? Perhaps first checking
> if the directory exists, to avoid wasting cycles.
>
> Something like:
>   test -d "$d/remotes" && ls -1 "$d/remotes"

Yeah, that sounds like a good idea.  Could you send a patch that does
that?

Thanks,
Jonathan
