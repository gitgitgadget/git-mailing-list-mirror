From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Mon, 31 Jan 2011 15:54:32 +0000
Message-ID: <AANLkTin5yR84x=3Qb3W9bZYhUHwbcrhf60Z1CwHyYHOL@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
 <1290648419-6107-1-git-send-email-vitor.hda@gmail.com> <AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
 <AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
 <AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
 <AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
 <AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
 <AANLkTinCL6+oTAbh4WpsWHx8cZ8cxZvQxSO9EX_xsHh0@mail.gmail.com>
 <AANLkTinrALdy9w7K50r=k-oMV9V5+7+LKvui_DSmJ6nK@mail.gmail.com> <AANLkTinKQRfwaMpGQiDCkh1RerQ_MrakwvNLAqgmbF9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 16:55:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjw5x-00082H-8f
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 16:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab1AaPzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 10:55:06 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53319 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab1AaPzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 10:55:05 -0500
Received: by vws16 with SMTP id 16so1961304vws.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 07:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2ecM0iKg80Zy0cbBhFDCvs3dCp/5UQRwIyzxNSHrW5k=;
        b=d/haCu4JSpWJMSZbXJ2YIO5qw8U11abztFvQ2gtsFmUCaQtxQAAd1TNIYi4htHLroO
         cQCi3w/GhS2fQsMxi4KkqY5UMQ2TsaMEZhLsX3zqNsbd8q5trcRljuWgSiRIesNYRCr0
         0VE8NO8BJv1IXaziXsATyd6TbSTFjVJxW3YgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=v1vjTFs3sNaFoy9R89TgEEwVEE4Sl+wF8x+rMjG+6dLx3FifGUAX3yNAo8hepGB3rf
         F3OUzq3NkVx3f1UInAr61fPDJU8GVBB6ZBIG7u/STjP+BvOntJ91lzhm6/6Xo1ctwrQ6
         Ck7W5Y+VDn2lWRx1Is75l9JGS4gw+8TuAEGsc=
Received: by 10.229.188.144 with SMTP id da16mr5960516qcb.158.1296489303613;
 Mon, 31 Jan 2011 07:55:03 -0800 (PST)
Received: by 10.220.192.8 with HTTP; Mon, 31 Jan 2011 07:54:32 -0800 (PST)
In-Reply-To: <AANLkTinKQRfwaMpGQiDCkh1RerQ_MrakwvNLAqgmbF9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165732>

Hi Thomas,

> On Mon, Jan 31, 2011 at 12:51 PM, Thomas Berg <merlin66b@gmail.com> wrote:
>> I also discovered bugs in git-p4: in some cases, if the first submit
>> to a new branch in Perforce is not identical to the branch it derives
>> from, the import was not correct.

I forgot to answer this specific topic. I also noticed this bug.
Basically, git-p4 choses the first commit from the origin branch to
start the branch from. My idea was to walk through the commit tree in
the original branch until I find a commit in which the diff is null.
Unfortunately, I don't know what is the best approach to achieve this
in git. Do you have any ideas?

Thanks,
-- 
Vitor Antunes
