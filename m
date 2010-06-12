From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 09:50:21 -0500
Message-ID: <20100612145021.GA1406@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <4C1371CE.8010309@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 16:50:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONS2m-0007qI-SP
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 16:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab0FLOuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 10:50:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63282 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0FLOub (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 10:50:31 -0400
Received: by iwn9 with SMTP id 9so1513843iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b0f9oce+6HZcwnwCM1jTI6kJgh03mklcwgeyXo9qhDc=;
        b=SejFEnOOhJNeU7SXHZW6MAd/BrZizcygwWY7fRbi20q7cOwRDemM/RICFXxJSaC2MR
         Va2CeOcOCstQbachH55nfxxEgY4J+JAhaip+xRCm4mtO8ruzt2g62YgVxBLrlSlpZiqC
         pp6osho1tO6Mljjgdpif5636jQiRA+tedbN/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DSaetakQFTrbsNeiPgicbuxqm/tkEwJGYZILOkPOR+nKByqL1dmOpuAhVi6K90uvTf
         Dm39ZIUT43jeGFhLZoEHnMny1lFSUnaGBVr7qBD04pVVWG45fz4aHx7G4eyHqrMfWi+i
         FFFzgPXVU7ykblYi+h9pyFh2XcSY8bX1xyRQc=
Received: by 10.231.213.27 with SMTP id gu27mr3350384ibb.168.1276354230859;
        Sat, 12 Jun 2010 07:50:30 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm10730829ibl.16.2010.06.12.07.50.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 07:50:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C1371CE.8010309@gnu.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149008>

Paolo Bonzini wrote:

> Just a nit, why not just "--open-files-in"?

I assume it was to convey the default.  The effect of
"git grep -e foo --open-files-in-pager" is more obvious than
"git grep -e foo --open-files-in".

But I do see your point.  I have no preferences about what the long
option is named.  Care to prepare a follow-up patch?

> I'm asking because I would like to add this option to GNU
> grep

That would be nice indeed.

Thanks,
Jonathan
