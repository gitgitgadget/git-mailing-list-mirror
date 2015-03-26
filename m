From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for
 XDG_CONFIG_HOME
Date: Thu, 26 Mar 2015 13:20:42 +0800
Message-ID: <20150326052042.GA20689@yoshi.chippynet.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
 <1427174429-5876-3-git-send-email-pyokagan@gmail.com>
 <vpqbnjivi2n.fsf@anie.imag.fr>
 <CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com>
 <xmqqwq252grl.fsf@gitster.dls.corp.google.com>
 <xmqqr3sc25b0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 06:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb0Dr-0007w4-F7
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 06:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbCZFUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 01:20:47 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35498 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbCZFUq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 01:20:46 -0400
Received: by pacwz10 with SMTP id wz10so1111450pac.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 22:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6Pj8kc34IfQqJb/74H6BnIjNgjOuXaU0wtaPmtaNfaw=;
        b=kRZmEpqnFZPDWyju7QUB5Y170gP9Vsz0dAG6Z3O1zssMdDo0lCf8rfYPGpml4xP5Wx
         jrtilEu/ifpBkVZa6oESQd7tLT3nUq3WSR7ZisSfxOmNUM7oHW/xHKBJLh6qM2xNp6Ou
         4yMMcYypdT4vPLxeZi+MiuSCfvcHTKYjCJxx82PF9IkFBFJDsjyHhnD9PvfDw43amON4
         S5PrRkqKIlXUKnwU0hL13KVerAUeyACsri0Ouzf+CPFi0mRdrtYK6kzID841j7KfvzEA
         w6HeVr2CdBnYGZKXv2aLldLWvbliFGCc2mKCrTuSZ5Ws/mhN0jwPCXcXo5BzPBm1mvcb
         SITg==
X-Received: by 10.69.0.106 with SMTP id ax10mr23435655pbd.11.1427347246478;
        Wed, 25 Mar 2015 22:20:46 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id ap4sm4150819pbd.2.2015.03.25.22.20.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 22:20:45 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1Yb0Di-0006sb-IU; Thu, 26 Mar 2015 13:20:42 +0800
Content-Disposition: inline
In-Reply-To: <xmqqr3sc25b0.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266313>

On Wed, Mar 25, 2015 at 01:25:07PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> I've already queued the following and merged it to 'next'.

Thanks Matthieu and Eric for your reviews, and Johannes for following up
on this.

Will keep in view XDG support for ~/.git-credential-cache next because I
don't like to leave things unfinished, unless we want to keep it around
as a microproject. Perhaps home_config_paths() can also be
simplified/removed because it hardcodes '~/.gitconfig'.

Regards,
Paul
