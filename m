From: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Subject: Re: Bug in StackedGit
Date: Tue, 15 Apr 2008 11:21:09 +0000
Message-ID: <6efe08af0804150421p2d3dfbd2uf327c933b385bc38@mail.gmail.com>
References: <6efe08af0804150301t9f4a1dbte564902736ebc302@mail.gmail.com>
	 <b0943d9e0804150413h5268532ey2f2ee33fca1be783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:22:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JljEk-0000sV-ET
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817AbYDOLVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbYDOLVV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:21:21 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:45461 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757752AbYDOLVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:21:20 -0400
Received: by yw-out-2324.google.com with SMTP id 5so945380ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+cbd5lID3MfLj3nBylUMLh1xpSx/FnakEqR5fWEU0ww=;
        b=HmR+C2RQAlrmUMheSsQvpPoOqbqdQOPZY8kxgzdJzj2mmHa2+XUaXVK8puiZOoQtpLb0qVWJObM9QGclAprguWmrcWHorR1Vt4NLMc2jKpeCZ3xFXPpf9I0bJhRKUJzp+/f19rMXCYmnC/QC7jJTQPIQX6ORxE5F3BWe8AkfB28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bevxJeDvBguaTJMNS2L0oB6dHEzHJ2BU8XoXXXP3p9veO6LL4+W4VwMJphKlZe639QAr+i7lkM7/jebAURJdBv984j43uoPGtJlflnahCR0AvQooebOF0CVsatP0KFpeXiiY4bSfZE2CRwfJ8Wby7YMkxZwWrmLH+Ka/Xia9Vuo=
Received: by 10.151.42.9 with SMTP id u9mr7581522ybj.108.1208258469926;
        Tue, 15 Apr 2008 04:21:09 -0700 (PDT)
Received: by 10.150.229.1 with HTTP; Tue, 15 Apr 2008 04:21:09 -0700 (PDT)
In-Reply-To: <b0943d9e0804150413h5268532ey2f2ee33fca1be783@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79585>

I want revert some patch to one of previous version like I can do same
in bzr loom.

\\wbr Vitaly Chernookiy

On Tue, Apr 15, 2008 at 11:13 AM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:
> On 15/04/2008, Vitaly V. Ch <vitaly.v.ch@gmail.com> wrote:
>  > after stg commit all patch history is loss. It's sucks.
>
>  Why do you need the patch history after "stg commit"? This command is
>  meant to take the patches out of StGIT control and freeze them in the
>  Git repository history.
>
>  --
>  Catalin
>
