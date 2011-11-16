From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 15:34:09 +0800
Message-ID: <CALUzUxrM8o1uahQgSFUuvZ0mSPxG_zVQ9awOantRM2A8kkbbtA@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
	<CAJo=hJvdstr39suGMwxNoT+_cKThxsEYHi96eqja7HuHyPmhWA@mail.gmail.com>
	<7v1ut9uglb.fsf@alter.siamese.dyndns.org>
	<CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 08:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQa0e-0001gH-64
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 08:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab1KPHeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 02:34:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57725 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1KPHeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 02:34:10 -0500
Received: by bke11 with SMTP id 11so204606bke.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 23:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n5vBq9fyhSHLv25MohkL9/QSFsfmuEiWZawRcRU/HX4=;
        b=ApZqPWCU2b2h5a5cBwPaGVfdIFqJ1/dsEaklwe0pmqBZsSXcgCO7+oDwSVix4l6TUz
         Ep1mkdqJ5ak6N6jugfcxspjer0ic1cKYfmUbuX4Z3u49N0rzdRCp4FTZWLyhipY8zocY
         tc6yxRxVZ9WmOVGENHyN57AZdIwsuvtgErkCk=
Received: by 10.204.152.196 with SMTP id h4mr27219244bkw.1.1321428849304; Tue,
 15 Nov 2011 23:34:09 -0800 (PST)
Received: by 10.223.71.206 with HTTP; Tue, 15 Nov 2011 23:34:09 -0800 (PST)
In-Reply-To: <CACf55T6SRAfdOP1+qQdjeFv13B=G8w+DR-GCSEz=6swFhLJzcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185518>

On Wed, Nov 16, 2011 at 3:11 PM, Dmitry Smirnov <divis1969@gmail.com> wrote:
> What if problem is caused by curl or TLS lib (libcurl-gnutls?) which
> is used by my git? Is there any to log something from git-remote-https
> ?

You can run git with GIT_CURL_VERBOSE set, like this

  GIT_CURL_VERBOSE=1 git ls-remote ...

-- 
Cheers,
Ray Chuan
