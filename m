From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: APIs for automatic patch generation
Date: Tue, 23 Feb 2010 18:07:13 +0100
Message-ID: <fabb9a1e1002230907u6471efa5w234a5dabfa4ba5e1@mail.gmail.com>
References: <4B803AB8.30304@web.de> <4B840AA2.3010604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:07:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyEc-0001je-KC
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab0BWRHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:07:37 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40226 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0BWRHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:07:36 -0500
Received: by pwj8 with SMTP id 8so3966617pwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 09:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=0DqHicTrPtyGfAjlg3YT93ItcCZNNUB/tQXKkx3AXv0=;
        b=nxIGFHbmqmrKFl8hy78DpNC3rkKfXEmjEGmuA99SSPaB2XwqmTRuvIFea7Z/SC5c4j
         Z5IVkoXgTA1dG5/vL86jOZiF8hrTXk6G8J/kczSRK4sGv4s2oNWlpfLtpTibAMJOfriz
         n6YNYl0Cne4cmzwkt+dTz5f3ZdVvAbmcc8vOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YKZkiY4vAY1KTTZbTu+qaodBugJuHONv0Hom5jR2J8W8lguWDO9rPTW45woxZgbT6G
         t12n4PhIOB7lJN0n2uQY0G5A1mj2iY3webUHdPRmMgUtR9xuTJdo5XrrR0tJuASmjxq+
         l0gR3X3nHh31xAU4WobxQ2NvE4dfvqP9yF98M=
Received: by 10.142.59.3 with SMTP id h3mr186577wfa.93.1266944855455; Tue, 23 
	Feb 2010 09:07:35 -0800 (PST)
In-Reply-To: <4B840AA2.3010604@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140812>

Heya,

On Tue, Feb 23, 2010 at 18:04, Markus Elfring <Markus.Elfring@web.de> wrote:
> The commands "git diff" and "git format-patch" contain functionality that I
> would like to reuse for my little application in a C++ class library.

Until libgit2 is done, just shell out and call 'git format-patch'.

[0] http://git.wiki.kernel.org/index.php/SoC2010Ideas#libgit2

-- 
Cheers,

Sverre Rabbelier
