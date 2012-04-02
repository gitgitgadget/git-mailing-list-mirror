From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Updated tags on repo are not updated when pull
Date: Mon, 2 Apr 2012 16:29:44 -0700
Message-ID: <CAJsNXTk8R0yjad0T9605v-CMMdCA+C0v3Rqt65h_k6MK88UD9g@mail.gmail.com>
References: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sebastien Tardif <sebastien_tardif@oxfordcorp.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 01:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEqh6-00089F-6l
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 01:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab2DBX3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 19:29:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59013 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab2DBX3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 19:29:46 -0400
Received: by wgbdr13 with SMTP id dr13so3146920wgb.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=wYiLX6kLIPTyJC2tTO+sep6QSWLbqQfOVqA0IYv7+BI=;
        b=qtGCziQstim9jDr5UWWz653nMGBn1plIGCiIZQNTzOQ/ojGhpEmT2ykUKlIbSypduM
         LzzR8IG38iMv2S/z7+AjTzo89HLI58+SbH3zjR+846cf1vQa5EzlK7f2QHSs0XCgVpmu
         g76DPwrCgiT+30ns01tFGVSIPDCQJnSoJjwYJfiMxBokpIwR1/AxW7TxBiMAOvem2pZk
         qL2mVgCuWyrQ7zC6lFtOEG7mvNw6U2bVzR7tCjFwkUCO77K6Ua3QVcU1+2dz5WTi2rV+
         3TTrcQMJNih0pOl526ikpiLXmtFGklldQ8phb2DSPNSaOaNU4hIRqDPTUoRPAA2DhDk2
         TcuQ==
Received: by 10.180.79.135 with SMTP id j7mr30155538wix.19.1333409384979; Mon,
 02 Apr 2012 16:29:44 -0700 (PDT)
Received: by 10.223.116.200 with HTTP; Mon, 2 Apr 2012 16:29:44 -0700 (PDT)
In-Reply-To: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>
X-Google-Sender-Auth: Fa3a-yRozPfDBdiJ8MhmY_lYQzg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194580>

On Mon, Apr 2, 2012 at 12:16 PM, Sebastien Tardif
<sebastien_tardif@oxfordcorp.com> wrote:
> Default pull behavior does bring new tag that are hitting the revisions involved in the pull, in other words all tags that would point to log entries that are pulled.
>
> I have tag like: LATEST_UIT, LATEST_QA, LATEST_CONTINOUS_BUILD
>
> But with this incoherent behavior of not having the already pulled tag been updated when doing a pull, my developers end-up with misleading information in their log since their tags point to old pointer.
>
> Please fix.

There's a discussion in the git-tag man page about titled "On
Re-tagging," the upshot of which is:

'Just admit you screwed up, and use a different
name. Others have already seen one tag-name, and if you keep the
same name, you may be in the situation that two people both have
"version X", but they actually have different "X"'s. So just call
it "X.1" and be done with it.'

You could use branches instead of tags for your 'latest X' things.  A
branch is basically a tag that moves.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
