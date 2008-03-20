From: "Elijah Newren" <newren@gmail.com>
Subject: Re: How to undo git-rm?
Date: Wed, 19 Mar 2008 20:54:40 -0600
Message-ID: <51419b2c0803191954q1811c351jc65ff1ac541f07a2@mail.gmail.com>
References: <20080318230441.GA664@arctrix.com>
	 <51419b2c0803191953y7842ddf8l7a6de37226cb12e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neil Schemenauer" <nas@arctrix.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 03:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcAw5-0000F0-90
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 03:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYCTCyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 22:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbYCTCyl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 22:54:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:35060 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbYCTCyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 22:54:40 -0400
Received: by wa-out-1112.google.com with SMTP id v27so778731wah.23
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 19:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PCTq2u3SuLPETwbfTVKbUyxZOjyuQSqkrFyGn92HlF8=;
        b=HK0eYo7h/YBz2Ex1tg28r9ArBpCXpw2U7dnvyipvDC14n/gvFqlOoZp2l+fcdaZEbSer+N5f1WjWwdVQ9XnKN7cS1LYMVQOHSNkIv6E3XLCdT9ZnkvR+RV9GcMFpQ5m4OjR5LkGUxjJWqoI3h47J0I59qq/qcXjnH1B1FKdCDZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rDy05t0Z3+O7s8QxF15p0383AahjbZdLhiRdoNscVu3F2M9QZeT2udyPRCDbVexHigOXhuw2+GvDtNkzmC9etzL810xpneMgD9V9J9lvlbSxyY+Mu+4dOVa8pf4EWoLn+tyc4V+fmD+MDr23mocBD8N1mgQRyrWok17i6JpqvAo=
Received: by 10.114.202.15 with SMTP id z15mr2634443waf.72.1205981680196;
        Wed, 19 Mar 2008 19:54:40 -0700 (PDT)
Received: by 10.114.205.19 with HTTP; Wed, 19 Mar 2008 19:54:40 -0700 (PDT)
In-Reply-To: <51419b2c0803191953y7842ddf8l7a6de37226cb12e2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77617>

On Wed, Mar 19, 2008 at 8:53 PM, Elijah Newren <newren@gmail.com> wrote:
> On Tue, Mar 18, 2008 at 5:04 PM, Neil Schemenauer <nas@arctrix.com> wrote:
>  > Hi,
>  >
>  >  This seemingly simple operation has me stumped.  I removed something
>  >  from my try using "git rm" and now I want it back.  With SVN I would
>  >  use "svn cat <path> > <path>".  After some searching around, I
>  >  though git-cat-file would do the trick.  Alas, it appears as though
>  >  it looks up the SHA for the path in the index and so it too fails.
>
>  Try
>   git checkout HEAD eg

doh, that should be
  git checkout HEAD <path>
of course.

>  or
>   git show HEAD:<path> > <path>
