From: "Maxim Gordienko" <mgordienko@gmail.com>
Subject: Re: [GIT-P4] usage under Windows
Date: Sat, 1 Mar 2008 10:41:29 +0300
Message-ID: <96c268400802292341y5ac5f287yc5af7afe9aff983a@mail.gmail.com>
References: <96c268400802212244g7fd2de2bj6c1b7022885c8e89@mail.gmail.com>
	 <47C5E4EC.1060003@trolltech.com>
	 <96c268400802291048u31a2d8b6ub1726ade941afb8c@mail.gmail.com>
	 <47C87F1C.10309@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMMJ-0005P3-8O
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbYCAHle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbYCAHld
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:41:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:38341 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbYCAHld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:41:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so733524ugc.16
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 23:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Tjy/RSYTgiVUKBM0oXJ9nSbR+3jdyveMxRc0e8KWM48=;
        b=Y2r+ob9GmZGCqTkCRuA6M7Lw4hIaxyL3rcLkWmbyBfgJJiPrepBKUH31OFScl+HNpB5OCfscta44Ui3WFsFQXx/YmeTUUxK6tdKz671ahF0BwlYYcgIzuAjjWXVogx07FsQ8TewquSNnPfodYpYdhSUojl6zBvL8njFpGm4tefE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OxNRTzLM3RHG03KU5eiJQ6L85lHuU3cs4wkkgk5LxWP4AZjhUNm/sIBAOiqTRwSkLF9olPu/UuRSlTfxbAjPxnjLV2PX/fdYWD76U91NETwOvFMGdFNAXNf+dFXbKJFHDVtd8HlR2fcZGKuzL8qPkxaARAyRuwEN8V+XFMxzkUQ=
Received: by 10.66.237.9 with SMTP id k9mr2768269ugh.13.1204357289653;
        Fri, 29 Feb 2008 23:41:29 -0800 (PST)
Received: by 10.66.252.19 with HTTP; Fri, 29 Feb 2008 23:41:29 -0800 (PST)
In-Reply-To: <47C87F1C.10309@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75635>

No, unfortunately lattest git-p4 does not help. p4 still complain
about location of checkout or unable to apply patch("file(s) not on
client").
My client spec is (p4 itselt is 2007.3)
---
Client:	YOUR-6C9B4BEFA3

Update:	2008/02/22 01:03:06

Access:	2008/03/01 10:32:50

Owner:	foo

Description:
	Created by foo.

Root:	c:\p4

Options:	noallwrite noclobber nocompress unlocked nomodtime normdir

SubmitOptions:	submitunchanged

LineEnd:	local

View:
	//depot/... //YOUR-6C9B4BEFA3/...
---
Thank you!

On Sat, Mar 1, 2008 at 12:54 AM, Marius Storm-Olsen
<marius@trolltech.com> wrote:
> Maxim Gordienko wrote:
> > Thank you, Marius for detailed instructions!
> > Now everything except submitting back to perforce works like a charm.
> > Perforce complains about git-p4 checkout is not under it's root
> >
> > Synchronizing p4 checkout...
> > executing p4 sync ...
> > Path 'c:/tmp/p42/main\...' is not under client's root 'c:\p4'.
> >
> > if I move checkout under perforce root git-p4 unable to create patch.
> > Have you encounter such errors?
>
> Not that I recall..
> However, it seems like you are using an older version of git-p4, so try
> just grabbing the latest one
> (http://repo.or.cz/w/git.git?a=blob_plain;f=contrib/fast-import/git-p4;hb=maint)
> and see if that helps you. If it doesn't work maybe you can tell me what
> your p4 client spec looks like?
>
> --
> .marius
>
>
>
