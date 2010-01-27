From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-tag -s can't find GPG private key
Date: Wed, 27 Jan 2010 22:06:00 +0100
Message-ID: <fabb9a1e1001271306o7e6d9abu1f370ed4698ac055@mail.gmail.com>
References: <4B60A9F0.5000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 22:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaF5m-00068D-EW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 22:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832Ab0A0VGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 16:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825Ab0A0VGV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 16:06:21 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:37254 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab0A0VGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 16:06:20 -0500
Received: by pzk28 with SMTP id 28so2251607pzk.4
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=dxwuKpIqdKaUDD/dXOWhS3EYds4NxrYyBpkG4W6FpM0=;
        b=MAUNm2NVIaBhJrme8VbdCn7DVRGEdRjhmPrNCJQo2UzVInzD1WpvoW7+GTNxLjDtdE
         3JsHGLnTflB69qE24eKEKF1PVrbCxdxc1UCTXABsf8+Oe2i8e/5ayS94AIoG9clwuXWy
         DShA4qKGqpNZtnuhAqz0y6vaANiXF2VgW2bcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZfJluXh9Fc3yctUFGdW2B6kGbjG0JHv8tuEt6A1tGSjUaUa+497vqJ0iucol5iKO54
         fNmIqCcmRIeBsHWw4R/tNe7wHrLj8XqZDbhq0bWySrPShssqrkzSf7LgrA8G94f8dlsZ
         CC2Am6iZSvoQNSb2LAOpuXzLyH/Wp5PYqJGA4=
Received: by 10.142.61.23 with SMTP id j23mr596840wfa.322.1264626380086; Wed, 
	27 Jan 2010 13:06:20 -0800 (PST)
In-Reply-To: <4B60A9F0.5000904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138196>

Heya,

On Wed, Jan 27, 2010 at 22:02, Mike.lifeguard <mike.lifeguard@gmail.com> wrote:
> It seems that when the GPG key name and user.name in git's config are
> different, git can't find the appropriate private key to sign the tag.
> Git should attempt to use user.email to find the key. Setting
> user.signingkey is of course a workaround. The relevant code would be in
> builtin-tag.c.

It seems you already know where to look, why don't you try and come up
with a patch since it is indeed, your itch to scratch?

-- 
Cheers,

Sverre Rabbelier
