From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: t0090-cache-tree fails due to wc whitespace
Date: Wed, 14 Dec 2011 15:57:26 +0100
Message-ID: <201112141557.26794.stefano.lattarini@gmail.com>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 15:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaqHI-0002ck-FA
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab1LNO5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:57:48 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44847 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1LNO5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 09:57:47 -0500
Received: by eekc4 with SMTP id c4so878948eek.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=LrDJv8vKLQnB7m604jdvaXVYQMbnBJ54m+zMmeqKOtU=;
        b=l6FnR8Iw8j6qn1Z45sE7ADzj8fTyKySIScg3dgVcecsSqnSGbtNnLwzM1JLZAirRJ2
         8xyPLKXGXZZFXP8NSaDqQ8y9jYUVtjUtJrtzQOntorrW4bQ+PDn5JbCNm7+hcaKCSw4c
         SQeRZlACqYFlPSuBF9PhyO77IcbrRW02bgOQc=
Received: by 10.14.51.198 with SMTP id b46mr1660174eec.111.1323874666381;
        Wed, 14 Dec 2011 06:57:46 -0800 (PST)
Received: from bigio.localnet (host11-90-dynamic.14-87-r.retail.telecomitalia.it. [87.14.90.11])
        by mx.google.com with ESMTPS id z54sm11217813eeh.5.2011.12.14.06.57.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:57:45 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/2.6.30-2-686; KDE/4.6.5; i686; ; )
In-Reply-To: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187124>

On Wednesday 14 December 2011, Brian Gernhardt wrote:
> It's time for my periodic complaint:  People assuming `wc -l`
> outputs just a number.  wc on OS X (and perhaps other BSD-like
> systems) always aligns the output in columns, even with the -l
> flag.
>
It surely does so on Solaris 10 as well:

$ echo x | wc -l
       1
$ for i in {1..1000}; do echo x; done | wc -l
    1000

Regards,
  Stefano
