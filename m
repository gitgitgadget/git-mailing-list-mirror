From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 12:28:14 -0500
Message-ID: <5356a6ae93668_463e11ef310e6@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <53558f6269f91_640076f2f08f@nysa.notmuch>
 <857g6h5ssh.fsf@stephe-leake.org>
 <5356996d12ede_3e5aed7308e5@nysa.notmuch>
 <5356A25D.1050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Stephen Leake <stephen_leake@stephe-leake.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 19:38:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wceeb-0007Da-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346AbaDVRij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:38:39 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:59695 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932927AbaDVRii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:38:38 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so6059329obc.37
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=ogMiJdsHtu41nzwA+nLSyyZapNI7eHwYoEKnAU5/F4Q=;
        b=fSyDCE9xqPZqEwnFwFkL3a55+Qsiy5t4Be7+lRxE1Jv8KMbz+AKq5GQk+gp1yh1BNs
         6KRy7hsSRbqGzy5LgwwdoLYSKFCr1LqzWZSeH31b9OKshDq/p2ljn0QMpPpyl7mcXiU2
         nZAwbQ5H6aHkiBz1gPfEb13xE2OGltAmaZXvxdHnQpIuK++t8TAn5DDvmW3gXnfPmzu3
         rwAchRt9sPHEB9kvMfjWuCOtc450NC6qmfI46XsWUJtwdO+tBTPMDJlTtger4Pj8GWme
         3RTinQ3oGyZS5oJVwC2Kf15gXmylw487COCfD9pDbHaWAAzHZ+Ntu86xofti6uegMag2
         9aGg==
X-Received: by 10.60.15.38 with SMTP id u6mr37942895oec.26.1398188317771;
        Tue, 22 Apr 2014 10:38:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id gu2sm15766167obb.20.2014.04.22.10.38.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2014 10:38:36 -0700 (PDT)
In-Reply-To: <5356A25D.1050001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246757>

Ilya Bobyr wrote:
> On 4/22/2014 9:31 AM, Felipe Contreras wrote:
> > Stephen Leake wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>> Yes, there a reason for the existance of those hooks. Now tell me why would
> >>> anybody use post-update-branch instead of pre-update-branch?
> >> 
> >> I have a branch which should always be recompiled on update;
> >> post-update-branch would be a good place for that.
> >> 
> > And why would pre-update-branch not serve that purpose?
> 
> "pre-" hook could be used, but if the hooks is not supposed to prevent
> the operation, it seems reasonable to put it in the "post-" hook should
> one be available.

If 'pre-update-branch' can be used, then you are pretty much agreeing to the fact
that the 'post-udpate-branch' hook would be *useless*.

Such a script would work both as 'pre-update-branch' and 'post-update-branch',
therefore a single 'update-branch' would serve.

So I ask again:

Tell me why would anybody need 'post-update-branch' instead of
'pre-update-branch'?

-- 
Felipe Contreras
