From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Looking for a way to turn off/modify ref disambiguation
Date: Wed, 24 Aug 2011 11:37:47 -0500
Message-ID: <20110824163747.GA9184@elie.gateway.2wire.net>
References: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
 <7vei0brdiq.fsf@alter.siamese.dyndns.org>
 <4E54C373.1070702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 18:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwGSr-0007BO-Te
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 18:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab1HXQiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 12:38:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54950 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab1HXQh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 12:37:59 -0400
Received: by bke11 with SMTP id 11so1035991bke.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h78VKGiV+Z+0Jplio8w0+P69f7P+Bb9DP/Q987yMvH4=;
        b=DOpt9r0fdEcJajjKl5IqEVkpJh1/cB1WC5ANVR+HFZOnd2I3znI4rMK+ythiz46C/w
         B3VsACSgNfdcTGkREoEmxp9Xw5IHRZho7uoreexDkVDCHnqeldsIpor1l+EqgtJ5buiT
         2chYqycO89CzB2n89p8cJtj4KnIx97r4I5Vc8=
Received: by 10.204.142.144 with SMTP id q16mr2326600bku.267.1314203878269;
        Wed, 24 Aug 2011 09:37:58 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-73-45.dsl.chcgil.ameritech.net [69.209.73.45])
        by mx.google.com with ESMTPS id b17sm344082bkd.65.2011.08.24.09.37.55
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 09:37:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E54C373.1070702@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180016>

Michael J Gruber wrote:

> "@{u}.." does that when you're on the branch in
> question, and we have no notation for "@{u(master)}..master".

"master@{u}..master" works, though it's not very short.
