From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: Feature request: Limit git-status reports to a directory
Date: Thu, 25 Oct 2007 10:14:17 +0800
Message-ID: <46dff0320710241914t7d93aae1t991fbcaacde77046@mail.gmail.com>
References: <ffofbm$lmc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michel Marti" <mma@objectxp.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 04:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IksEy-0003Hx-Th
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 04:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbXJYCOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 22:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbXJYCOT
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 22:14:19 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:62900 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbXJYCOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 22:14:18 -0400
Received: by py-out-1112.google.com with SMTP id u77so476700pyb
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 19:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O0XkfIU/l4RlpH9mkvfogqZw0Cx7J7MpZKTS3Qvc3Nw=;
        b=n5Bl0Zo0bNB44TtSBQ4hqOUBGN/snDRP4Msczz9MvEfGaUN+xhgeJa9LCejGYplDmgkbF+8OXH19cX1+vLWx93aUf+WKungQMe2QGyDIZ8gckpsfSuCpae0hFUyR5m/7zVNXCs0fMfBasrw0BGnAtsUhr+t6aCRDqUiJjQRj/ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bx4QA1YcuZZhdUftePSJSdJ72mXm7s9lNZg8Rsf03TdSXHj8clhdCqD+bk3vtaj1DK4Kpc6hI6gVvn4g99+sd7Qm9is4ZSn8xa35FRwuqeOXXVY0gPOfH/V+OSNm2RGSlieSWkUhu6dmBakQh6uAsLd00yO25mdaxnP7BTw4Epg=
Received: by 10.35.42.18 with SMTP id u18mr1426423pyj.1193278457405;
        Wed, 24 Oct 2007 19:14:17 -0700 (PDT)
Received: by 10.35.52.7 with HTTP; Wed, 24 Oct 2007 19:14:17 -0700 (PDT)
In-Reply-To: <ffofbm$lmc$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62258>

On 10/25/07, Michel Marti <mma@objectxp.com> wrote:
> I am sometimes interested in only seeing the status for a specific
> directory (and its sub-directories), but git-status is no help in this
> case - passing a directory does some sort of "git-commit --dry-run". I
> first thought that this is a bug until I saw in the man-page that this
> is actually a feature...
It's also painful for me. IMHO, the behaviour of "git-status" should
keep consistent with "git-diff" and "git-log" which allow for the
path.

Another point, It will be helpful to add a config item to change the
default behaviour for 'git-diff" and "git-log". For example,
'diff.defaultcurrentpath=true' to let git only show difference in
current directory instead of difference in top directory when typing
'git-diff'
>
> - Michel
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
franky
