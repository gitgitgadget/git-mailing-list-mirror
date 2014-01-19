From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 03/17] safe_create_leading_directories(): add explicit
 "slash" pointer
Date: Sun, 19 Jan 2014 21:31:20 +0100
Message-ID: <CAHGBnuMdEtRMg4apeRAt0QY9dMm6p3MB_DZ5axBG-L=R-vh_ww@mail.gmail.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-4-git-send-email-mhagger@alum.mit.edu>
	<xmqqppo5hsf9.fsf@gitster.dls.corp.google.com>
	<52CBC854.2060602@alum.mit.edu>
	<xmqq4n5fg05g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 21:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4z1g-0007N7-Tl
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 21:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbaASUbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 15:31:22 -0500
Received: from mail-qe0-f41.google.com ([209.85.128.41]:59414 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaASUbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 15:31:20 -0500
Received: by mail-qe0-f41.google.com with SMTP id gc15so2487524qeb.0
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 12:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NZvlSdBVr0zYthELat4A1TdnNaayMoaXmYtUOX98KZY=;
        b=qhuDSPzFvL8lfrPW63ZHTgky5HiROYNdgq3N2XTAfAvPrbgvhW/vJjRI2d16cPXlJu
         +LFsDONfSBO7PKrpro//5aAIyw6xCunIAYDDIqkkjvqREBbYvgTi8EgyAvO01bKfxVtP
         Rm+mQN387QCZN4YeQvJ4Xj5HwukPHNRr2Ui/nFz4gFkyJfUjc+qjkuWHzgQwNBEgERUR
         SGABZPh2vYZ28GJgxde5RqjQLT4/MEOrWSInJ+uSrdCEmgjA8k+yiX+UfJQSfx6fA+wU
         rO5y8Q03ij3vQ1ROZqSxZDqRdjZZ7EuHxOMFTlt5HIxiUAmUaOUnW9fzm1CE6RX7Jeug
         FYYw==
X-Received: by 10.229.122.195 with SMTP id m3mr22538416qcr.7.1390163480084;
 Sun, 19 Jan 2014 12:31:20 -0800 (PST)
Received: by 10.96.22.229 with HTTP; Sun, 19 Jan 2014 12:31:20 -0800 (PST)
In-Reply-To: <xmqq4n5fg05g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240701>

On Tue, Jan 7, 2014 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Let me know if you would like me to merge or rebase the is_dir_sep()
>> changes into this patch series.
>
> I'd want SSchuberth and windows folks to be at least aware of this
> series and preferrably see that they offer inputs to this series,
> making their is_dir_sep() change just one step in this series.  That
> way I have one less series to worry about ;-)

Thanks Junio for pointing out Michael's series to me and resolving the
initial merge conflict. However, as written in my reply to Michael's
mail of today, I'd prefer to take Michael's patch that applies cleanly
on top of v3 of his mh/safe-create-leading-directories instead of your
merge conflict resolution.

-- 
Sebastian Schuberth
