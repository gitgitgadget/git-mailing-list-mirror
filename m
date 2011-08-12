From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [BUG] Git won't commit
Date: Fri, 12 Aug 2011 17:30:21 +0000
Message-ID: <CAMOZ1BtxNSnncEJ6frEY0STgfS478krkpxXStP401WLPovb2Gw@mail.gmail.com>
References: <1313169225059-6681082.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Fabricio Nascimento <fabriciosn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 19:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrvZQ-0000Mc-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 19:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab1HLRaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 13:30:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50456 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab1HLRav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 13:30:51 -0400
Received: by ywf7 with SMTP id 7so2089252ywf.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AjAnIVVV+ZSODYAkdtQoM6YDxL9aUqNBhZu+EHkHnfE=;
        b=fV4dmR8dThhA4KbUUVdW+0erly3B+/b6yzw9RKE8k+qgRw+3hsSVXaYJmj/cbQ2rgc
         r9bWdPFY2Rq9osDwI2wi73s0ArBlq3oyxIytInuVCtrVWP3wz5IYgjmUpCdx2UaZT0Fb
         mAQZUhP4ry5pgw95MxOBJdAmHiToMZWpMJqE0=
Received: by 10.42.156.3 with SMTP id x3mr1112612icw.212.1313170251172; Fri,
 12 Aug 2011 10:30:51 -0700 (PDT)
Received: by 10.42.171.6 with HTTP; Fri, 12 Aug 2011 10:30:21 -0700 (PDT)
In-Reply-To: <1313169225059-6681082.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179239>

On Fri, Aug 12, 2011 at 17:13, Fabricio Nascimento <fabriciosn@gmail.com> wrote:
> Hello Everybody,
>
> Hope this is the right place to send this bug report.
>
> It just appeared today, last time I've made a successful commit was 3 days
> ago. Now every commit, in no matter which repository I have (I've tried old
> ones, cloned today, github ones etc) fails with the following message.
>
> [master 09-mapas] git commit
> fatal: could not read 'template': No such file or directory
>
> It happens both with the stock git binary that came with Xcode 4.1 on OSX
> Lion (1.7.4.4) [/usr/local/bin/git], and the homebrew version (1.7.6)
> [/usr/bin/git].
>
> I haven't changed much of my system during those days besides installing
> macports and tinycdb (with ports). Don't see any close relation, both
> tinycdb and macports were removed.
>
> Curiously, it works well with the git binary that comes with Github.app for
> mac, whose version is 1.7.4.

What does the following output for you?

  git config --get commit.template
