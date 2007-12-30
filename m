From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Why 'git commit --amend' generates different HEAD sha1 each time when no content changes
Date: Sun, 30 Dec 2007 19:20:04 +0800
Message-ID: <46dff0320712300320n3d12edf9oedc36777a226528b@mail.gmail.com>
References: <46dff0320712300256g36e825a2g711d98b565e361f9@mail.gmail.com>
	 <1199012360.15996.6.camel@futex>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthias Kestenholz" <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Sun Dec 30 12:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8wDl-0003DR-Lc
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 12:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbXL3LUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 06:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbXL3LUI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 06:20:08 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:50334 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXL3LUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 06:20:05 -0500
Received: by py-out-1112.google.com with SMTP id u52so8547181pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KHtjLg4Y3+tKxyQL6rPRDAvP+Nwxcb/3DRs+u2LUAiU=;
        b=i+RpCZd0lR4BwW19iaj1rrz/7VZttyrYA2SLe+fRS/Cgj3QSIRDKgP8WlImN8/O17DOJF4bXbo2KlAJMY/VyuF2SZeNsG+MBtrcUzqga8aYoqShwlxOhvZ7/+ws+HKDPCkkOj28Q/KGYVxsF0ceak+Nd6SV6Hft6DW2SWvlBqv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qXIdQQw5tKcx4q/0W/2qXkoTq6OgCOPL7OZ0Qum+59iE5/rZ7BNTsf1sEb8mCdmUAdhUJA1zCU/iW2RRfLpAwFqTVV4q39kaF45VcmhIzrhbRb3tn2lsT08QkdWmn8W5b5HI6gqylDOCPwbrd9lTEJFjRsZyjKjZdcqQqXxD9nI=
Received: by 10.35.60.15 with SMTP id n15mr13583871pyk.33.1199013604959;
        Sun, 30 Dec 2007 03:20:04 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 03:20:04 -0800 (PST)
In-Reply-To: <1199012360.15996.6.camel@futex>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69352>

On Dec 30, 2007 6:59 PM, Matthias Kestenholz <mk@spinlock.ch> wrote:
>
> On Sun, 2007-12-30 at 18:56 +0800, Ping Yin wrote:
> > AFAIK, commit sha1 is only determined by commit object content (say
> > parent commit, tree sha1 and so on). So why 'git commit --amend'
> > changes the commit sha1 when no content changes as following shows.
> >
> The full commit includes a timestamp too, which changed. Try setting the
> GIT_AUTHOR_DATE and GIT_COMMITTER_DATE environment variables, you should
> get the same SHA-1 everytime.
>

Thanks. With 'git show --pretty=fuller', I find that commit date
changes each time and that author date keeps the same.



-- 
Ping Yin
