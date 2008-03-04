From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-submodule - Allow adding a submodule in-place
Date: Tue, 4 Mar 2008 07:39:44 -0500
Message-ID: <30e4a070803040439o7b3453c9ta3f00a6d1115af86@mail.gmail.com>
References: <1204596383-4040-1-git-send-email-mlevedahl@gmail.com>
	 <7vod9v9d9b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pkufranky@gmail.com,
	"Sven Verdoolaege" <skimo@kotnet.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:40:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWWRW-0006Jo-Bq
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881AbYCDMjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757600AbYCDMjs
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:39:48 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:31555 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135AbYCDMjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:39:46 -0500
Received: by wf-out-1314.google.com with SMTP id 28so966717wff.4
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 04:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l5B0WURqWj+Pc5q3i3048IhJFX/OMpv9z4eo/Yp0BcM=;
        b=UR8UDga0EHpPt3zNtlGoiOFHQwCwX4VK38gcVi1IjyF5YNMTSCZI/nzNrRa1xPWz0CUxtDavwWBqbXbKP0eBLe7a6IpJRPOjbPt8H6ZfXs3TDJmcowxXAyNbk+YGRvfU0Vf4po3DbRK3SDkJVEogHBJfzve5iRNErNr6VV7Opj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tYYt6qUJ7aqRvEOYWjf0hiIinvlNsa9MxSok1r0jtDkH8DwlFNH/iGX2pkhPwc/4OBuOdDMN7SZ/Uv6oNbJl7UI8zMzCMWvOAGzXy4VJNO7IdMDXDfGXcdBnDeQFwpj/XYKEGFdSCW7cHI2bfx90QddPz9pQkdXWdno2ME32fEI=
Received: by 10.142.127.10 with SMTP id z10mr493316wfc.216.1204634384089;
        Tue, 04 Mar 2008 04:39:44 -0800 (PST)
Received: by 10.143.159.5 with HTTP; Tue, 4 Mar 2008 04:39:44 -0800 (PST)
In-Reply-To: <7vod9v9d9b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76081>

On Tue, Mar 4, 2008 at 2:09 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
>  However, this part is not mentioned in the commit log message at all.

...because the code to do the latter part is not a part of the patch,
and I failed to edit the documentation patch to remove that other
cruft. Will resend tonight when I have a connection that lets me send
patches.

Mark
