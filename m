From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 17:54:29 +0200
Message-ID: <200809121754.30277.jnareb@gmail.com>
References: <19449377.post@talk.nabble.com> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com> <20080912145804.GF10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:55:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAzx-0001IQ-BW
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbYILPyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbYILPyh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:54:37 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:15981 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbYILPyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:54:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so108416and.103
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=j6uOK4qcmyKxNKIDY4y1qIsT5poxX9+gXALY064MKSI=;
        b=vh6ysvCdDTtwL+qQvr8Ts2oifqB6XJr5DyD2AmQSmRs8Y0wV2ESTEL/yPEya8R9wEq
         ypkUHWnQv8oxJfZsj1Rpuq9fS5fnLt7B3iW/J365U6DrnDChU3wIS8UAe1bSSoLhVdhQ
         2KgFwmH9NcaNBqVq0jJF3YdgkMcVmjneJy+7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LFQ29KeExt9aU2BpVbAYNfiEwBMUCVuVFymhrY+V9FlkvZL2edD4mw5GGTOXzVsvRq
         eHxrnf/+ehIHQrljnIxrd8nmGDZut+OrDKjA7bmIUcVgGVkfvpCpg8h4Ed8+9Z26/Zwd
         /JB0iUcGpAfE3wwt04VNhLwyYX6pZG4fQZtWQ=
Received: by 10.86.1.1 with SMTP id 1mr3355424fga.61.1221234873875;
        Fri, 12 Sep 2008 08:54:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.211.228])
        by mx.google.com with ESMTPS id 4sm12984229fgg.4.2008.09.12.08.54.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 08:54:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080912145804.GF10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95742>

Petr Baudis wrote:
> On Fri, Sep 12, 2008 at 04:36:11PM +0200, Lars Hjemli wrote:
> >
> > <plug>
> > Current cgit also allows cloning over http using the same url as for
> > browsing the repo, i.e. you may
> > 
> >   $ git clone http://hjemli.net/git/cgit
> > 
> > This has one advantage over just publishing the repo; you don't have
> > to run `git-update-server-info` (thanks to the work done by Shawn O.
> > Pearce on git-http-backend, which is shamelessly reimplemented in
> > cgit).
> > </plug>
> 
>   this finally tripped me over and I wanted to quickly add cgit as an
> alternate viewing interface at repo.or.cz. [...]

Or you can wait a little while for "smart" HTTP server, which I guess
also generates automatically or/and on the fly objects/info/packs and
info/refs required by "dumb" protocols clients (including old HTTP
clients).

P.S. Could you please gather some statistics to compare the period
before and after installing "smart" HTTP server (and after smart
clients became widespread).

-- 
Jakub Narebski
Poland
