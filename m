From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Migrate an svn repo to git - Where did all the branches got? and 
	tags?
Date: Fri, 21 May 2010 16:11:28 +0000
Message-ID: <AANLkTinE8TyUB43ZACRXo8U0ghgnQ9cbBOkcl0zBJlWm@mail.gmail.com>
References: <CFE20E75-F23D-41EA-89AA-2FF59BFA5DF9@verizon.net>
	 <201005211141.45664.trast@student.ethz.ch>
	 <6E5E7194-CDE0-4D39-BD36-B837030C261B@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jack Moore <jhmoore719@verizon.net>
X-From: git-owner@vger.kernel.org Fri May 21 18:11:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUp1-0000pS-Qr
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207Ab0EUQLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 12:11:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60779 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab0EUQL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 12:11:29 -0400
Received: by iwn6 with SMTP id 6so1334197iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Xo7rczslmGtdOMwrhhij8o10JgJbtPRST0KjdNvHjKY=;
        b=CcJqgeH+rcrhFJAXwDxE7AVA7HZPQTluHcXBOs8w7Zo6HaZJvWR1ErgWotg+WMzM7I
         WvA92Ynygkj3DbGDeJHn3U7X98180cUoi7p7YCuJQr5hzxZNHUt8YTfPQA5YMZXXxNqF
         LxTZzxmX+eqSgOZfSNwOkoHxlStif5l0K+TCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=e+jRtzEZXbQA+0sD+ubCv2mf9NnKD4NSF/u0EDy3McImsQkSfmyDgk2+aI9daQe6n3
         NjXuG3m3BPBWt555WjnIVoytBqIJJ8/bmaI+FE0uvb7c9QasIDmFfznUXlLHG70lTokN
         vnGXVWq4mwqZDbL60qctMMjkQCsAStMJMMIpk=
Received: by 10.231.149.203 with SMTP id u11mr1797169ibv.6.1274458288518; Fri, 
	21 May 2010 09:11:28 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 09:11:28 -0700 (PDT)
In-Reply-To: <6E5E7194-CDE0-4D39-BD36-B837030C261B@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147478>

On Fri, May 21, 2010 at 13:57, Jack Moore <jhmoore719@verizon.net> wrote:
> Thx, Thomas

If your history isn't too crazy you might want to try converting with
snerp-vortex instead of git-svn.

It isn't always better (or indeed, often), but might be in your case.
