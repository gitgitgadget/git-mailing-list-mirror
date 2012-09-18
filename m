From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 4/4] rebase -i: Add tests for "--edit-todo"
Date: Mon, 17 Sep 2012 21:58:15 -0700
Message-ID: <CANiSa6jcBWbeydMViruM1UYanhHiEugfHa5DepjGNdizq2otbA@mail.gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
	<1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
	<1347931690-20625-5-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 06:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDptB-0002sN-DY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 06:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710Ab2IRE6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 00:58:17 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45086 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab2IRE6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 00:58:16 -0400
Received: by ieak13 with SMTP id k13so1687220iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XUe51FqOykFqXbWi05RLqx8B1rfqf/M4JNTejDHIHiU=;
        b=Dp+JJp3MXXNQkW5I0Z2+XSscc7jKEHjF1edx9KIb8EHilz0xjK2qCmbxocvPgyOsl2
         qgwgaG5s4dPIPT/L5uoInQ5mH1cG5of5BTqZ+t/JIRNh+ugU+jX3emsGmZVoIhZXdjGp
         q2rB2y5xNRiU1HFQn7mvkZJSsSkQPbXruCbRduAlKfkxJzDTEcqX12zFlbUj06SutI0o
         0N0rDnWq2/UJabxQX/FXdFtiHEQdvqowoV7l5VM9ppSTj3t6IY0zkXmST8U+EDw9bkAm
         gdbQEyoFdOcr5dedhmbmybw4E0VBHi7yFDc3t8eHT7cOloUlxyaCVqRT3mQs3XBY9Ig4
         PSJA==
Received: by 10.50.242.3 with SMTP id wm3mr9275345igc.0.1347944295467; Mon, 17
 Sep 2012 21:58:15 -0700 (PDT)
Received: by 10.64.36.138 with HTTP; Mon, 17 Sep 2012 21:58:15 -0700 (PDT)
In-Reply-To: <1347931690-20625-5-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205789>

On Mon, Sep 17, 2012 at 6:28 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> +       test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
> +       test L = $(git cat-file commit HEAD | sed -ne \$p)

I couldn't find "$" (match last line) in the POSIX man page for sed.
Besides, I think $(git show -s --format=%s HEAD) reads better.

For future reference, and if you haven't already, you may want to
install manpages-posix (or manpages-posix-dev?) and then you can run
e.g. "man 1p sed" to see the POSIX man page for sed.
