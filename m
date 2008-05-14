From: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <nudrema@gmail.com>
Subject: Re: Using git from Python
Date: Wed, 14 May 2008 08:10:05 +0200
Message-ID: <f35478f50805132310p2b94b128o3a6f391849ffb8ec@mail.gmail.com>
References: <alpine.DEB.1.10.0805071612510.26718@sf.creativecommons.org>
	 <9b013f14-c193-41bc-923f-5f9a09d4fd60@56g2000hsm.googlegroups.com>
	 <alpine.DEB.1.00.0805121116560.6810@swallowtail>
	 <f35478f50805130039s6dfe9411j63411f2f7a7db6c3@mail.gmail.com>
	 <20080513205021.GI2592@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Todd Zullinger" <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 08:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwACX-0006qS-UJ
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 08:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYENGKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 02:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbYENGKI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 02:10:08 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:58878 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYENGKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 02:10:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so651308and.103
        for <git@vger.kernel.org>; Tue, 13 May 2008 23:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0TW3WlSiyTWpeUWgv9PcS7tMy3CBTo3n0lkv0LX+jT0=;
        b=FCsTinQcX1O/Zs6iKjK8xbTY9OK83pAfHACkKWvSO5tIo41wUxhX1nVSdJg0MyvoUo9zFhIXNqG5BvInn38FhcZLQooVDRNXiFm7BEBca8C7l4f7/3rDL1st7hmpMeRLj7XXdsIb58vAnfu11lfbYPyc6RDZCLjnPk3s4n4V+So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lNNlckL4GMWon2PlGQ0G02mZaI12wITWt6dHRoTFSGm27q8gxHArYJxxA6x/pX8qvoyO0s4rbYGpvbgOb6d0DKQvRjwFQ+HYahtF2EiSzieZoWjgAoh3v5xTs+r2TRL0bo5MS/NPpbuu10uny8BMgtGn3wVjcsrwIsXQOoW6fpI=
Received: by 10.100.92.9 with SMTP id p9mr645278anb.124.1210745405610;
        Tue, 13 May 2008 23:10:05 -0700 (PDT)
Received: by 10.100.45.13 with HTTP; Tue, 13 May 2008 23:10:05 -0700 (PDT)
In-Reply-To: <20080513205021.GI2592@inocybe.teonanacatl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82078>

On Tue, May 13, 2008 at 10:50 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi Steve,
>
> I saw that you started some python bindings for git and thought I'd
> take a peak (even though I don't have a need for such a thing at the
> moment :).  I notice that the COPYING file is GPLv2, but the comments
> in all the files say License: LGPL 2.  Which one is incorrect?

Mmh. The LGPL one. I think I've copied the wrong file in and forgot to
double-test ;-)
