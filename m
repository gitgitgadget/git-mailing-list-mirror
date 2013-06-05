From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/15] Towards a more awesome git-branch
Date: Wed, 5 Jun 2013 13:41:40 +0530
Message-ID: <CALkWK0mbyoEMBkJa8VEBnPCxSBOFz1i3_EH13Zn4rAvCr_Cfcg@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com> <CACsJy8BDwVL3NC-vweCzn1Lr7-rdOvFGzopBf3qZcO6wyx4fhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 10:12:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk8pZ-0006UQ-Ts
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 10:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3FEIMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 04:12:25 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46145 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab3FEIMW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 04:12:22 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so2928806iea.18
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2ZLPkgcvD7uFuQ9sDLeqoSmL0I7OVhjOHizn0FFxOBA=;
        b=CnTwtuMTMN+jFDkKMk+yA/QMT/Ei5DXB31WQ8YAbPiOrMvUpkLBdXDQEsTf6/jGs63
         q+LsNuA3kDIgT8zH69eqklQubGPEDuMDQ6icT+9N/um2rLdMz2HDZALHkXZt9cOpUNQp
         M81E52Oy+eLBmOae6A9jPtMnKBZl6LLcgwL/mIamvr0H1dsmgV73sGaPOiBntHKWsABh
         MoZ31zqyI6Q584r0hkvJ02eD+zF1669b0QoiD2zB1t6T9Kojcv7UXee55nXUdtnuKHK7
         +ZyY2JsFCKEu8nVtk7v9vJs9EKrxliscG1TfIbPlBXwnt7CiAzTwudI5pXOoNQhhXK6v
         hwCA==
X-Received: by 10.50.171.161 with SMTP id av1mr2617635igc.104.1370419941828;
 Wed, 05 Jun 2013 01:12:21 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Wed, 5 Jun 2013 01:11:40 -0700 (PDT)
In-Reply-To: <CACsJy8BDwVL3NC-vweCzn1Lr7-rdOvFGzopBf3qZcO6wyx4fhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226441>

Duy Nguyen wrote:
> I'm still hung up one the detached HEAD thing. It's a bit quirky to
> put in for-each-ref, but for-each-ref can't truly replace branch
> --list until it can display detached HEAD. But I think we can finish
> this part and get it in first. Should be useful for some people
> already.

Right.  The branch is called hot-branch; let's polish it for
inclusion, and rebase for-each-ref-pretty onto it when it's done (no
need to stall work there).

> Signed-off-by:
> me for the whole series.

Thanks.  Will add in the re-roll.
