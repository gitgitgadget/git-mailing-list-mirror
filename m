From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-1.0
Date: Fri, 7 Sep 2012 14:48:23 -0400
Message-ID: <CAFuPQ1+22erJZ11fm1381-RPs0rKZr=EZJgZWQ1Jp00r6Wc8HA@mail.gmail.com>
References: <20120510134449.GA31836@diku.dk> <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 20:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3bo-0002mW-E7
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 20:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2IGSsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 14:48:45 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:40288 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2IGSso (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 14:48:44 -0400
Received: by qaas11 with SMTP id s11so59316qaa.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=YWMeNO5HHkcG1+JL5B5Xz0DpwoVflYW1Hngj2FFT7/k=;
        b=UJ+0Weq7qdQQqxcVhK/Fmm9ZOQRZwMrJn3a4ibhNsjq2S3ZZ4cIA3kPpNWmvK2HdR6
         O5fm1KdQxDGamN7X73JCYghfGTO8XAx2tMlOeSwhGZQOpuZr9y6IwjTjbtXGR57yA2G6
         mx4Uc12M4ncyNv2Vcm3dmETLF2r/BrZZAtbWkE8Qx+nP/0TIt2vnptYdL6is90952eyE
         kgFv2Wzt2JWCU/B5fkS1iRlC7Rv3PAjAufxZCxbQ1l3Mf7eRXjJ+U8Y2sDxMSqAwBNfs
         BWB4u6iFS4W3sAA3GY4whVYVdKgzlTNeY9iFX1Kz+KCQy6BYUAPEMMYNrGcnlSmN38eF
         /nCw==
Received: by 10.229.134.205 with SMTP id k13mr2071133qct.153.1347043723702;
 Fri, 07 Sep 2012 11:48:43 -0700 (PDT)
Received: by 10.49.82.75 with HTTP; Fri, 7 Sep 2012 11:48:23 -0700 (PDT)
In-Reply-To: <CAK6bCaz7yPR0QmcOwY0iUP0hyisTf-bz=c0G_1nZkjCLDWDR+A@mail.gmail.com>
X-Google-Sender-Auth: Z0HjfpkrE_8BHf5bqG9QQoQph3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204987>

On Fri, Sep 7, 2012 at 9:41 AM, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> Hi Jonas,

Hello Jean-Baptiste

> With tig 1.0 how to feed specific revisions to the main view?
>
> The following hack worked until tig 0.17:
>
> [alias]
>         tignowalk-helper = !git rev-list --pretty=raw --no-walk --stdin<
>
> TIG_MAIN_CMD="git tignowalk-helper $tmp" tig </dev/tty

The possibility to specify commands was removed in favor of improving
options given on the command line. In this spirit, I suggest to
support something like the following:

    tig --no-walk --stdin < tmp-file

Would that cover your use case?

-- 
Jonas Fonseca
