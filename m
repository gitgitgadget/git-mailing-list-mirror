From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RESEND] Pagination for gitweb
Date: Fri, 10 Sep 2010 23:53:14 +0200
Message-ID: <201009102353.17279.jnareb@gmail.com>
References: <1284135442-10971-1-git-send-email-lkundrak@v3.sk> <m34odxmnpj.fsf@localhost.localdomain> <4C8A816E.4090305@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Sep 10 23:53:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuBXO-0007Lc-Pl
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 23:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab0IJVxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 17:53:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36447 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab0IJVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 17:53:32 -0400
Received: by fxm16 with SMTP id 16so2094571fxm.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VJpCSHYMSxBB7teobmSH7tF7ZLQdtHwiM864a8Cgiio=;
        b=f7jNAtwzWrmC+LkJaK3IjgZxxn3CDqdpRbuHtdWfRweWnfMnEsUTb2U4IBjOcCmFMY
         PuAb+saVlGla0nAT0vxu6a54Yz0IdbpwOAW8HAhveSJ1fci/hrGIFK1Az6NSbPQCc6aI
         o1imtmgWBfZE/nJ43Pe3Jtr12NJZRbNTUMm8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ojuJJozae6sDYDgV9rxHOEjEB/9BsYYSHpVak7cFUD5xJ+g+v46nPm7dIThBErQYGx
         TlU1W7XDNGdW+kwfHKbzH5Janf+vwppUoFevJMMys2T5L+2dR+Ev74enaOcuQHh3GZRn
         x0EMAgZyhfCgSqvtXyEWRUni9Mxs/YnS99U4c=
Received: by 10.223.122.196 with SMTP id m4mr950343far.20.1284155610754;
        Fri, 10 Sep 2010 14:53:30 -0700 (PDT)
Received: from [192.168.1.13] (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id 19sm1592377fas.1.2010.09.10.14.53.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 14:53:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C8A816E.4090305@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155971>

On Fri, 10 Sep 2010, J.H. wrote:
> On 09/10/2010 11:57 AM, Jakub Narebski wrote:
> > Lubomir Rintel <lkundrak@v3.sk> writes:
> > 
> > > I thought something like this could be a starter for better handling long
> > > gitweb project lists (such as http://pkgs.fedoraproject.org/gitweb/).
> > >
> > > Could anyone please take a look?
> > 
> > What do you mean here by "better handling"?  
> > 
> > Is the problem server performance for large number of projects?  If
> > this is the problem, perhaps better solution would be to use caching
> > (work in progress).
> 
> They already moved to using my caching layer, mainly because I could
> create an RPM for them and the fact that my caching code is slightly
> more battle tested.

Note that with project list pagination, and especially with project
search  feature, a better solution might be to cache *data* rather
than HTML output, like in fork used (or used to be used) by
http://repo.or.cz, or in Lea Wiemann's GSoC 2008 project [1]

[1] http://repo.or.cz/w/git/gitweb-caching.git
-- 
Jakub Narebski
Poland
