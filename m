From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport in cron
Date: Tue, 27 May 2008 23:31:23 +1200
Message-ID: <46a038f90805270431u3812d73u9505179c641c7075@mail.gmail.com>
References: <17476529.post@talk.nabble.com>
	 <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com>
	 <ce7555260805270345x353cfc76ja3f7ec83a0ab5c61@mail.gmail.com>
	 <g1gq3u$jb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue May 27 13:32:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0xPb-0007XC-QH
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 13:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbYE0LbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 07:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbYE0LbY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 07:31:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:19542 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbYE0LbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 07:31:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2089213wfd.4
        for <git@vger.kernel.org>; Tue, 27 May 2008 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=048ZZG0Cye/Gp/wAj2yycWTzvbWRpPm/IrNAbfiUpAQ=;
        b=hy3z2tMnyk08SNC7vlxCzzzubS1eraGfhzkFmerhLTgD/70mzxaF06nBt0yqEiB4AyPrAQpUGBJgjWiahWR77qzPjy9okrtUzP/xgV6tu2aZAhEB5yRP1Lf/VE1+h3bGSZ4Nl4jBx+1lbK16ZUj0UJQxbW8F89ypyjE3cvEHkDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m+ZO6xWgBMyIRfTqHJzTFW67VQ5zndS41eLWMKl4Q2LT8se1n3fghKwd1yYqEDBJIFRPstMjQ/POaIVLAr8OaR/J9eXgL6jiKKYzUxh+T/rmYWvCVox0NDB6tQ+syImv6Fa7ucnKU+zjxGe+oOdJrcEFiBRVv7kbkxo2u9n4n5U=
Received: by 10.142.193.13 with SMTP id q13mr161945wff.28.1211887883195;
        Tue, 27 May 2008 04:31:23 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Tue, 27 May 2008 04:31:23 -0700 (PDT)
In-Reply-To: <g1gq3u$jb$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83006>

On Tue, May 27, 2008 at 11:08 PM, Michael J Gruber
<michaeljgruber+gmane@fastmail.fm> wrote:
> The environment! Put "env" in your cron job and compare the output to "env"
> on the command line. cvs or cvsps may be in $PATH on the command line but
> not in cron, or $PERL5LIB might be different.

and perhaps $CVSROOT...


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
