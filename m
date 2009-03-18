From: Matthias Nothhaft <matthias.nothhaft@googlemail.com>
Subject: Re: submodules inside submodules?
Date: Wed, 18 Mar 2009 11:28:30 +0100
Message-ID: <978bdee00903180328n7610ab5csa5cd6c8d0f4fc65b@mail.gmail.com>
References: <978bdee00903170907g4cd02b01y971d378295787d50@mail.gmail.com>
	 <alpine.DEB.1.00.0903171734330.6393@intel-tinevez-2-302>
	 <200903181046.54556.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 11:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljt7G-0008Jj-91
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 11:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZCRKdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 06:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbZCRKdt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 06:33:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48428 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZCRKdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 06:33:49 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2009 06:33:48 EDT
Received: by fxm2 with SMTP id 2so426435fxm.37
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0Rr2P0RSGzCN57CktX9TN29C7PZljjnruSrTt8Rhs6E=;
        b=sM0KDwCJFO/uREr3nTBAj2Ec6lfw6dqDATBJQCSlzsKdwo4OLO9qxGvJHtCKAGntI/
         nLDNKfbrgvlzMQfYm6RER2FeFOmvEC+wnm3VZz/VhWvWh2qkF347IOmA1mZ9zWEdF5DS
         L43yTaiop0RXnM9gEw8VItUnzzjWliWzwW1J8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u61q06n3mqCJ8Fvip3TZAFqhJR0g3wcIRajwXP8i3JL+zRps5UcRr6o9GupvfuH6Xc
         kQDLq1ETwfg+U8P3Z10RWQCZ5HCwBLW9AyzvgxRA47TAAe8/49vfKDCvLlr2BdHccqEs
         VqD/nTkDvW+3Q64SYn35ngqfwu1eVjJSbex7A=
Received: by 10.204.52.130 with SMTP id i2mr86874bkg.176.1237372110458; Wed, 
	18 Mar 2009 03:28:30 -0700 (PDT)
In-Reply-To: <200903181046.54556.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113608>

2009/3/18 Johan Herland <johan@herland.net>:
> On Tuesday 17 March 2009, Johannes Schindelin wrote:
>> On Tue, 17 Mar 2009, Matthias Nothhaft wrote:
>> > can I put submodules into submodules?
>>
>> Yes.
>
> However, initializing them is a bit clunky, as Git will only init/update one
> "level" of submodules at a time. In other words, a single "git submodule
> update --init" will only intialize the first level of submodules. You will
> have to redo that command within submodules that have their own (i.e.
> nested) submodules.

Oh, thanks for that hint.

regards,
Matthias
