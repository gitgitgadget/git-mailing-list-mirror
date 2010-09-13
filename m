From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/6] git-reset.txt improvements
Date: Mon, 13 Sep 2010 18:15:50 -0400
Message-ID: <AANLkTi=Th0BN=ojA8F-7d-__Fp=+bRvtCi37i5vfy8-o@mail.gmail.com>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 00:16:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHK6-0000qf-E9
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab0IMWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 18:16:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39982 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0IMWQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:16:20 -0400
Received: by iwn5 with SMTP id 5so5479966iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oqhF6Vn8ES2dPV8rBG/Gatfat798ECbkSiUUQzdnCZQ=;
        b=wYAarlyJcBhLERNc2EH8o0A2OCRfDy2xEElFbf2NIHZZemN/2kTzypShU3cs5XLvqd
         2WOnfIHMXdm8+5gJtmpD+8XyRkZKDXUqb3nOTwuqWyzX1fZ9Pn+RZW7+DP0pQ0v3T+zk
         VNCN0u4CJiE4InmU2a9S4LBUEHILbJjuWK/xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kZRverKycrKpGL7qhG+Rr78XCtIKyIbVXaGIH5TNapYI6FMDvgSfb4qY0hHacytEIX
         X8RVEdR3+idDy/wakITwg2HRwwk4CQ92GDIqusscWXJsQmLSVejRE4OLHBjgppir/rwx
         rJoyRsGkPt7A68r+SkUUDxK2IBvTIEXHdQk24=
Received: by 10.231.193.81 with SMTP id dt17mr6409993ibb.177.1284416180175;
 Mon, 13 Sep 2010 15:16:20 -0700 (PDT)
Received: by 10.231.11.11 with HTTP; Mon, 13 Sep 2010 15:15:50 -0700 (PDT)
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156147>

On Mon, Sep 13, 2010 at 4:06 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> First of all: I've been out of the loop last week, so please forgive me if this
> comes at the wrong phase of a cycle.
>
> I portioned the changes to git-reset.txt and ordered them starting from the
> least controversial, I hope. The descriptions of modes have grown organically
> over time, and this series tries to make them consistent in structure and
> wording, after cleaning up some minor issues. 6/6 is the "meat", so to say.
>
> For the "--merge" description in 6/6: Please double check. I've tried to
> understand the mode from the tables and from the inner works (git read-tre -u -m
> plus carrying over unmerged entries) because I did not understand the original
> description.

My quick read of these changes is that, all around, they are a big
improvement to what I find to be one of git's most confusing man
pages.

j.
