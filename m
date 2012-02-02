From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: diff/apply statistics
Date: Thu, 2 Feb 2012 21:40:01 +0700
Message-ID: <CACsJy8DrNHwLGJjj4nJHDm-NEsr6c=QW-kgxmTbsRxq057keWQ@mail.gmail.com>
References: <1328116977-61458-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 15:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsxq2-0008H7-B1
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 15:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab2BBOkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 09:40:33 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47435 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab2BBOkc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 09:40:32 -0500
Received: by bkcjm19 with SMTP id jm19so2164673bkc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 06:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ocHtTs4s/CwDpkwLvEMk77DbJE/I3kSg0OZPQd2xhO8=;
        b=LCjnC3sH32RfKLNEFKnpcz7B4Tgqeipy62SewkPlq4/iGUcL64t6sm0gQD2O6PV8oj
         ZdetRjIXRZmWhqLCf8DhQKW33RhUpQkNK0v9wO6QEVEBsH2bCU2WDOyYZVY3C+4vM9go
         Mg0WXdJZofgj6Nh4+CK0CB9Wr7qbncxhbQ4lw=
Received: by 10.204.129.71 with SMTP id n7mr1457381bks.91.1328193631206; Thu,
 02 Feb 2012 06:40:31 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 2 Feb 2012 06:40:01 -0800 (PST)
In-Reply-To: <1328116977-61458-1-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189647>

On Thu, Feb 2, 2012 at 12:22 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
> translate oneline statistics of diff/apply.

There's another patch with similar goal:

http://thread.gmane.org/gmane.comp.version-control.git/189453/focus=189509
-- 
Duy
