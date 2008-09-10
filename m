From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 1/3] Auto-generate man pages for all StGit commands
Date: Wed, 10 Sep 2008 22:56:55 +0100
Message-ID: <b0943d9e0809101456w3c74b86fm9d311fb2594bcf4f@mail.gmail.com>
References: <20080908210302.1957.44280.stgit@yoghurt>
	 <20080908210758.1957.664.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdXhP-00008B-MR
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 23:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbYIJV47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2008 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbYIJV47
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 17:56:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:19431 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbYIJV46 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 17:56:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so27982waf.23
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QR7SpASr8FHcxbIyB1+qYhLgEgIqg2jn8sj0yiBgTAQ=;
        b=UhlGrmOhM4hd4mvOyTmyz+KDfa5A2sEpDNJ+N1KncMZsfJdQcUmENUmSr0PlrtTJvf
         sJsxrGIhnka3lhQ1MRtXLnOj0rDedf/ptfPaJwLB0rBmyeN+v4W0fF9U0VaOxqpRFtty
         Cj2KjZm7Uc88WBWKEr/zIm4GdLCGy6K36XRzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bt6HgcpSx7hBxl7jgqCrF7WWPGpzAf3WHLUISvzpIANG9rBeVgGTxwZhrvspi7x2g1
         c7OuBPUn1SEGOKZOkr3AErtTUubXw/ROIv+FpQoDrgRYvU086gv+p09QBLEQL3G7AWVB
         4YA9PFld/xmYWwxpqxBWsN9B8INv07Ii2TKbM=
Received: by 10.114.25.3 with SMTP id 3mr1355923way.22.1221083815892;
        Wed, 10 Sep 2008 14:56:55 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Wed, 10 Sep 2008 14:56:55 -0700 (PDT)
In-Reply-To: <20080908210758.1957.664.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95561>

On 08/09/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Auto-generate man pages based on the docs that are in each
>  stgit/commands/<cmd>.py file. That doc format is extended in order t=
o
>  support both brief command help output and manpage text.

Really great stuff. Thanks.

I can see a slight difference in behaviour but I don't have any issue
with it - previously "stg help <cmd>" showed the full description
while "stg <cmd> --help" only the short one.

An additional point on naming - should we use StGIT or StGit? The
original name was StGIT since GIT looked like an acronym. It looks
like now more people name it Git hence our tool moved slowly into
StGit but not everywhere. I personally like StGIT but the last 3
letters should really be the same as the official git (Git, GIT).

--=20
Catalin
