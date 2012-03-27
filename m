From: Kevin <compufreak@gmail.com>
Subject: Re: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 19:54:50 +0200
Message-ID: <20120327175450.GA2478@ikke-laptop.lokaal>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:55:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCabj-0007y1-UA
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab2C0Ryz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:54:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44592 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2C0Ryy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:54:54 -0400
Received: by eaaq12 with SMTP id q12so54284eaa.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ffhnk9pc6FwA/e7dSvzcUoO7QZGIK5vMjhs5weO2iJo=;
        b=NYWLoqD7HzIi77bUl+bN/a7XmbpdGQ27LmBaqnJwapvlen7sYcjkm4fWCMaWZ9vUa6
         9t9FAX/GE9Vr15Wj4Z77Y8wFnWL1QPAYmpjvfffjNR8qjYoS+tfXq8UcBDCCynE2LSvE
         DTrZc3T4s7hqht3VQNEEn6jhGiY0v4/GPNXnxOikamCUDiwQ8XDmrxRe84DM456vfTD6
         OSzi5cpWJr95Q3vVS5DRz9MJ9jiLFAtoxKOug/5mjP4nmK6bWw7WGsN/Zj87wxu2HpN0
         zFyz8RedDwBO70ZlyxoyaojrM3khNNmnbSSFNs4+vp978VVyVFDkzs6v3Evoh5ofCKdP
         hu4g==
Received: by 10.14.95.141 with SMTP id p13mr3613822eef.112.1332870893441;
        Tue, 27 Mar 2012 10:54:53 -0700 (PDT)
Received: from localhost (82-169-71-110.ip.telfort.nl. [82.169.71.110])
        by mx.google.com with ESMTPS id x8sm1667178eea.10.2012.03.27.10.54.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 10:54:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194064>

I'm not sure if it's intentional, but notice that 'git://' is repeated in
each of the urls that don't work. If I fix it for the last one, it does
work.

On Tue, Mar 27, 2012 at 08:46:42AM -0700, Junio C Hamano wrote:
> I just noticed that
> 
> 	git ls-remote git://repo.or.cz/alt-git.git/
> 
> works, but neither of the following does:
> 
> 	git ls-remote git://git://github.com/gitster/git.git/
> 	git ls-remote git://git://github.com/gitster/git/
> 
> It is just a minor irritation but it would be really nice if you can fix
> it (please don't spend too much time on it if it is too involved, though).
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
