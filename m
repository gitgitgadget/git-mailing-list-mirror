From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Tue, 23 Aug 2011 15:20:26 +0000
Message-ID: <CAMOZ1BsLS9kN5M98s7mqELSsPjFOgFcNbDq6G9rhoyb1txL08w@mail.gmail.com>
References: <loom.20110823T091132-107@post.gmane.org> <4E537AF0.9070604@drmicha.warpmail.net>
 <1314096731.15017.2.camel@n900.home.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 17:21:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvsmj-0006jo-TY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 17:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab1HWPU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 11:20:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60819 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1HWPU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 11:20:56 -0400
Received: by gya6 with SMTP id 6so164787gya.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XqoYqEVJSDVviHiSAlofiNokd8kKsK6Zczpf1eOjro8=;
        b=ntfgMkBiNkHHR+LMRG+PwhAvlxvT056cOvff6N0bPq2n/PS1IIeh+rWyz9xpKI9r7l
         bmB7yosbBOK+deWmgZBNpOuKxqZcpLFCaKzRm009HfFFyYLQPqYT81gQ4gr2LQzU6q7K
         b5mPYt4Czjjasi77VKT6CQeXgLyIr8Ma0MhTQ=
Received: by 10.42.158.7 with SMTP id f7mr98977icx.89.1314112856107; Tue, 23
 Aug 2011 08:20:56 -0700 (PDT)
Received: by 10.42.138.66 with HTTP; Tue, 23 Aug 2011 08:20:26 -0700 (PDT)
In-Reply-To: <1314096731.15017.2.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179940>

On Tue, Aug 23, 2011 at 10:52, Marat Radchenko <marat@slonopotamus.org> wrote:
>> Do we enumerate all differing files and only then
>> limit diff output by path??
>
> Dunno, that's why I am asking why it is so slow.

Why in the world do you think that question was directed at you?
