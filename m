From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git sparse checkout repo size
Date: Mon, 18 Jul 2011 19:25:58 +0700
Message-ID: <CACsJy8AEcQ-Wh2KrNDQ03fnabT3OFGgVCmWkOZ6BH7=ujgsRVg@mail.gmail.com>
References: <CALf5Ac223mASO+KGYa3nqB+3eajvRS4QueGT5on6G5kYqhODQQ@mail.gmail.com>
 <CALf5Ac2A4XTfkZraVra2sSGJZJ31bTyfmgHZWjptJNgQtXyH7Q@mail.gmail.com>
 <CACsJy8C=LdcaQbc46ssc5=tTXyA-U4N4FAsqjnPyEqwYZuO4LA@mail.gmail.com> <CALf5Ac3DcoB+Psgwys6NNOmTcyGmKj5dKhR7K8ardF6MsCCDwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: gaoyong pan <pan.gaoyong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 14:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QimuC-0005n5-Iv
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 14:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab1GRM0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 08:26:31 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59454 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1GRM0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 08:26:31 -0400
Received: by fxd18 with SMTP id 18so6620560fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 05:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TCEsXU4YRbTVPRXxTPto9/znntuDGJ8+PCxrvbU5l4o=;
        b=kI5sadeqwCXFHunB8bbjVIuFWmElhA+gOoQ0++v6zg72m/2k2JB5sDGr4E3KGl44Pf
         3Ttj0EWA4Ns1Eici7x+QXbZbbDAlxkBHOlr+ShNbCu1CNM2imSk643KEdfwrsokh8ipB
         BbGM9RNeJkLegDXBqQg0EDrNBzJ+rKF/ghWkY=
Received: by 10.204.32.129 with SMTP id c1mr1775634bkd.291.1310991988159; Mon,
 18 Jul 2011 05:26:28 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Mon, 18 Jul 2011 05:25:58 -0700 (PDT)
In-Reply-To: <CALf5Ac3DcoB+Psgwys6NNOmTcyGmKj5dKhR7K8ardF6MsCCDwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177372>

On Mon, Jul 18, 2011 at 6:54 PM, gaoyong pan <pan.gaoyong@gmail.com> wrote:
> I need to push back so sparse clone is the best solution, it must be
> very difficult to implement so it won't be released in this year?

Because nobody is working on it currently (I mean sparse/narrow clone.
There are alternatives, you can search the archive). I had a WIP some
time ago but there are still problems to be resolved before moving it
forward. But I'm currently busy with pathspec work. Even if I have
time for it, such a big feature may get months to be accepted. Anybody
is welcome to give it a try though.
-- 
Duy
