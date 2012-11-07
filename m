From: Nathan Broadbent <nathan.f77@gmail.com>
Subject: Revert option for git add --patch
Date: Thu, 8 Nov 2012 12:54:30 +1300
Message-ID: <CAPXHQbN0x-o_4rQO-Lq_gDTqs=beBE5XrrzJ1Th+7G2Lq7Dh_Q@mail.gmail.com>
References: <CAPXHQbOxNG0XN80rH6mM6iSVtCtU26Yio_XQ=5ofBHBpZN3VyQ@mail.gmail.com>
Reply-To: nathan.f77@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 00:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWFSr-0006Mm-26
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 00:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab2KGXzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 18:55:02 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48196 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab2KGXzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 18:55:01 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2297029oag.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=zaZtdXhXU/r+zNuSsOZHypPQs5xnNdnd5vH2oqTmAIc=;
        b=qSX57FxPHg7zgC4M8ox+X2+S3++BHh2BT+ouBGFhYslXfQzAJ4EyjrA29rSAVxGMHR
         oSul6ot4o8A2h7YywFemDmQnyp9DYXf9fewjOnyCv/uX+m2HhudfuRjbL4qAT5wF2APu
         TNeCoTPhLCCT/aJoEddBp6GDYV913zORxOvCMhS6MYyB2kevSKUEpkzry7PlZ4FARQKg
         z5MsA+wcMKI9Vp9uk2BSajwGTVBD9csdjcdeYPl9OeGVu3bPWRMHGr6XZrOXreTcyJZF
         OGl2KCaZJ2vKp0Cs1jagO04aQvUYCAW3B61OkvHzzVcwhfweK9NLKhYu01uKT8+whD0f
         MmCA==
Received: by 10.60.154.231 with SMTP id vr7mr3446896oeb.119.1352332500538;
 Wed, 07 Nov 2012 15:55:00 -0800 (PST)
Received: by 10.182.39.35 with HTTP; Wed, 7 Nov 2012 15:54:30 -0800 (PST)
In-Reply-To: <CAPXHQbOxNG0XN80rH6mM6iSVtCtU26Yio_XQ=5ofBHBpZN3VyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209147>

Hi,

I would like to propose a revert option for 'git add --patch', that
reverts the hunk. I often use `git add -p` to skip whitespace changes
when preparing a patch, and a 'revert' option would save me from
running 'git checkout <file>' after I've staged the desired changes.

I would propose adding r and R options for the 'Stage this hunk' menu,
with the following actions:

r: Revert this hunk
R: Revert this hunk and all other remaining hunks

e.g. Stage this hunk [y/n/a/d/K/j/J/e/r/R?]?


Please let me know if you think this is a good idea.


Best,
Nathan
