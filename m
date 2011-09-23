From: Michael Witten <mfwitten@gmail.com>
Subject: Re: permission to re-license strbuf subsystem as LGPL
Date: Fri, 23 Sep 2011 15:36:07 +0000
Message-ID: <CAMOZ1BvUFtCJ0=cqMX6QnJVJ0FyPYBDoJpWFqw_JhkCtJy3p-Q@mail.gmail.com>
References: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
 <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 17:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R77nx-0001wU-5y
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 17:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1IWPgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 11:36:38 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51488 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab1IWPgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 11:36:37 -0400
Received: by yib18 with SMTP id 18so2707547yib.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 08:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c0kKwb1lM+WfVoA7AAAUsGQ8XqGUCxeWieVIoMZngBs=;
        b=HIrcLTqR8Bsr8tJYhzbcAkSEiYcyyISoU5n/yKwo2M11Vn6mNthWK3ijI7WafJky7b
         q2otWakEpmJzrbnvL/8G+8wlnl5YMR9DwPJ5HnnCeN371oqi7f9divdDjieqLQVP2TxW
         CZQuPcvVW70rYtxcTlvCbmrFP+dJYL0SWDo24=
Received: by 10.42.18.202 with SMTP id y10mr4561496ica.19.1316792197098; Fri,
 23 Sep 2011 08:36:37 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Fri, 23 Sep 2011 08:36:07 -0700 (PDT)
In-Reply-To: <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181971>

On Fri, Sep 23, 2011 at 15:01, Brandon Casey <drafnel@gmail.com> wrote:

> Jonathan Nieder suggested using a more permissive license than LGPL.
> BSD seems to have the most support.  If the remaining contributors
> agree, then I'm fine with licensing under BSD.

BSD is more permissive for only the upstream; the downstream
('end-users') get nothing.

In fact, the downstream may ultimately get a license that is more
restrictive on further developments---possibly even restrictions that
might hinder the development of your own upstream work should you find
yourself in some sort of downstream position relative to a fork.
