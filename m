From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 17:25:29 +1200
Message-ID: <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
References: <20070515201006.GD3653@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 16 07:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoC1G-0000KJ-1c
	for gcvg-git@gmane.org; Wed, 16 May 2007 07:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759891AbXEPFZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 01:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757252AbXEPFZc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 01:25:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:52259 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759891AbXEPFZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 01:25:31 -0400
Received: by wx-out-0506.google.com with SMTP id h31so72685wxd
        for <git@vger.kernel.org>; Tue, 15 May 2007 22:25:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQsK4xaKomfc2lhLOOetuWi+kul6QfoQoIL9AJw82OvvPFfq4H3EwzgdMmKLAbGB8WEtwmZxnBbXQvd0yM38JY2TWcuKfTtgV45QUyDwd3DQPGh8rv4RgqucQVBCpxDwVeqNw8Zl/kxxXqcOBSVgt3+MsaEcHHfKTrKK53/RlPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Njp4Z9jC6i/0uFHy4ae8qb7j4fpQlhbdrkNR/Gsp9O5etA26XfmSRlpmhCFAbCCZYbqScTqfxiSnVDvydqttvQn0RPHAeFjp0FkI1RJYpW/ZWtioaTJuZdAPUC535S+DSoELzd/+lS/pENrPiJtD5f7z8fBcbxlYgxnvamnQoCg=
Received: by 10.90.74.1 with SMTP id w1mr7370529aga.1179293129914;
        Tue, 15 May 2007 22:25:29 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Tue, 15 May 2007 22:25:29 -0700 (PDT)
In-Reply-To: <20070515201006.GD3653@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47410>

On 5/16/07, Jan Hudec <bulb@ucw.cz> wrote:
> Did anyone already think about fetching over HTTP working similarly to the
> native git protocol?

Do the indexes have enough info to use them with http ranges? It'd be
chunkier than a smart protocol, but it'd still work with dumb servers.

cheers,


m
