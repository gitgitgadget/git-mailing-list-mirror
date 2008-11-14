From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [MonoDevelop] git integration with monodevelop
Date: Fri, 14 Nov 2008 18:55:47 +0100
Message-ID: <200811141855.48131.jnareb@gmail.com>
References: <491AAE6D.8030304@op5.se> <alpine.DEB.1.00.0811141419520.30769@pacific.mpi-cbg.de> <1226683698.4483.265.camel@erandi.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	monodevelop-list@lists.ximian.com,
	Michael Hutchinson <m.j.hutchinson@gmail.com>
To: Miguel de Icaza <miguel@ximian.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 18:57:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L12ur-0003Xy-70
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 18:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbYKNRzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 12:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbYKNRzy
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 12:55:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:32006 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbYKNRzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 12:55:53 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1714403ugf.37
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 09:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dhOb2FPgum4jQqAMab50pGpnynzTkXjHFczKray5lz4=;
        b=e049HdsuCmulZyB8j8FeKjifWTWNuGdcgsuFpixZwPdNq0JCnDFjfQSddensxYrtB8
         M/r+opMLGZv9yS6dx0t3oqRI5iWfeRE/CEt2ka+uZPjYrS+nBAbctW3yxVmlSwOlGy2A
         OwiZGsIX/hgviaVXKUZdnILjPcUu4eDWNptxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=U6fhVAiRj0mxnBLiGzwqAhLmCEfz6exRGqJOiQwlxMLpDR+zoGg029QBgV6iG1UKrn
         lRv38EWV69mDIp8AKRBDimRylpwffyrGvKjPaB8WIu0J1mW4ptwCt0r1g6zKsfxzIYGt
         3bkxnJ47QBmsFo0O7N0yYnx7HD+fT4HhA4lsQ=
Received: by 10.67.116.9 with SMTP id t9mr5018099ugm.61.1226685351666;
        Fri, 14 Nov 2008 09:55:51 -0800 (PST)
Received: from ?192.168.1.11? (abwt29.neoplus.adsl.tpnet.pl [83.8.243.29])
        by mx.google.com with ESMTPS id i39sm1354293ugd.35.2008.11.14.09.55.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Nov 2008 09:55:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226683698.4483.265.camel@erandi.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100995>

On Fri, 14 Nov 2008, Miguel de Icaza wrote:

Please, try to not lose the attribution

> Johannes Schindelin wrote:
 
> > May I suggest respectfully, that the next time communication channels 
> > between the Mono-mentor and at least one knowledgable Git guy are 
> > established early in the project?  IIRC there was a GSoC project to 
> > reimplement Git in C# last year, too, which failed, too.
> 
> The first year effort failed because the student never started, he got a
> job before the official SoC start.
> 
> This year one of the students vanished before the SoC started, the other
> one did some minimal work, probably because the work was above his
> comfort zone.

I think that it might also be that 'Git# implementation' is just too
big a project for single Google Summer of Code, even for two students.
JGit/EGit is developed for much longer than a single summer, with
larger number of developers than one or two students, and it is not
yet complete Git implementation.  The JGit GSoC 2008 project was simply
"Eclipse plugin push support", and that size of project worked
wonderfully (see http://git.or.cz/gitwiki/SoC2008Projects page).

So for the future I think it would be better to a) define smaller sized
projects with definite (and reachable) goals; b) maintain better contact
with Git Development Community (git mailing list, #git IRC channel).

-- 
Jakub Narebski
Poland
