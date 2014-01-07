From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] format-patch: introduce branch.*.forkedFrom
Date: Wed, 8 Jan 2014 02:10:45 +0530
Message-ID: <CALkWK0=vXGiHbd__ZNfp42fRS_gK5MNmYx13=uzDfc0m==V5Fw@mail.gmail.com>
References: <1389126588-3663-1-git-send-email-artagnon@gmail.com> <xmqq8uurcyw2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gister@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 21:41:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0dSw-0005sB-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 21:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbaAGUlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 15:41:31 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:56744 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbaAGUl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 15:41:26 -0500
Received: by mail-ie0-f170.google.com with SMTP id tq11so295213ieb.29
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Kyp4Yv7yMj0ROrNMhFbnEFN7XdZeVljdsV1klYCO8kI=;
        b=eKNg3EY/kgX1q32g0fdRoi0J1Gp3DRs8kLLvoMH5LF6aT09iFSWrgc2rJjfz+qED63
         zPPSlhjclZQl4YG6WVNMJGZur9VISUtJvjAmHtbcIZP5Wv79Lh6M/nb4t2twJKnAYdr7
         b/YMr/PaEbFf0YKZ99HG05rkfW4YrCigyuqaZTXScqJ5xDMd806NOB3RlYPoMgoch5eZ
         zzYELFV1b1U6BHvGXEX8OvZHQd5TjiWJQattTcY+nm6my4/OeyifGEI3AkxcL3aInfJ8
         opiZQXmvuiftfJZ/OGuPiVU+36XUXIT98Bop9CBZ0+uYu6u0S7k3U61hQrpw+F9UXxNy
         Wsxg==
X-Received: by 10.42.40.83 with SMTP id k19mr83494380ice.3.1389127285874; Tue,
 07 Jan 2014 12:41:25 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 12:40:45 -0800 (PST)
In-Reply-To: <xmqq8uurcyw2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240149>

Junio C Hamano wrote:
> I do not mind allowing laziness by defaulting to something, but I am
> not enthused by an approach that adds the new variable whose value
> is questionable.  The description does not justify at all why
> @{upstream} is not a good default (unless the workflow is screwed up
> and @{upstream} is set to point at somewhere that is _not_ a true
> upstream, that is).

Did you find the explanation I gave in
http://article.gmane.org/gmane.comp.version-control.git/240077
reasonable? I don't know why label the respin-workflow as being
"screwed up".
