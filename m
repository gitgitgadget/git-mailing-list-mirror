From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: multiple files for the same hook
Date: Tue, 13 May 2008 20:05:44 +1200
Message-ID: <46a038f90805130105p67fa2081p2537db29305a6231@mail.gmail.com>
References: <200805122039.49779.hto@arcor.de>
	 <20080512204445.GT27724@genesis.frugalware.org>
	 <200805122156.30896.hto@arcor.de>
	 <20080513042118.GB4079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Thomas Hunger" <hto@arcor.de>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 13 10:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvpWw-0003Cp-HV
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 10:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757741AbYEMIFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 04:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757355AbYEMIFr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 04:05:47 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:54584 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213AbYEMIFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 04:05:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so549676and.103
        for <git@vger.kernel.org>; Tue, 13 May 2008 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NC+B3qvAoYtYTTKK6MlJI1+oY28gLFN/YUasqxr0lio=;
        b=jc6faBZIknyKoPDHdNlrUu2Y7jQoe6hXxtcKlucw3hqYLat0t2ecm+9sS1PFBPOneep1bI/Ji3rV6ETW6CHzcTD0JNbvWl7Aj/0lpZPGRlzrT0cfxwDKZQobtSXYiOamhfh4FINSx8nAbrzaIKXpqIuWk39rwafAX7UDXrkodM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uU594cO0neyzlhZDW0w+X8m4quf2RwcH2c9Mp3QPdHQ6ftFR5kIIRX8BZrADOs1hULwWL7rojQbrn+mZW/b2WJBmCzlhakUmK5i3ZyG4Odn2+gs4IjpnqKF/m+/gx5jKw+GGaiRICDmqWeQswj7iPMzHFb2bHI01gkhIOna8eCg=
Received: by 10.100.12.1 with SMTP id 1mr9345748anl.22.1210665944845;
        Tue, 13 May 2008 01:05:44 -0700 (PDT)
Received: by 10.100.250.4 with HTTP; Tue, 13 May 2008 01:05:44 -0700 (PDT)
In-Reply-To: <20080513042118.GB4079@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81998>

On Tue, May 13, 2008 at 4:21 PM, Jeff King <peff@peff.net> wrote:
>  In the meantime, it probably
>  makes more sense to implement a "master" post-commit hook that uses the
>  semantics that you find useful.

And when you are implementing those semantics, you might be able to
reuse "run-parts" which does roughly what you want.

:-)

cheers,



m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
