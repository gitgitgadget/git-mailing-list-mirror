From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: [Q] Tell Git to follow symlinks?
Date: Sun, 24 Feb 2008 21:22:49 +0300
Message-ID: <c6c947f60802241022l53ef344es10e23e1cf9b7116a@mail.gmail.com>
References: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
	 <87zltq2xzn.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Remi Vanicat" <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTLVg-0000nI-MB
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 19:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYBXSWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 13:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbYBXSWv
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 13:22:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:16576 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYBXSWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 13:22:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1460116wah.23
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 10:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4O0a0sO3PorrCOcuMOeY8Dxd9HAfoWXnzlfxnJYUV5w=;
        b=iE4PAfewPysIaFmObv7DgtMDBtTPlH404sILjKmtp8OdknNpr1cPmgZCPBFFReYTcvYf0ddMs5Kt95EmrF5cyo8L2B42U67WbC3uQcppdtNMK463SPBWytsfRmrdt8L5Bti4cNwjN5Xmuun3EtZ5Lg+1W/3bJvtBAK/TNbLWo50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=u0Z6Ka+UnVPgzQltvaTj8lvvvEHwsxj3JF3SQLpEOgQmsihXnglHlpDnrT85uNHh4dBH4sjVfShLwOMdvqDUxllzBRoH6Udf0ZP+S4w4TvXvPHUWMDxf4pCrBEK7HYKQrDRaLciFfliQONjPoSB3QgC9oPbW4bYKv0YChiFUQtU=
Received: by 10.115.74.1 with SMTP id b1mr2260390wal.93.1203877369729;
        Sun, 24 Feb 2008 10:22:49 -0800 (PST)
Received: by 10.115.109.14 with HTTP; Sun, 24 Feb 2008 10:22:49 -0800 (PST)
In-Reply-To: <87zltq2xzn.dlv@maison.homelinux.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74952>

On Sun, Feb 24, 2008 at 6:08 PM, Remi Vanicat <vanicat@debian.org> wrote:

>  > I thought to construct my repo of the number of symlinks to other
>  > places, but apparently Git does not follow any simlinks.
>
>  Hope so, I use this feature, for example to manage my debian
>  alternatives.

I do not advocate removal of this useful feature, but may be there are
some arcane switch or even a simple source hack that would help me in
my specific case, :)

>  > Please give me some directions on the building such dumb backup
>  > system I want :)
>
>  I use "reverse" symlinks: the files i want to manage are replaced by
>  symlink to the file that is in then git repository:
> <...>

Yes, this is an option, thank you. But it would involve altering
existing software configurations (like enabling FollowSymLinks in
Apache etc.) -- which I would like to avoid if possible.

Thank you,
Alexander.
