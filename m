From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 21:58:28 -0400
Message-ID: <CAG+J_Dx8o_cpS3zLyRf66dgsRZEzP-yD8nBwLmfZhWkydX_MVA@mail.gmail.com>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
	<7vvclvrrad.fsf@alter.siamese.dyndns.org>
	<20120324165536.GA17932@neilslaptop.think-freely.org>
	<7v1uofqoa7.fsf@alter.siamese.dyndns.org>
	<CABURp0oJwM-KtdBRVHgvOaqFVjA-MEAfJoJH=52Y=QRcgFL+3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 03:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCLgA-0002pl-RY
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 03:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683Ab2C0B63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 21:58:29 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47362 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab2C0B63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 21:58:29 -0400
Received: by ghrr11 with SMTP id r11so4354353ghr.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4RcpZu+vbUlIYmSyF6262Opj6b28LBGNk2mv3v1lhoc=;
        b=oMqHeMqIkeKMdEO8IN1t6MNpGduP3XUYNF+ZajBEGSUY5n5IxlptPLR3KrNk7O+2Mu
         77VGaWNmKKvXB13Ao0y9OYkFukf5HxhTBsFYmCYqrlYf4ccRGc8TSXA9n5Ad2bF9qXVS
         Uq04uLe+Z4l1txx4z0wI7ALnRqXK6J50VrzG9rYCGRtWn1zdIFkyT54LS5NCmtQqhzE4
         qDAqKcevMpvPR4LaAMJDtoTOnBBodyrlqNJMIgAYIh8fb8uElrAvKn9TElw1wSBt5qNy
         EN3o8CgbHZZ22UHA/Oo2nTVvAf0aObv9NIEPKi9ktIqG5TiowkcS9DZIaOZ6zLukPkd+
         tRJg==
Received: by 10.236.197.41 with SMTP id s29mr24888163yhn.7.1332813508501; Mon,
 26 Mar 2012 18:58:28 -0700 (PDT)
Received: by 10.147.47.19 with HTTP; Mon, 26 Mar 2012 18:58:28 -0700 (PDT)
In-Reply-To: <CABURp0oJwM-KtdBRVHgvOaqFVjA-MEAfJoJH=52Y=QRcgFL+3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193993>

On Mon, Mar 26, 2012 at 2:29 PM, Phil Hord <phil.hord@gmail.com> wrote:
> Can we have three behaviors?
>
> A: Current mode, stop and error on empty commits
> B: --keep-empty, to retain empty commits without further notice
> C: --purge-empty, to remove empty commits without further notice

FWIW, filter-branch uses "--prune-empty", should we wish to be consistent.

j.
