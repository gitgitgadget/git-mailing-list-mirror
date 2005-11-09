From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make tests ignorable with "make -i"
Date: Wed, 9 Nov 2005 09:15:56 +0100
Message-ID: <81b0412b0511090015w4ee0b26fg3e8fc7d192c53283@mail.gmail.com>
References: <81b0412b0511080151v69bc4578we093eaa751ee4bac@mail.gmail.com>
	 <7vmzkfey4o.fsf@assigned-by-dhcp.cox.net>
	 <20051108211618.GA3224@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 09:16:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZl7g-0000VN-PL
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 09:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbVKIIP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 03:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965302AbVKIIP5
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 03:15:57 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:65266 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965297AbVKIIP5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 03:15:57 -0500
Received: by nproxy.gmail.com with SMTP id c29so19043nfb
        for <git@vger.kernel.org>; Wed, 09 Nov 2005 00:15:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GpIUbp3xlxHhDv2gh2SiTRvPWT5Ud3HHYQyiukPMaTBKlnK1Tp8tgggrPveX7SfnvyGPvVloDuR6GJgCCoxRN2Ge4sJqZpWrVICHIvjDvWJgcEBH6/Dnww5F+z3SwruhfIAh/l6Ta1kkGnMRphJU+uHYa+d2OIpigRVeOEHXZO8=
Received: by 10.48.157.3 with SMTP id f3mr81545nfe;
        Wed, 09 Nov 2005 00:15:56 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Wed, 9 Nov 2005 00:15:56 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20051108211618.GA3224@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11389>

On 11/8/05, Alex Riesen <raa.lkml@gmail.com> wrote:
> Junio C Hamano, Tue, Nov 08, 2005 20:29:59 +0100:
> > > ...  (Or to ignore plainly uninteresting situations because of the
> > > testing being done on say...  cygwin ;)
> >
> > Could you tell us which ones break on Cygwin?
> >

So far:

t4000-diff-format.sh
* FAIL 3: validate git-diff-files -p output.
        compare_diff_patch current expected

t4006-diff-mode.sh
* FAIL 3: verify
        diff -u expected check

t4102-apply-rename.sh
* FAIL 3: validate
        test -f bar && ls -l bar | grep "^-..x......"
