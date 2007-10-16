From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 11:04:47 +0200
Message-ID: <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <471476B7.5050105@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael Witten" <mfwitten@mit.edu>, git@vger.kernel.org
To: "Adam Piatyszek" <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 11:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhiN3-0002TK-1b
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbXJPJEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbXJPJEx
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:04:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:51931 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270AbXJPJEv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:04:51 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1161438nze
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 02:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=t625I87CYozF/GlGEsty7sNQRpqAD0ukXcuvsDMxXgg=;
        b=pnTG3iuYUqA6+Ph9OTRZ15Sh0WvYcyCIWT8piLVaB4/RRyBeaZP04p+P9jsAwF9s8appNO4Qpah+TTVkSjgxgM1EIQ1+L526c5eQip8bb0o/iQLS7GkpFBANnWKE0v2xBFO6RcZaAChzGLmXokPpZlchQltlLchLIsMMukMorIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ms7QmKQNMj4hgNQH5S5Zkbsvwq1nNbIFQE8i56zRgS09IKv4LWZLALvN10BTkcLd7bqOUtucpM11XFt6pgEgdg0CE1Ne3maxBvEQifpRSu9505WvGpKNBjLPcZ8ln5Yi/nkzMBJLbxRN0Vw8EbC2jgR9a36XMZbke4Pe7D2T9ks=
Received: by 10.115.72.1 with SMTP id z1mr8179192wak.1192525487361;
        Tue, 16 Oct 2007 02:04:47 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 16 Oct 2007 02:04:47 -0700 (PDT)
In-Reply-To: <471476B7.5050105@users.sourceforge.net>
Content-Disposition: inline
X-Google-Sender-Auth: e13d36f68d61c5fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61123>

On 10/16/07, Adam Piatyszek <ediap@users.sourceforge.net> wrote:
> I am kindly asking for some tips on configuring
> Emacs and Vim to follow the rules used for Git and kernel code
> indentation/alignment.

>From http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/CodingStyle;h=7f1730f1a1ae2e9a6f368bdb10ff65f4568863d5;hb=HEAD

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))


And to use this only in a specific directory:

(setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
	auto-mode-alist))

--
larsh
