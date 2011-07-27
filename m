From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Wed, 27 Jul 2011 19:51:31 +0200
Message-ID: <20110727175131.GD29924@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-4-git-send-email-artagnon@gmail.com>
 <20110727041809.GB18470@elie>
 <CALkWK0kFngXcyrKeB4HM5GdHebkuXOQ5jBETxWuxZCzYL94tqg@mail.gmail.com>
 <20110727174234.GC29924@elie>
 <CALkWK0npk7T+=XArxgft93XAifQvWLpjisg_XhhS-h6EmjS4Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 19:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm8Gq-0000Iy-8L
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 19:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab1G0Rvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 13:51:43 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:57246 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab1G0Rvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 13:51:42 -0400
Received: by eye22 with SMTP id 22so2196153eye.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=brlbFqGZFlyCfrjuvBVG6B8vqMEbbigiSHD3yB2O3f0=;
        b=RY0rZEC5v2xEDHu9C/JFkLNVPHoTZwV3sP9jU+F5lXLRUVyfYCHTDwm4V1wjAkib6z
         rFaA3g8XtH8jRggGx4JVykL+Dg3pnRYgB9J6KC3DI1Dg0pzIZXgkE+gawcQRwyiiv7+Y
         7P5ul8VhzrUk1bBym1zExzZFr15CDSfd7/Seg=
Received: by 10.213.3.195 with SMTP id 3mr41316ebo.71.1311789101021;
        Wed, 27 Jul 2011 10:51:41 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id q22sm66071eea.52.2011.07.27.10.51.39
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 10:51:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0npk7T+=XArxgft93XAifQvWLpjisg_XhhS-h6EmjS4Hg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177987>

Ramkumar Ramachandra wrote:

> Ah, thanks for the elaborate explanation.  I'll document this aspect
> in my patch accordingly.

Thanks.  By the way, when an explanation is too elaborate, I'd be glad
to hear feedback of the form "You could have just said X". :)
