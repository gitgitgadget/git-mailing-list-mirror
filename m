From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: How to change the index for git status?
Date: Sat, 4 Feb 2012 13:24:29 -0800
Message-ID: <CAJsNXTkM4P7DUGofBT9f3KZQNe38v18eu2WM4UXsSmAsN813VQ@mail.gmail.com>
References: <CABrM6wm2MochqgC0+FByDA-6nmo0XHtZy1FDXJRkc30+2eyiTw@mail.gmail.com>
	<CABrM6wngVDotJoe3Yi5cA_n=JWpLa+M35QEeoKqr1tsp5GD3ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Peng Yu <pengyu.ut@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:24:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtn63-0005QK-Qp
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab2BDVYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 16:24:31 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:33926 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab2BDVYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 16:24:30 -0500
Received: by werb13 with SMTP id b13so3479049wer.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=NjqArjkn7QYJl09nzgAF+/kcH8q5AEmVZsM1e+Gbw88=;
        b=A39EtFkOJS6i0AiHR5jemqVxTom1ksQ0/yFfagivc9rIFjcvIjLmpOwkZkWKmCKyp2
         hL2BVjvVgY+ZEEqVXr/RFW/IIljaBz3tlrDExf6tb/DjROXq9EFSy8HOzQim0fG70tCf
         7wSilvFKgcvkxVZPMZuEfo9MPQLdMGvPNsjis=
Received: by 10.216.133.70 with SMTP id p48mr1184975wei.23.1328390669095; Sat,
 04 Feb 2012 13:24:29 -0800 (PST)
Received: by 10.223.102.133 with HTTP; Sat, 4 Feb 2012 13:24:29 -0800 (PST)
In-Reply-To: <CABrM6wngVDotJoe3Yi5cA_n=JWpLa+M35QEeoKqr1tsp5GD3ng@mail.gmail.com>
X-Google-Sender-Auth: OwVFIakgF6g8z18J4Z3EQm-qTr0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189912>

On Sat, Feb 4, 2012 at 12:08 PM, Peng Yu <pengyu.ut@gmail.com> wrote:
> Hi,
>
> When I run git status, it show the status compared against the branch
> upstream/develop. I want it to compare against origin/develop. I
> checked progit. But I don't see how to change the branch to compare
> to. Could anybody let me know how to do so? Thanks!
>
> ~/dvcs_src/craftyjs1/Crafty/build/api$ git status
> # On branch 2D_doc_dev
> # Your branch is ahead of 'upstream/develop' by 2 commits.
> #
> nothing to commit (working directory clean)

git branch --set-upstream 2D_doc_dev origin/develop

-PJ

Gehm's Corrollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
