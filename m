From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 11 Apr 2012 10:56:00 -0500
Message-ID: <20120411155537.GA4248@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <1421035.yALBSXSHGd@flomedio>
 <20120410171707.GA3869@burratino>
 <m3y5q29si7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 17:56:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzu7-0001iJ-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201Ab2DKP4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:56:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37964 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab2DKP4O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:56:14 -0400
Received: by ghrr11 with SMTP id r11so525438ghr.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qd8BvFgNOjO37XOKSsOInsOxkF1nRooOb5klKDiGv28=;
        b=rKvz96aKzs+1jZ3P+T6TDoEDhURF+IWWCODSU2BHeoruwdXkgPDibF5Ul5dLXqzDiW
         srZHomCrM4Zzy/oxc8I2BEpEEiFhxC+TExdd8929PjzOyM4CZN9TSIabxj7XCXY9zohA
         4yRkp0ZdjKlEKAs3kPjikeQ2K9rfpKKZp1Gn/l5holZHEw5AY6S0jhlWHKDbs/laq2p6
         bo9FdpG7HYzJjMC0j1lQCxYiUDWnN+N4r/OzD27Pgx8in6F4jQSizJbVvfJRvoiJ00so
         sSYM5SPSQacO7KQkgT9coYxz4MaCcN0IT8nNeLiTeXgzCc81Vs7+WInHR0Guu5ik+2OC
         AU3A==
Received: by 10.60.0.226 with SMTP id 2mr22808629oeh.18.1334159773864;
        Wed, 11 Apr 2012 08:56:13 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id o9sm3186308obd.21.2012.04.11.08.56.10
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 08:56:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3y5q29si7.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195195>

Jakub Narebski wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  2. Teach the remote helper to import a single project from a
>>     repository that houses multiple projects (i.e., path limiting).
>>
>>  3. Teach the remote helper to split an imported project that uses
>>     the standard layout into branches (an application of the code
>>     from (2)).  This complicates the scheme for mapping between
>>     Subversion revision numbers and git commit ids.
>
> Can't we use the either peg rev notation of externals, or the notation
> that Subversion itself uses for svn:mergeinfo?

Maybe. ;-)  Could you give an example?  Where would the text in this
notation be stored in the git repository?  How are lookups performed?
