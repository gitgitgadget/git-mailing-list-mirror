From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Feedback on native Win32 git from a Perl perspective
Date: Mon, 23 Jul 2007 07:48:15 -0300
Message-ID: <46a038f90707230348x7b107568vb680cb089645cb61@mail.gmail.com>
References: <46A06C7F.5010601@phase-n.com>
	 <46a038f90707200632u1ce762c1i70eb1586e2542256@mail.gmail.com>
	 <46A4337E.2090303@phase-n.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Kennedy" <adam@phase-n.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:48:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvT3-0004I4-Va
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbXGWKsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754849AbXGWKsS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:48:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:20428 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757539AbXGWKsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:48:17 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1451752wxd
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 03:48:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mSZo+IM3Bfp36WRgh8Dty23lslb+khNz8R1XtGY29gkdcGelNIZXDgjDR3Gq9XBVv4PYYEfBkIjKbBPxATtoecjRCQ6RnLRH7+6J2gloVFHEtL/y34O7iGAPoRWALKMHImqR3K5PDInhjmW9IiKmLSeUEyAET24u0o0LD4HZTjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IJNRnGIhERZSNcFwhPzWq+huKEu3UBWlS2mMMCGFF2LS37iB7puq1sf0gL3p0HOn0MRWfRt6lQbQ8I1wPSTP5tSPFHFylSEoFiX1goBDFS+c+kvQDQOBXw3AL8uXAZ2r1YA8ebrdKA5/V6lrgA7BkAUv8Thzs6voYXdTe/R9Buo=
Received: by 10.90.113.20 with SMTP id l20mr1630040agc.1185187695714;
        Mon, 23 Jul 2007 03:48:15 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Mon, 23 Jul 2007 03:48:15 -0700 (PDT)
In-Reply-To: <46A4337E.2090303@phase-n.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53426>

On 7/23/07, Adam Kennedy <adam@phase-n.com> wrote:
> The main problem is that on Windows for the most part there is just no
> concept of "first install $something" (be that a run-time, cygwin, or
> whatever).

Agreed. And then you get in trouble if the stuff you are bundling
conflicts with software tht the user has already, or installs later...

> For the Vanilla/Strawberry Perl installers (http://vanillaperl.com/) the
> approach we ended up with to get full toolchain functionality out of the
> box was to bundle a copy of the MinGW packages we needed, as well as
> bundling a copy of dmake.
>
> The approach ActivePerl takes is to not bundle any of these parts,

I was a longtime ActivePerl user. I remember the pain.

>From the page you link, you are shipping Strawberry Perl for the
simple install with all included cases, and vanilla for people who
want to package their own perl or get Just Perl.

Sounds like a good plan -- hopefully bundling minGW isn't too hard.


m
