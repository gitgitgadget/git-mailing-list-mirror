From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Rearrange git-format-patch synopsis to improve clarity.
Date: Tue, 6 Nov 2007 09:56:36 +1100
Message-ID: <ee77f5c20711051456i1bbd0d58j43490c55e0be9664@mail.gmail.com>
References: <119421522591-git-send-email-dsymonds@gmail.com>
	 <ee77f5c20711051432w284cf22dx71192c145d25dced@mail.gmail.com>
	 <472F9DC6.8020607@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 05 23:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpAsF-0006ER-8v
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 23:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXKEW4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 17:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXKEW4i
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 17:56:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:56536 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbXKEW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 17:56:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1659142rvb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 14:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vxp5koSaJEBs/9/j7NSGCq5E9w/zDyZBmsb+jZ8Vb/M=;
        b=PSR0YBaBouGQb27gbpElXDRjPVhXa8i3hpbbuUwouyjPUsI9A4Gtl6XfUD5QfVFEx7fzFCFx7Lz71IzHl6xa6UDUd7b8I3378E3wz51yPK2fuHf1XpN7WHIUBFvafAZKppy+tGCkhaqll7tQ8MJJqpJiI6fDrc2x8nW87rlqosY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i5/sBV8OoZxMIKBs1ZsbaZFK63pyzsS057spz8VInPp5hYWC72k9398xRTzKSOgpgZqRXkyMtRhNj2lSnJQsrFbr1VMwCvpkPRDlnSSOUH6/aw7CSozi6wD6s1u9NgEV2wHX9HHeK203Ivn+GSPkMUcXnczcCvokMcDVgD8fu0M=
Received: by 10.141.20.7 with SMTP id x7mr2672263rvi.1194303396731;
        Mon, 05 Nov 2007 14:56:36 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Mon, 5 Nov 2007 14:56:36 -0800 (PST)
In-Reply-To: <472F9DC6.8020607@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63581>

On 11/6/07, Andreas Ericsson <ae@op5.se> wrote:
> David Symonds wrote:
> > On 11/5/07, David Symonds <dsymonds@gmail.com> wrote:
> >>                     [-s | --signoff] [<common diff options>]
> >> -                   [--start-number <n>] [--numbered-files]
> >> +                   [-n | --numbered-files | -N | --no-numbered]
> >> +                   [--start-number <n>]
> >
> > Now that I look at it again, it seems the long options look quite
> > inconsistent. I think it should be either
> > --numbered-files/--no-numbered-files or --numbered/--no-numbered. My
> > preference is with the latter (for brevity), but that breaks
> > backward-compatibility.
> >
> > Would you accept a patch that changed --numbered-files to --numbered,
> > and kept the former as a synonym?
> >
>
> I thought files were always numbered, but the [PATCH m/n] wasn't. Have I
> missed something?
>
> If your --numbered-files is supposed to affect only file-numbering, I'd
> suggest *not* using --numbered, as it's ambiguous with "number-subject".

You're right. There's both --numbered ([PATCH n/m] stuff) and
--numbered-files (0001.patch instead of 0001-subject-line.patch). I'll
revise my patch to clarify this.


Dave.
