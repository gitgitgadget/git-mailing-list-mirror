From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Thu, 19 Dec 2013 18:37:01 -0500
Message-ID: <CAJYzjmcbQVgRk9pjyWSqaDPz6=kFQ9spE14Bq5aG4dnuo-t=oA@mail.gmail.com>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com>
	<200905301505.38016.markus.heidelberg@web.de>
	<7vr5y6z9xp.fsf@alter.siamese.dyndns.org>
	<200905310001.44532.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Dec 20 00:37:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtn9S-00034p-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688Ab3LSXhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 18:37:04 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60375 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756585Ab3LSXhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 18:37:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id wn1so1957360obc.33
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 15:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JcSh5LFGNY07HB/8fMsR56QNl0hNwT3YsEv1Jv4NEcE=;
        b=KJL5vYNOShUxfUk/xgiGKz+tyZau5diK6KgleC4ThRvpXYdKRuIO2A6JHLEy/9/SMN
         JdFHHqIEp5/BvUmeVXlcFNdwWg3rsnvA4hHN94CLacA3jLu9LidpnczCLgWbw5uGxEvh
         UFEbdyVHjLKi8TjEKmzIZK9Qq6SmUv7pDgDJieHBnisZQa6wVsWnmY93sEt772vLQD1n
         h9PyWTruNre/GdTfxY+gDSrkaTF+oHqwgF7pZvvZSoOzgsG5MwQb8nOfCNgJQAmHgVvd
         JnRNG4WozPpqM9Ea+p8tHhoxFWRQQbXAwnPclpR2CMxBTkbhvk144qzBQ3gGT4EsHCpB
         LlLA==
X-Received: by 10.60.165.36 with SMTP id yv4mr3424894oeb.55.1387496221980;
 Thu, 19 Dec 2013 15:37:01 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Thu, 19 Dec 2013 15:37:01 -0800 (PST)
In-Reply-To: <200905310001.44532.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239556>

On Sat, May 30, 2009 at 6:01 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:

> In the buildroot project (it consists of Makefiles) there a lots of
> those workarounds. There was a patch on the list to replace all
> $(strip $(subst ",,$(FOO))) with $(call strip_dquotes, $(FOO)), but
> $(call) is not allowed in git for compatibility reasons.

Hmm.  What compatibility reasons, and are they still applicable?

[If you're wondering why I'm revisiting this, I was looking through my
branches for anything outstanding and found this patch series there.]
