From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Mon, 29 Aug 2005 19:16:26 +1200
Message-ID: <46a038f90508290016624b3f4@mail.gmail.com>
References: <deofnh$jl0$1@sea.gmane.org>
	 <46a038f905082623595c051c0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 09:18:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9dt3-0007w8-O1
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 09:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVH2HQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 03:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVH2HQ1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 03:16:27 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:32909 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751178AbVH2HQ1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 03:16:27 -0400
Received: by rproxy.gmail.com with SMTP id i8so925469rne
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 00:16:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J2xqZATzxHqzfJZo0m9FVRsRBPF3kWRMgdRYn4ReJvG9DOrLWZy9P90AAUliPc2pihaCHb41V9P24yzbV/whzrJ0GutsMsbG7FQIZintGYBYJ0sV8hg+GJ/7eqDjq4ypFAs7gJoiDKJ1mv/XNyJMhh0Yq7TlJIJXbbQLe1Vafwg=
Received: by 10.39.3.58 with SMTP id f58mr193871rni;
        Mon, 29 Aug 2005 00:16:26 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 29 Aug 2005 00:16:26 -0700 (PDT)
To: John Ellson <ellson@research.att.com>
In-Reply-To: <46a038f905082623595c051c0b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7892>

On 8/27/05, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> There is _one_ bug I've seen with cg-diff and I haven't had time to
> fix. On OSX, running cg-diff with no parameters doesn't show anything.
> For some reason, it fails to list the files. If you give it the paths
> explicitly, it'll give you the appropriate diff.

Blame the xargs implementation. Fixed.


martin
