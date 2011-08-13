From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] revert: Don't remove the sequencer state on error
Date: Sat, 13 Aug 2011 18:03:32 +0530
Message-ID: <CALkWK0mP50YPAuskBueokUpAHaPBRSh7yc8sR6OQ8cVM4hQppg@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-2-git-send-email-artagnon@gmail.com> <20110811192047.GE2277@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 14:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsDRS-0004s9-1w
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 14:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab1HMMdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 08:33:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38515 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1HMMdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 08:33:53 -0400
Received: by wwf5 with SMTP id 5so3626262wwf.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vt8zIXxCxAIK9TRytYPPD4yI0Dab0yRhQhmlV197CK8=;
        b=dWRbTGepgmnyY265Jabg/YnimQiXwtSnIKEu+NsPHKXnnDoPAdx9qG7NZM39hOp/C2
         Sck/1EmnukXxP8tAID1c6p54L1AXbtYMOgVN6inMQIWbZa+Ff0m/CoiJkbLjLV9F8Zb4
         wL1KaMkHwIobLwRibI6LfpwLDN5w+jovLCzss=
Received: by 10.216.175.130 with SMTP id z2mr1231168wel.63.1313238832066; Sat,
 13 Aug 2011 05:33:52 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Sat, 13 Aug 2011 05:33:32 -0700 (PDT)
In-Reply-To: <20110811192047.GE2277@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179275>

Hi Jonathan,

Jonathan Nieder writes:
> Why bother,
> when the behavior is suppressed altogether later in the series?

Actually, this patch helped me while debugging:  I'd originally
intended for it to go into 'maint'.  Things have changed though- the
'sequencer-stable' is close to hitting 'next', and this series seems
to be close behind*; I'll drop this patch altogether during the
re-roll.

Thanks for making me explain this :)

-- Ram
