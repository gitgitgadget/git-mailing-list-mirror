From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Copying files and keeping the history
Date: Thu, 11 Jun 2009 20:29:47 +0200
Message-ID: <fabb9a1e0906111129x53a6d90p15a97d958a2d2f63@mail.gmail.com>
References: <18567.1244726405@zev.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rgenH=E4gg?= <jorgen.hagg@axis.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 20:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEp2h-0006K5-UN
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 20:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757057AbZFKSaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 14:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756978AbZFKSaG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 14:30:06 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41638 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372AbZFKSaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2009 14:30:05 -0400
Received: by ewy6 with SMTP id 6so2263879ewy.37
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AnuI9EWl2dI06Z7pzgxt9hpoCTH/aeDR2o3OvyFXtPM=;
        b=ZepcSW0H0otiZs3XWHPrztCxUN7YeQTfDzRfuWfoX+KahcAsjCaj5QwiGXMWP7JtNG
         YXx3JkJl0Yzus1pDpKcQCkWteL8XeDod+EAYvGaGqCnxkNkD9if8+15KBqpSH9/0UcQk
         E77UNfF1DuEMKIop44fy5fal6xb4Fcp7tQlmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Win0JPfWSrWZ9QPvva2PbvrIUnSE6ZYANc4xM2GIMMPzItRHdYfN9rfhggO3eN2W5W
         +hpkbVZkF7r40a7xaTp8gxJFJbYy0AlsOH405q/lQKwS39dlfk7ewVCQWG7F/GdYegdN
         p4HoYEkQQ1pHUoSytEtW3L0RSTQZkLnOiZZsw=
Received: by 10.216.11.212 with SMTP id 62mr1020813wex.186.1244745007125; Thu, 
	11 Jun 2009 11:30:07 -0700 (PDT)
In-Reply-To: <18567.1244726405@zev.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121355>

Heya,

On Thu, Jun 11, 2009 at 15:20, J=F6rgenH=E4gg<jorgen.hagg@axis.com> wro=
te:
> Is this somehow possible?

Try git filter-branch to get just the commits you want and nudge them
to contain what you want (do this in a seperate branch/copy of
repository A). When you're done, pull the branch into B and merge it.
Instant win?

--=20
Cheers,

Sverre Rabbelier
