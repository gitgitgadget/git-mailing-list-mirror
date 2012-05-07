From: Kelly Dean <kellydeanch@yahoo.com>
Subject: Re: Does content provenance matter?
Date: Mon, 7 May 2012 14:43:23 -0700 (PDT)
Message-ID: <1336427003.53220.YahooMailClassic@web121504.mail.ne1.yahoo.com>
References: <878vh4flh1.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 23:43:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRViM-0003uo-2R
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab2EGVn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:43:26 -0400
Received: from nm28-vm3.bullet.mail.ne1.yahoo.com ([98.138.91.158]:35507 "HELO
	nm28-vm3.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751062Ab2EGVnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 17:43:25 -0400
Received: from [98.138.90.54] by nm28.bullet.mail.ne1.yahoo.com with NNFMP; 07 May 2012 21:43:24 -0000
Received: from [98.138.89.254] by tm7.bullet.mail.ne1.yahoo.com with NNFMP; 07 May 2012 21:43:24 -0000
Received: from [127.0.0.1] by omp1046.mail.ne1.yahoo.com with NNFMP; 07 May 2012 21:43:24 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 240485.35697.bm@omp1046.mail.ne1.yahoo.com
Received: (qmail 55031 invoked by uid 60001); 7 May 2012 21:43:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1336427004; bh=37TX4mv2Inxmrx6o2YpAZvKRJf6L3BUA8hg7yPtS8Fg=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=NEt+L+IuipKIIw+fbRYkeSb0dZOE8UGA8OvTFKpfcqP5nLLwIjlAOaRHsvX5VHTB2pyU/uzG6i1vrhANdbXTPmjP1FGfv/SM7+/XfCe+CXANGVWJBFDohx1js3ktHy+p5yTCPy7Xin/qOig+IzFfbFj/rZTNCy1aX1jPm47Lukw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=T7gXvrV7KSliqqs8oScLbtnoW3yVxEP9XY8jDmiw5xT4gttewx+ifx1Tn9QdBqLaDBv8svVHTfo4TblOcM9TN3JbvVUNXMauXh/dohZli82mpwcqXoMmgm90i0UzAvZJAb83tUyMxdkxxTcuA1yt45cv0CTsEdDVEIvom5Vr+x8=;
X-YMail-OSG: oLPR8MIVM1nq_0M7AK.Bor3PGgJUpBaCGEuSLYm1jdWjjja
 9ALg9KJZF
Received: from [146.185.23.179] by web121504.mail.ne1.yahoo.com via HTTP; Mon, 07 May 2012 14:43:23 PDT
X-Mailer: YahooMailClassic/15.0.6 YahooMailWebService/0.8.117.340979
In-Reply-To: <878vh4flh1.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197317>

--- On Mon, 5/7/12, Thomas Rast <trast@student.ethz.ch> wrote:
> What's the difference between the following series of
> commits?
>
>   Foo
>   Bar
>   Revert Bar
>
> and
>
>   Foo
>
> You claim that they're the same, because the tree state
> after each is
> the same.  But I learned that Bar was broken, and
> recorded it for all to see.
No, I don't claim they're the same. Different commits have different timestamps (and different commit messages, but that's not useful for automatic searching to find which commits are derived from which others). Consider if "Revert Bar" and "Bar" didn't point to their parents; could you still deduce from them that Bar was broken? Yes--on the basis of the commit timestamps (which shows their temporal order) and the contents of the trees which the commits point to (which shows that Revert Bar undoes a change made in Bar).
