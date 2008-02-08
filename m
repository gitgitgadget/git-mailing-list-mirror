From: "Jay Soffian" <jaysoffian+git@gmail.com>
Subject: Re: Using thunderbird to post/apply patches?
Date: Thu, 7 Feb 2008 23:10:13 -0500
Message-ID: <76718490802072010x63e2082akf1aa92b12cd24030@mail.gmail.com>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
	 <47AB97EC.8030002@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNKZx-00080E-2Z
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 05:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758976AbYBHEKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 23:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759893AbYBHEKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 23:10:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:20023 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758976AbYBHEKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 23:10:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so182641wah.23
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 20:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=mijaGaBlrLcEOqBZ12M4IkxpNDJ5kgobsyWBSUEiOxo=;
        b=QMpIMSj/ZjiscwvEndtSG+2iiNOjKFUUU9IsZiJ943WZsHsxhshYpX7rsFZ7MAjt7fDykj0ZuwGT3v/noYkYW90XoPg2RsumgKfgvPd5i6z5YZ7MqEsACOCg+0hsNp4OP4BvoT+TSaCadOIMQThrRNQQKl1APx3ACHqa5JxOkkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oVB3L36JQwsafS0Obza3xmY01PgPMKslly0XH79xf0o/qRNuUUUDDmruGCu/6Ir85HnvEwu5vNH2tj8NCjFQ8YRVAuoLgNMmtQEYBjULlwSQwPFohZOqld67Sr3syHzOm3mL7RmXjbUtzoJ71GTbzsniFqcacw3cAqHRY8c4TJ0=
Received: by 10.114.146.1 with SMTP id t1mr4748465wad.20.1202443813524;
        Thu, 07 Feb 2008 20:10:13 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Thu, 7 Feb 2008 20:10:13 -0800 (PST)
In-Reply-To: <47AB97EC.8030002@nrlssc.navy.mil>
Content-Disposition: inline
X-Google-Sender-Auth: d69f0fb382a8a071
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73031>

On Feb 7, 2008 6:44 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:

> I also have mailnews.send_plaintext_flowed => false as suggested in
> SubmittingPatches.

Would teaching git-mailsplit to handle format=flowed be considered a
useful contribution?

(W/o sounding like a total script weenie, I'm actually wondering if
converting git-am, git-mailsplit, and git-mailinfo to Perl code
wouldn't be a bad idea... groking email is a lot more pleasant in Perl
than shell and/or C.)

j.
