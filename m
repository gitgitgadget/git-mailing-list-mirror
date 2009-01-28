From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] git-am: emit usage when called w/o arguments and w/o 
	patch on stdin
Date: Tue, 27 Jan 2009 21:53:40 -0500
Message-ID: <76718490901271853p4c9eea6dhe7b2ea5edac256b5@mail.gmail.com>
References: <1233110338-16806-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, sverre@rabbelier.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 03:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS0a3-00025u-BY
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 03:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbZA1Cxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 21:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZA1Cxl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 21:53:41 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:15089 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZA1Cxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 21:53:41 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6726795rvb.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 18:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uADn8qZZjv3G5zH6jzTvQwCHntKUJCUqXu2P/O0l6c4=;
        b=rDbITbp145JVm8tiUSNnQJ3zvfEzjkrLspYuv0Fe9QEBxzagUZ+LdM9GTNx46Aso1B
         mWYh70nkpt/eNYWQrtsnmUeVSUONuzs4dThD1ETdTTZZ95+M7gj+elj0LbaX2xUlDoQm
         JaomDEDEH8eoSAbe8HDWkNlPEBWWoqBPnVpzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jbM/tvOCeA6kZVxHxlUe2gqr0ZaH9OXfl7mv2BUYnOT35bLEJ8AOJN6WQ7TTMiHKMY
         VF0HVco6BEUuLCBSL8l0Gg0OIvPil7oWe013zdTt0EWaDX5UEcNZn/9TQsHRjZuLfyAX
         P8cLQOUw71I/dHE12A93soNqa1wAS1HmcEqbM=
Received: by 10.140.139.4 with SMTP id m4mr3081928rvd.32.1233111220556; Tue, 
	27 Jan 2009 18:53:40 -0800 (PST)
In-Reply-To: <1233110338-16806-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107455>

On Tue, Jan 27, 2009 at 9:38 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> When git am is called w/o arguments, w/o a patch on stdin and the user hits
> ctrl-c, it leaves behind a partially populated $dotest directory. After this
> commit, it emits usage when called w/o arguments and w/o a patch on stdin.
>
> Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
> while it is processing input.
>
> Noticed by Sverre Rabbelier

Ugh, I forgot to sign-off on this and the next patch. Should I resend
or is it okay to say:

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>

j.
