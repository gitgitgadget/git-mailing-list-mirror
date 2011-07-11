From: Carlo Trimarchi <mr.spoon21@gmail.com>
Subject: Re: repository in different directories
Date: Mon, 11 Jul 2011 16:07:10 +0200
Message-ID: <CABU6SG4=UiuM7Q1RkXxR1oJKP72Sk69Awq09+64VOra3ds5hmA@mail.gmail.com>
References: <CABU6SG5uLXAsu0yXa1cmPAmte3WnsjaHN0r_D4c8C7W2tKJDHw@mail.gmail.com>
 <CACwv2A=d44+txUGGDxJRFHVps-eT5g_mWyA-WaKTXyyUFgix7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Allen Fogleson <afogleson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgH96-0005Os-6A
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab1GKOHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:07:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41631 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455Ab1GKOHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:07:30 -0400
Received: by ywe9 with SMTP id 9so1482462ywe.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZiyP2TFwygDOh9hS9EgJCCCgEIzCnnqT2Tqu24NgYbw=;
        b=NJQogwoY9A0h8I1oYn9vEhoz3XnbHQplluQdhu/y0lZZGgAf9UkHW9p/0Fq9EwTQZy
         man9lh2RaPhDZB5TckW7nHuSGUAW8CZJ7d3zz3++32rkfdqPkTWmbx7rQy7OFy8PsMAf
         O3shGhtj9g+66RSwrnJcQ+0RYhsYA38W6CQ+s=
Received: by 10.236.154.42 with SMTP id g30mr5331910yhk.72.1310393250065; Mon,
 11 Jul 2011 07:07:30 -0700 (PDT)
Received: by 10.236.110.135 with HTTP; Mon, 11 Jul 2011 07:07:10 -0700 (PDT)
In-Reply-To: <CACwv2A=d44+txUGGDxJRFHVps-eT5g_mWyA-WaKTXyyUFgix7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176841>

On 11 July 2011 16:01, Allen Fogleson <afogleson@gmail.com> wrote:
> Why not just make /home/carlo the repository, it has all the right folder
> structure, then from the server you can pull, or you can git archive when
> ready to release and unarchive on the server

because I'm working on different applications and I need a repository
for each one of them

Steve Muadib
>Ah, and for wrong: how about using one repository and setting up
>a commit hook to move files to final places?

the commit hook should stay in the local or the remote machine?
