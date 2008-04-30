From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git-rebase and reflog
Date: Thu, 1 May 2008 01:13:24 +0800
Message-ID: <46dff0320804301013o17da30cg1fd847beca94ff58@mail.gmail.com>
References: <46dff0320804300904i3402b5e7wf827f6759bc52901@mail.gmail.com>
	 <m3d4o7nvt2.fsf@localhost.localdomain>
	 <46dff0320804300956x7e4f34efle39f6cad2e98a2de@mail.gmail.com>
	 <4818A6CA.5000409@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:14:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrFsj-0008Rw-OT
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbYD3RN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754486AbYD3RN0
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:13:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:52520 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbYD3RNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:13:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so584407wxd.4
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u0dcZmExIP67UKnylKPGCgEWmcZTdUdQ453aLy01xh8=;
        b=yFe9saTd/D9d3nFboeE1lKzFs1YghNJFNNhulSSBJb6p6GWxjjVAY3Yqll34bZg9htLznw6VUA5JO2Zy8bExXtb0oZqOkYsSSVd9OA6Bo95JbZv2mIkgCcA5ttscJck4VZQB3BsemzqU2G2JLc2edW2bQEba7RpqtJ6qGrtujeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=urWrWElGC6mO3tdyMHtIBi4vpIKEVeJfDHpaxiY1wbBrU+5cM8F5UDATwV7rAx9eLrA1axkNkxW2hZQFYC2sTc3wolwvqYCYr91t0cr3mGxx+wPsfdXV+CbIQ6/N1XmOx5oYYh6gpMCkxKWJYCntbkL/fVGiw0EExN+72KZgf+w=
Received: by 10.100.214.19 with SMTP id m19mr1661422ang.50.1209575604207;
        Wed, 30 Apr 2008 10:13:24 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 10:13:24 -0700 (PDT)
In-Reply-To: <4818A6CA.5000409@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80850>

On Thu, May 1, 2008 at 1:05 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Ping Yin wrote:
>
>  > If your are right, how can i look over the branch reflog. I know the
>  > master@{1} syntax, but i want to see master@{1}, master@{2} until
>  > master@{n} in a single command just as how 'git reflog' shows HEAD@{1}
>  >  to HEAD@{n}.
>
>  Have you checked the documentation for 'git reflog'?
>
>  It says:
>
>    The subcommand "show" (which is also the default, in the absence of any
>    subcommands) will take all the normal log options, and show the log of
>    the reference provided in the command-line (or `HEAD`, by default).
>
>  So, 'git reflog show master' should get you what you want.

Oh, i missed that. Maybe we should add an example section.

>
>  You may also want to check out the '-g' option to git-log. For example,
>  'git log -g master'.

Oh, wonderful.

However, i still think the intemediate commits of git-rebase needn't
go into HEAD's reflog because it's totally useless.



-- 
Ping Yin
