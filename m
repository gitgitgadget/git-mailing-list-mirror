From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 17:33:54 +0100
Message-ID: <bd6139dc0902190833p6ef34591i28f56495acc3e196@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-3-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-4-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
	 <499D82BC.7020500@xiplink.com>
	 <bd6139dc0902190816m3c70923eg132e89bff28a216f@mail.gmail.com>
	 <499D894F.90508@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaBs2-00082V-3k
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 17:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZBSQeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 11:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZBSQeA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 11:34:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:9165 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZBSQd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 11:33:59 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1242963fgg.17
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 08:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Ojr3RnJSUCp7pCoW6pw9+7T/oedStrZMKiS6Hy+3REs=;
        b=dVmsWhQVBhvd7ej2ooq7Jbuts89JaMqmDMJu9qvjiedXliP2GqVO+7WKgtpefOicjM
         NMWltIcZuwxkQ1yoAKJg/h7NXpQyG6Iom1OpCpS8g+sDQFqlRGyS9jf2lI6aweUAJZXX
         86ildHWFFJNK955iD0dudiSCmTlZmhxteExMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=W64E3f6WN97tvV9aYNZkpt8yEwuMEJ6t/FvPWFv7xK2ND1DcMF7hH07HVhhKU3P/UP
         NeE+ej7oLGm3q86dah4HZBB+nPrWwC+osGwHpCAm4IgvD0yGGHnnnaTA0kr18mMJRhHD
         h8rnaHa7gGtUcGQJVN8tpbv14Vq2f6655FPRo=
Received: by 10.86.73.1 with SMTP id v1mr429893fga.52.1235061237270; Thu, 19 
	Feb 2009 08:33:57 -0800 (PST)
In-Reply-To: <499D894F.90508@xiplink.com>
X-Google-Sender-Auth: 4df3db1121cae539
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110717>

On Thu, Feb 19, 2009 at 17:31, Marc Branchaud <marcnarc@xiplink.com> wrote:
> So commits A and B are basically left dangling?

Correct, that's why it's not desirable to do so when it's not your
private repo/branch ;).

> If that's the case, then I'd say "replaces" or "overwrites" is the right
> word to use in the 'remote show' output.

Yes, that would be a better wording.

> But more importantly, I think the 'git push' man page needs to explain this!

>From my cursory glance the term 'non-fast forward' is indeed not
explained in the man-page, feel like writing a patch? ;)

-- 
Cheers,

Sverre Rabbelier
