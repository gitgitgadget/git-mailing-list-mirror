From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] sh-setup: add new peel_committish() helper
Date: Fri, 14 Jun 2013 21:48:55 +0530
Message-ID: <CALkWK0kCOJTRTQ-eKbOUnD18xWFqMnYi385aN=+_H4CoLZSLhQ@mail.gmail.com>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
 <1371215872-9796-3-git-send-email-artagnon@gmail.com> <59954A85BB7C4B279B61C46CC1D81CCA@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWiz-0007ui-5r
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab3FNQTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:19:37 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:34863 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab3FNQTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 12:19:36 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so359011bkc.14
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2sLCcqa6O08skYBFVGeRNDWONUaP9glBgyF5q8zb6FE=;
        b=NYjtzmiV63qw/wY4LmkAhsPBJKN5GMTpxKW4LYAym2qxxLdK3G02W1Pxm3UPydWd2J
         YZILCYzJ5lhT5AsmcaRHXjvQi9PZuU9ApntnRCUw9fehonAO+1jHEa5nKc6EUKRE2VBc
         xI88CFtvcFxg9q/szkn50qh68GfxlWd0Awo9xZQpXWtXhimPn20FiwJ/ftvvTrQ5uWV2
         0p6BkdoUcm3pNXB924t0chpyvMWGuAhE54CWErq8MDo/5+CZlH1P6r/eTqoLmNbTMAkf
         MEsszBEmnQVx7sQVW+Q7aR6ZrhliPpSAukEkuDUbFuZuyIW8D38W8of6C+9EdkRR2cvp
         EP3g==
X-Received: by 10.204.183.200 with SMTP id ch8mr461987bkb.77.1371226775289;
 Fri, 14 Jun 2013 09:19:35 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 14 Jun 2013 09:18:55 -0700 (PDT)
In-Reply-To: <59954A85BB7C4B279B61C46CC1D81CCA@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227894>

Philip Oakley wrote:
> Is there a proper name for this style of revision specification? I've been
> letting this 'style' wash over me in the hope that I'd understand
> eventually, but it hasn't.

See gitrevisions(7).  None of them have any names.

> Loking at git-rev-parse I now see that it might be the 'Commit Message
> Regex' rev specifier.

Did you just invent that term?  I couldn't find any mentions of it.
