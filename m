From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git svn clone options
Date: Wed, 10 Oct 2012 11:15:46 +0800
Message-ID: <CAHtLG6SikQGT12jn-EBYmL7wL_EF-+kpRtcne2wM8XTrFqSpSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 05:16:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLmmU-0000Al-3S
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 05:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350Ab2JJDQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 23:16:10 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61326 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332Ab2JJDQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 23:16:09 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so104208lbo.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 20:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=j0ARDogHJA05ba6UffKzeBL+OSJbflvjl4Lo46Qs0I0=;
        b=M4kMJeRgNf+lR8Dtl1eqZfD3MtPHwwjaR+SSUlJUMwCkLysCMsmOejGfAHng/2tXN0
         InPRfhGGko+nE9iwxLG/ArDeW1Qu/u/OomYAu3uf7msRP2CUV+T7Ky/+IlgdcnzKZbQS
         HST8L7kvfOHZsqYDR+j7s/C4ctlDmQ2J1jC3La9ghGzvHUFkZPUF2iWbnG8ypXNcz0ec
         3J4Kg1EgueO8+eN30vl8b6alzhX5IVyeXQMa0CkwNrC+c5IcYD7AtX0PdLvSFr1yvWOx
         lZ8PplbUej9pYV00ZrWUQNekIpqGqKxJS6+Vh+5Xot4ORwpnq2xRndXA9yiM4KgA6oUo
         fBPQ==
Received: by 10.152.106.212 with SMTP id gw20mr15667231lab.8.1349838946404;
 Tue, 09 Oct 2012 20:15:46 -0700 (PDT)
Received: by 10.112.5.70 with HTTP; Tue, 9 Oct 2012 20:15:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207360>

Hi,

I tried
git svn clone --stdlayout --branch ABC
but svn branches were missing (trunk was present), compared to the result of
git svn clone --stdlayout

Could you clarify --branch option, is it the same as --branches.
I thought git clone has --branch option, so I tried this option for svn.

Alos, I tried
git svn clone --stdlayout --no-checkout
It worked without checking out files.
but git-svn documentation seems to not mention this option.

Could you also tell what options are supported in both git clone and
git svn clone, and git clone only options?

Regards,

ch3cooli
