From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: How to force explicit user info
Date: Wed, 5 Mar 2008 15:48:18 +0100
Message-ID: <8aa486160803050648v2fe2bfwb0711e81b162cba3@mail.gmail.com>
References: <8aa486160803050539p4c443302nc322241d59fe9374@mail.gmail.com>
	 <alpine.LNX.1.00.0803050943070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:50:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuvU-0004gj-Nu
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYCEOsW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 09:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYCEOsW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:48:22 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:9071 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYCEOsV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 09:48:21 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1925982tif.23
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 06:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7H/YjIFMcHPwkKvqRaOuWJcz5QCVHx5/3mqTm5tNkZo=;
        b=YRzAvi2kJOIU0MFaK9rQqGiz2d2YEs2mWA6AF7+/pfmCtHN+0Ia4f8Ykgdck2BjGY8d+mHhwBXGZoqmGqQ+ZetcZdpszbF8Wjlyz1cbTazTNlRtSaJNfGEr/4embmurPk3waekQ75X3uXeDm5OVEA1YeXC+DUW8Qy7T+Hwmelqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I1wsQDrgSBGWIoWnf0i9UdOnwCMONg/+Itjs4IvQuIx362tmrtJPy4ZqXnpIBos3qcOX7v/8jK5x1OwZpjp9/ZRQZnnWRIbNaIPUVPGb0nBewGHdBk9/xb83VfwmYpOZj4kEDlVVAtr0OgzvLzE1YHOGbIlqfb8yrh8xRMA4ds4=
Received: by 10.151.82.3 with SMTP id j3mr1226553ybl.78.1204728498022;
        Wed, 05 Mar 2008 06:48:18 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 5 Mar 2008 06:48:18 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0803050943070.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76225>

On Wed, Mar 5, 2008 at 3:45 PM, Daniel Barkalow <barkalow@iabervon.org>=
 wrote:
>
> On Wed, 5 Mar 2008, Santi B=E9jar wrote:
>
>  > Hi  *,
>  >
>  >
>  >   how can I forbid the gecos info and always force git to ask for =
an
>  > explicit user.name and user.email?
>  >
>  >   I use a different email for personal projects and for work proje=
cts,
>  > using the same machine. So I set user.email locally in each
>  > repository. But when I forget setting this I get
>  > userid@hostname.(none) as the email. Is there a way to just die an=
d
>  > ask for this info (maybe user.AlwaysExplicit or something like tha=
t)?
>
>  It doesn't work now, but I think a global:
>
>  [user]
>         name
>
>  Could usefully be made to disable the default.
>

Yes, in fact I tried it. I think it makes sense as a way to disable
the default name, instead of another config option.

Santi
