From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 13:40:34 -0500
Message-ID: <b4087cc50904201140n1e156583w28b5c411850d7d25@mail.gmail.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	 <m3eivnp5p4.fsf@localhost.localdomain>
	 <76718490904201127n5bd9836ak796792ce3cfd18a6@mail.gmail.com>
	 <76718490904201132h3932e6dan3b1c0d841bd3cf00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:42:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvyRb-00065m-1l
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbZDTSkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 14:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbZDTSkg
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:40:36 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:60968 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbZDTSkf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 14:40:35 -0400
Received: by qyk16 with SMTP id 16so320401qyk.33
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2g38G96HtYvQh/3q+MolGZe1DyJvZ7G0f6Lt+U87x0U=;
        b=hzQ6pwhxpDEHYYGFc5CUZQ4ljbDl5Hkx8FIld7wlA6tphnueDdmsnLujjAruzSaU+7
         fx4Ydt46vETcpkbmUQqdvO2m0g+1oVBMV4lrXNV3nbkF1AgFtyc33aeO1Fp1B4XPTZS+
         d4b2RE/x4a0r0lH7y8cV70AwzTDj7EjxeUL+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=plkwqAe41zSUnLj6sk62/hLKwWK6WIbi4KJv2fQ2f0SXWaXHBDpkQ9Fg0ml7Bry6iP
         zxCjyGvvoUJ+O31Otl53hIgtaCdTRSYNwYNL3nmUZz7C3UcNF0A9KCha03RPVBCzHy0P
         x1JJ6aWrJlrR3QRO5dlfr9KxYcVWJJzzhHC8A=
Received: by 10.224.32.66 with SMTP id b2mr6658635qad.8.1240252834370; Mon, 20 
	Apr 2009 11:40:34 -0700 (PDT)
In-Reply-To: <76718490904201132h3932e6dan3b1c0d841bd3cf00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117019>

On Mon, Apr 20, 2009 at 13:32, Jay Soffian <jaysoffian@gmail.com> wrote:
> Anyway, I see that there are basically a few categories to decide on:
>
> 1) gitweb
> 2) the *.perl scripts
> 3) Git.pm
> 4) the parts of the test suite that use perl
>
> I think there is consensus that (1) is 5.8.1 for unicode reasons. (3)
> and (4), for all practical purposes, are apparently 5.6.0. So that
> leaves (2), which is either 5.6.0 or 5.8.1 depending upon which gmane
> thread you consult.

It looks like 5.6.0 was released a DECADE ago. Drop it.

My advice is to take the advice of Perl hacker H.Merijn Brand:

> My personal preference for the lowest usable and reliable perl version
is 5.8.5 (FWIW)
