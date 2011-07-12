From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 17:21:29 -0500
Message-ID: <20110712222129.GA15994@elie>
References: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
 <7vaacj8jq7.fsf@alter.siamese.dyndns.org>
 <CAKPyHN0+BaPtrRMVrWCZQ2mbJQz_vxsOOsG4Z=Ksqc1RJvF1Ew@mail.gmail.com>
 <20110712182517.GA17787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 00:21:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QglKs-0000bE-6O
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 00:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab1GLWVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 18:21:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64947 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990Ab1GLWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 18:21:42 -0400
Received: by gwaa18 with SMTP id a18so2139987gwa.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gTVrrNh3Pi7OYV+a36dhdm4IhtW39lRlYiA5e4ciXu8=;
        b=vvz8PFiJv+C68gTAb6qv9GHts1c7onwzYOhIRjacXz7i8OdA9ALEesCfLV/qAM1vbd
         FYzKdmUxPxtBhSurfO9zeeTPN6dsZ6P3ummatOTTuXCj/ZP/kcwD9gOHTZxwc/t9D5yz
         /ae1AaKO8LQu+/h80fk+RZkNo0WGPvd8kG/h8=
Received: by 10.236.9.40 with SMTP id 28mr717935yhs.136.1310509300815;
        Tue, 12 Jul 2011 15:21:40 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id k8sm4341204yhm.31.2011.07.12.15.21.38
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 15:21:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110712182517.GA17787@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176986>

Jeff King wrote:

> I think I'd rather see something more syntactically explicit for
> resetting, though, like:
>
>   [core]
>     autoLogRef = heads
>     autoLogRef = remotes
>     autoLogRef = notes
>     !autoLogRef
>     autoLogref = heads
>
> (for that matter, I have often wished that "!autoLogRef" was boolean
> false, just as "autoLogRef" is boolean true). But it may not be worth
> changing the config syntax for.

Sounds worthwhile to me.  I've (probably irrationally) wished before
for an abbreviation for "bare = false", too.
