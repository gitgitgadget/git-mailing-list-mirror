From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Wed, 24 Apr 2013 23:53:04 +0530
Message-ID: <CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-4-git-send-email-artagnon@gmail.com> <7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:23:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4MA-0005dM-0o
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab3DXSXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:23:45 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60418 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3DXSXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:23:45 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so2561639ieb.11
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=k841v1ZMvfyxLOhqD4zNU2ZgcAtpkFdtGUuuTZ+mVvI=;
        b=msXKJVJosCCnifoenDQWRfwTlYyrTXuuhoaVo/tzdV8TjP1YQLPAdltlfGZMrcttPF
         yys7rU+ibB6hEg9DUo+nlsIkPkabI/d56nUayWio3kGPL2apr9hgviMdbrMmbJLAUsJm
         WbQtFVmfP4EkqClu2wUyMdSsQNZtPeGN3mBje2i9UxKAhVyu8OChsrV+oE8q3Tc3igbE
         DmkGzEZjUPBMmJkE8SuaNmlr4bv/8Zrc5YFM9BoXVB5vGMRjAov87xa3pTFRNKMK21mI
         gXgaTtU4mAb6yb/aibQLBmx9JKtfcvKF8rOVx+oZlUi97DWY1TiNnvin+Mwtp3a+N5+f
         8mxA==
X-Received: by 10.50.57.200 with SMTP id k8mr28855429igq.44.1366827824655;
 Wed, 24 Apr 2013 11:23:44 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 11:23:04 -0700 (PDT)
In-Reply-To: <7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222286>

Junio C Hamano wrote:
> While the update might be logically more correct, it looks to me
> that the only end-user visibile effect of it is to make the end
> result harder to read.

Hm, I thought it improves readability.  I'm trying to say that -- is
used to separate [<path>...] from [everything else].
