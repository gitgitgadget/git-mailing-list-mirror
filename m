From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/11] Use "git merge" instead of "git pull ."
Date: Tue, 27 Aug 2013 12:44:22 -0700
Message-ID: <20130827194422.GW4110@google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
 <1685937666.34465.1377626298173.JavaMail.ngmail@webmail19.arcor-online.net>
 <xmqqob8jc5s6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker@arcor.de>, git@vger.kernel.org,
	martinvonz@gmail.com, wking@tremily.us, philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:44:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPBo-0003Ca-IZ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab3H0To2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:44:28 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:46664 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3H0To1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:44:27 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so5286169pbc.29
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cKomW6DRKgJL1kMuD66CO8S1CT+Kw2GF/5L40+oBTWI=;
        b=nyYFja6sqtb48ADTo0DhuS6JzbM0TUgxi3T6pcuXjXjX+g6VVm6RxaWUuKyQArLPRA
         rHa3EpTmkuCcQtVS50B0ZgTSeTjuO9Sg2Oza3/Rze30MJKQGBCSkzhrH2hwN2V/Vldgc
         /qjYtoQZ1ksEnxdu/0sfv0+BukOwvoQ2rj0xUvx2Yym6NHCK6WOo9xFajGkvrbTbO4WG
         RL12Nf9aFcqam5ZUsHD8Tnq1xvzBHKhcH4KvyyqXQilirnVQTPUpnWEsuyj4H0B4F89F
         iddsuXPAShmY8rkD5oqc7uQ4BK0XUfljkYhN4fMOdpwMx59gZzeoCvM6oyGLc/lLbM10
         skcw==
X-Received: by 10.68.225.42 with SMTP id rh10mr10815678pbc.176.1377632667351;
        Tue, 27 Aug 2013 12:44:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wp8sm26366269pbc.26.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Aug 2013 12:44:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqob8jc5s6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233146>

On Tue, Aug 27, 2013 at 12:06:33PM -0700, Junio C Hamano wrote:
> Thomas Ackermann <th.acker@arcor.de> writes:
> 
> > "git pull ." works, but "git merge" is the recommended
> > way for new users to do things. (The old description
> > also should have read "The former is actually *not* very
> > commonly used".)
> 
> It does not matter that you are unaware other people use it often.
> I'd suggest dropping the first hunk altogether.

Eh, the claim "The former is actually very commonly used." is
confusing on its own (even though it used to be true) and elaborating
wouldn't help much with education, so the first hunk makes sense to
me.  But maybe it should have been done in a separate patch. ;-)

Thanks,
Jonathan
