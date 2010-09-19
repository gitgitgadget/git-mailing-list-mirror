From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] use cache for function names in hunk headers
Date: Sun, 19 Sep 2010 22:24:52 +0200
Message-ID: <AANLkTikArADX8XviB99VtkkmKmVbs9jHPHw9PNSmiOc3@mail.gmail.com>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at> <1284890369-4136-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Sep 19 22:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxQRu-0007Ic-7o
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 22:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab0ISUZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 16:25:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46348 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab0ISUZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 16:25:13 -0400
Received: by ywh1 with SMTP id 1so1141936ywh.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9bcWmj4hugGiFES5dN6gmGWEpZZBalhyfAn0ZcLkGO8=;
        b=vEzxh5Qqhto0AFhDVfg7RpVGpzdbyeFsp0SaM2IN0RrP4dkyLD6XcxZAeDmQ0DMmiX
         aMfdP3FHxLTgzhzAXZZc7ezzfKKqWzaiGpstlPdGul3I6hy+qwKvMelZyrr6BSShjXz+
         F2upmfrEy7J2PVj35a7lAjgVLqGw3FXv9cs5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TrO1wba8+Nq/AIe/DuurX/Ty3YBi30P6XRurbap36IEpWoGeL3uV9p8vGPpjYvYAlI
         BRM3Pi2AmFo4D2SVSuKiov0A+g1GuHy6SdAT73YUJURG17esdQuZuYzLw4HmbPy10A4a
         taAAXxo631O08a7SND2GECaB9OqAGOVeN/USU=
Received: by 10.150.181.15 with SMTP id d15mr8412234ybf.241.1284927912342;
 Sun, 19 Sep 2010 13:25:12 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Sun, 19 Sep 2010 13:24:52 -0700 (PDT)
In-Reply-To: <1284890369-4136-4-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156515>

Heya,

On Sun, Sep 19, 2010 at 11:59, Clemens Buchacher <drizzd@aon.at> wrote:
> 2.78user 0.01system 0:02.82elapsed 99%CPU
> 0.05user 0.01system 0:00.06elapsed 96%CPU

Very nice. It would improve the commit message if you could explain
what exactly it is this optimizes though, saving the reader from
having to read through t3419 to find out.

-- 
Cheers,

Sverre Rabbelier
