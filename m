From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 10/10] send-email: --compose takes optional argument 
	to existing file
Date: Sat, 11 Apr 2009 14:38:06 -0500
Message-ID: <b4087cc50904111238s4f1fc8a7v79ba06eb6fb48cb@mail.gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-7-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-8-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-9-git-send-email-mfwitten@gmail.com>
	 <1239476908-25944-10-git-send-email-mfwitten@gmail.com>
	 <fabb9a1e0904111225x7a8915a4q78202f397f9dc971@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsj3F-0000Vk-In
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840AbZDKTiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbZDKTiI
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:38:08 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:35854 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195AbZDKTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:38:07 -0400
Received: by qyk16 with SMTP id 16so2963563qyk.33
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LdCp8cWFMOh6oPy598yaVKJ2acsmi/gf7aM2NyN2YwE=;
        b=qGaUoNaeA87VhtZAjiEPfLHn0LL0OnX6v6YKvHakJwhp/n49GFKep+rK+g/PmogpSJ
         ej01mumwmAJwSG+W6xLhoWpcrBMi/sCSO3hzCqwCA9fpc2siPTX0AeafyYC/Ro5+vYaA
         Dsmh/OjLhTNz2PVGnr0J6dWE+A2R4DswIXsM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MbSSBkcvHN9D/+Y1zIriJysBwkJJqnBG1syYxQ6Dnx8zICHgVFUgK1NXftN8WG8I9F
         U3U0Fxnux4KyH3Yprw7Mw1MW6l7TBNotaqE/9OWeAzQdvBwS7yBKtj1Qj0c+ZyKr9afS
         34fRIomppxlz5a0GHJda/CoM/ulrXC1Bj5VNE=
Received: by 10.224.37.19 with SMTP id v19mr4970682qad.70.1239478686376; Sat, 
	11 Apr 2009 12:38:06 -0700 (PDT)
In-Reply-To: <fabb9a1e0904111225x7a8915a4q78202f397f9dc971@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116336>

On Sat, Apr 11, 2009 at 14:25, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Ouch! Wouldn't it be better to abort instead? Allover git we abort on
> empty commit messages and the like, why not here?

I was just following the original behavior. I don't really mind either way.
