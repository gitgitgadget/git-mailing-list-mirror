From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Mon, 29 Aug 2011 03:13:46 +0200
Message-ID: <CAGdFq_hC10YgV2Cf_ZSu5LvyFxV6wq1atx9q4kFsP8zQpii9YA@mail.gmail.com>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
 <20110308024427.GA21471@elie> <20110828162325.5f479ef7@fenix.utopia.dhis.org> <20110828233931.GD29351@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 03:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxqRx-0005Iz-1U
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 03:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696Ab1H2BO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 21:14:28 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64181 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1H2BO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 21:14:27 -0400
Received: by pzk37 with SMTP id 37so7568928pzk.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 18:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OqyDARjmhKbKA4uXJGNciRmzxKhYUcnKykzzvwJ9JQs=;
        b=aXpkVRHhvHkQnkgyaz5sm6ZKoeJsO/1dR3nrPEDpA/WN0h/8MS9hZqxisjruHKfS8l
         8TtAXrHt8owYODMMamFd5eIg9JtmQwOEScZ/Gwxjag+6dP0l8pkXb6YR9H8KLa363Rmj
         eEwbEKkS+RUwLoxlwnoVWMG9xBOjoaM9Gtbbo=
Received: by 10.142.52.4 with SMTP id z4mr2093621wfz.437.1314580467116; Sun,
 28 Aug 2011 18:14:27 -0700 (PDT)
Received: by 10.68.55.170 with HTTP; Sun, 28 Aug 2011 18:13:46 -0700 (PDT)
In-Reply-To: <20110828233931.GD29351@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180289>

Heya,

On Mon, Aug 29, 2011 at 01:39, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Vitor Antunes wrote:
>> Is there a way to manually force fast-import to drop an old commit that the
>> frontend script decided it was no longer necessary?
>
> Sure --- patch fast-import (I'd be happy to review such a patch). :)

That's actually a feature that we need for remote-helpers as well (to
be able to drop refs). Would be nice to have a 'drop ref' command in
fast export :).

-- 
Cheers,

Sverre Rabbelier
