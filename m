From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 01/23] sha1write: make buffer const-correct
Date: Sun, 22 Dec 2013 10:06:36 +0100
Message-ID: <CAP8UFD3fnkGZPd_m42om-divjDAihZxcDuUR5nCQzCgGe2fPDQ@mail.gmail.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
	<20131221135926.GA21145@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 22 10:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vuf0O-0000dE-C8
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 10:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab3LVJGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 04:06:40 -0500
Received: from mail-vb0-f44.google.com ([209.85.212.44]:36383 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab3LVJGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 04:06:37 -0500
Received: by mail-vb0-f44.google.com with SMTP id x8so2329591vbf.31
        for <git@vger.kernel.org>; Sun, 22 Dec 2013 01:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pLf7AfeRgUKYu/OUMhU07CfbstUUlTZ72yr+qQBV5lY=;
        b=JtXsc5pVqeE35txCKQZPcXl+1tEPWz/QMeCxrwO7HnUKgEjwFmwl8af8VajsdQUnT3
         MwHV8KxGrIQvjWcOOOyKiWTi8y8i9HdOmFM+IFLJk6Y3V+W8ZB9ryb0Q8gZ+jVisQkBN
         mwVYkYF7dVP892hcqspCUsqyKQrxxaZGOXxVCn2qVk/VnAdK0eA6x8TO5d/PpJQ5kj92
         gAQ+bMR8fXJ4ro4fq5RCjA4K8uJ4QDfJard0ZQyqCoLSTv6+IY5ppcV935ckMj8jJPO/
         f/p/PY3eaAMG1uY8I0hVOwrsxKlPOhzZ81beICAFLuDNrGy3KoebOXqOyCKrB3+kAW1c
         0RPw==
X-Received: by 10.52.117.135 with SMTP id ke7mr823775vdb.43.1387703196581;
 Sun, 22 Dec 2013 01:06:36 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Sun, 22 Dec 2013 01:06:36 -0800 (PST)
In-Reply-To: <20131221135926.GA21145@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239641>

On Sat, Dec 21, 2013 at 2:59 PM, Jeff King <peff@peff.net> wrote:
> We are passed a "void *" and write it out without ever

s/are passed/pass/

Cheers,
Christian.
