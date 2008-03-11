From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial's only true "plugin" extension: inotify... and can it be done in Git?
Date: Tue, 11 Mar 2008 11:00:08 +0100
Message-ID: <200803111100.10302.jnareb@gmail.com>
References: <200803091459.21354.jnareb@gmail.com> <200803101938.09300.jnareb@gmail.com> <47D6541F.8000503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mercurial@selenic.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Mar 11 11:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ1I5-0005su-RM
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 11:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYCKKAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 06:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYCKKAW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 06:00:22 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:37775 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbYCKKAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 06:00:21 -0400
Received: by py-out-1112.google.com with SMTP id u52so3453479pyb.10
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=3zS2SPQCEGVtG8Rt80Fvr32iuEFdlDkLucWzlXSt3Z4=;
        b=R38My+r3p82Q4TkC8/W3yWpHml5gd8eznzBaHZUmalzFIttEdOY3GFXeYfO0bC7wobs3yYwoh68RhdTqAlORRnZnFy7BHB1wOd3XYgWcR7xemY/sJbixgT32bhWG0IOHsRGH5eIl6vJD8zMO6Hj/j9yUavn6686sZ5YwidmsIVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ptqZR402A76MmrCFAcI48MSlPIpFNEJE5K4dV0sTlua7rJRgdn5Sa2uMVN7sO8gturlk+SB7WUjRlNanBYN/NLbmzJ1HYwwm1x1K6eKcMYZ4CeFg63V6GqgKCCf3hDEEhyz+/K/5+TYAv1PTQzhzWkUE4V1VtkD4jrQ4YFsKj3Q=
Received: by 10.65.242.7 with SMTP id u7mr12865377qbr.59.1205229617142;
        Tue, 11 Mar 2008 03:00:17 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.230.40])
        by mx.google.com with ESMTPS id k1sm33461012ugf.29.2008.03.11.03.00.14
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 03:00:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <47D6541F.8000503@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76827>

Andreas Ericsson wrote:
> Jakub Narebski wrote:
> > 
> > Mercurial extension | git equivalent (or proposal)
> > --------------------+------------------------------------
> > bisect              | git-bisect
> > 
> > Footnotes:
> > ==========
> > (*) Directly inspired by git feature
> > (!) No direct equivalent, would be quite a work to add
> > (!!!) No equivalent, don't know if possible
> > 
> 
> IIRC, bisect should have a star here (or five, as it's a killer
> feature). 

I was not sure if bisect extension didn't come to Mercurial from/via  
BitKeeper; IIRC it was added at request of Linux kernel, but I might be 
mistaken...

So in short: the star isn't here because I was not sure.

-- 
Jakub Narebski
Poland
