From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: problem with git-cvsserver
Date: Fri, 1 Sep 2006 12:07:19 +1200
Message-ID: <46a038f90608311707t4ab5fc2fj45e852df4b91870f@mail.gmail.com>
References: <44F5B2A7.8070501@gmail.com>
	 <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com>
	 <20060831090333.GA28445@fiberbit.xs4all.nl>
	 <46a038f90608311600p747c8a3anbe90dbac928e9923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	aonghus <thecolourblue@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 01 02:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIwZB-0005E4-Ab
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 02:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWIAAHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 20:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWIAAHW
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 20:07:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:38561 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964823AbWIAAHV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 20:07:21 -0400
Received: by nf-out-0910.google.com with SMTP id x30so554446nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 17:07:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sNMokca0PlSFZ5+97PGol1aYB02UyfxlK/Z5A+Gr/ReF5fQBl7aHXsLByqBAbmr4VtK3+4pGLta80VDRm9uqO5l5yWnETsY1ir96aBvLnIW1cWgK2ey59wITNdEf9WprcJpUB1ElGnRq+nzJAsR15aHe3qsQVLYGGS1nT1xFyWE=
Received: by 10.49.8.4 with SMTP id l4mr2288413nfi;
        Thu, 31 Aug 2006 17:07:20 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Thu, 31 Aug 2006 17:07:19 -0700 (PDT)
To: "Marco Roeland" <marco.roeland@xs4all.nl>
In-Reply-To: <46a038f90608311600p747c8a3anbe90dbac928e9923@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26293>

On 9/1/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> I have to say though: Ouch. Do you know if there's an upgrade path for
> apps? Does v3 detect you've got a v2 file and do something smart
> (upgrade in place / spit out a readable error)?

Oh, grumble. See the comment at the bottom of
http://www.sqlite.org/formatchng.html

We may need to add something in the doco pointing to this "technique",
and perhaps the URL as later versions may do something different.

I do wonder what the debian packaging does, perhaps the v3 package
forces an upgrade to the v2 package that renames the cli binary? I
guess the drawback of having the DBs anywhere in the FS is that the
packaging can't upgrade them for you as it does with Pg for instance
:(



m
