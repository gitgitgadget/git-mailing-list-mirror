From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH RFC v2 01/19] rebase -i: Failed reword prints redundant
 error message
Date: Thu, 10 Jul 2014 13:04:55 -0400
Message-ID: <CADgNjanVFEBwbgL8O6U04fpmsDi+UFcRH4PPvy7LyrFYsnDr-g@mail.gmail.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<10d7fae199e4d8adec537aa377177de652badc07.1404323078.git.bafain@gmail.com>
	<xmqqtx6r8uem.fsf@gitster.dls.corp.google.com>
	<CADgNjakNQKbA8fYJqz7n-C9aPoZdfxX+N9Xuq1irJ_ajB8Yt_w@mail.gmail.com>
	<53BEC0BC.6030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 19:05:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5HmO-0005Xf-3d
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 19:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbaGJRFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 13:05:00 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43046 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaGJRFA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 13:05:00 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so765647wib.9
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e+QhoUHWOU85SX5Kn7FvIvL2yUYdBve8LojXUOAe2WM=;
        b=b+UHkStsXVrrZhG1JsnP5zo9Mrzy3k4E38+aoEgbXcYC+4t3Si5nV3WRI9ssqj1mlL
         tVyNtVFK377i0ftWHi6jbrMaoht15r7d2Bqpvy7DMDXSO3CA8rg3esCICRSwcI+hUmc9
         2brd4mHyjgjufgec6zGcwFi9ysvLhvLv3vER5TPshSg8EatrWGHsJPeLKmL5jAP4WWIG
         rVz9z8ixL+OpCCDuxIJ32RNfhvJicbvds1lrCAfpFWUwzu/xsLOvdy6R4ekPFtERWRSx
         08KXS4R/zw3aNjgFnoceeOC6HNX+TVjuKuys5sw+IK8s4wLTdLkEKoAU/o6ggAItZhXv
         8ZkQ==
X-Received: by 10.180.24.97 with SMTP id t1mr20829735wif.45.1405011895645;
 Thu, 10 Jul 2014 10:04:55 -0700 (PDT)
Received: by 10.194.136.46 with HTTP; Thu, 10 Jul 2014 10:04:55 -0700 (PDT)
In-Reply-To: <53BEC0BC.6030600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253192>

On Thu, Jul 10, 2014 at 12:35 PM, Fabian Ruch <bafain@gmail.com> wrote:
> That is still taken care of by exit_with_patch here.

Oh, that's right. Ok, go ahead and remove the third warning then. Thanks!
