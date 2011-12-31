From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Sat, 31 Dec 2011 15:31:31 -0500
Message-ID: <CABURp0oVWwNcYjzPoMvXrDKtDnpeLGXQhdxGnsARmBt9ZbUcHg@mail.gmail.com>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, iveqy@iveqy.com
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 31 21:32:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rh5aw-0006Lq-NC
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 21:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab1LaUby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Dec 2011 15:31:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33477 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab1LaUbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2011 15:31:53 -0500
Received: by wgbdr13 with SMTP id dr13so25422536wgb.1
        for <git@vger.kernel.org>; Sat, 31 Dec 2011 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9tQf1Ceu+KHMtvtwkzHKrGOF0MyRkArJS0IGRu3BgMg=;
        b=DS8n8hg+mHLLlhTr2ioygPLMeBnHMWaQethspuc0hhA+94pst2VGOlJaKU4ZlW5O9I
         USlfLAg61q/f16pZGClV/wRqaQjlAH/Zx4HbMf3Q9INeJlSpnShHhPtk6COVjRY4BJMH
         1Y8g72oh2xyuRrT0uyzebTwZTWclsCwMG3DNU=
Received: by 10.227.5.208 with SMTP id 16mr15373073wbw.17.1325363512267; Sat,
 31 Dec 2011 12:31:52 -0800 (PST)
Received: by 10.216.19.82 with HTTP; Sat, 31 Dec 2011 12:31:31 -0800 (PST)
In-Reply-To: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187815>

On Thu, Dec 29, 2011 at 4:00 PM, Antony Male <antony.male@gmail.com> wrote:
> This fixes a problem where moving a git repository with checked-out
> submodules would cause a fatal error when commands such as 'git
> submodule update' were run.

Thanks.  I noticed this itch when looking at git-files a few months
ago.  It bothered me, but not enough to fix it;  just enough to note
it as a problem area to avoid in the future.

> An alternative patch would teach git-clone an option to control whether
> an absolute or relative path is used when --separate-git-dir is passed.

I think I like this option better. Did you look at what it would take?

Phil
