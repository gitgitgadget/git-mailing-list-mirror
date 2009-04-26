From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: git-clean: make description more readable
Date: Sun, 26 Apr 2009 01:04:16 -0700
Message-ID: <49F41580.3080004@gmail.com>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net> <1240672421-10309-3-git-send-email-wjl@icecavern.net> <49F35833.5070005@gmail.com> <200904251923.46448.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sun Apr 26 23:01:47 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxzVr-000819-Eq
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 10:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZDZIEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 04:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbZDZIEW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 04:04:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:57349 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZDZIEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 04:04:20 -0400
Received: by wa-out-1112.google.com with SMTP id j5so976356wah.21
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=rC/bnZOWJqAx3yzI68u1p24S9cLdI+Vt7kLLzSzKikU=;
        b=u9nJsvPo8VatcorG2kwKFO206Ugw4JzBiykRCKfWYYCWJw1arxTYB4FTK+96t5J/oE
         NQDL16EvwMhp+ntGtNfTQUHhBOSm92Iu29lwXDIqQwse/W44P9ZgcZBZLFDmelZF9Emn
         LomtpDiSeTrOMzAmw2ffsKxv/v0G6ckBjZtfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=FVHUeyo89bzCZCr8kTj5pFi2cViP/WKJlTw7ZTCSe0Xhv/1nIiW6UPgoSKIjCKH6Xy
         aJ0y06pjExZPdaCswbc1CRAUfqxwwa1GFtt5Lv3INcxRny+aDdcmCM0n4XsyN7+wnM4s
         JAatonZvnQblXkJwkc4DsmHKJ+d1GF+Cg/CP8=
Received: by 10.114.159.16 with SMTP id h16mr2059930wae.35.1240733059888;
        Sun, 26 Apr 2009 01:04:19 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id l31sm190598rvb.3.2009.04.26.01.04.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 01:04:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
In-Reply-To: <200904251923.46448.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117593>

Wesley J. Landaker wrote:
> The main reason I took that out in my patch was because I think the second 
> sentence more says the same thing, except more clearly, and the exact 
> semantics of "files unknown to git" versus "ignored files", etc seem to not have 
> good definitions anyway, so I left that for the second paragraph that talks 
> about how '-x' changes things.
If you want to keep it, maybe change it to be more active. Something like:

    Cleans the working tree by removing files that are not under version
control.

> So I might edit yours to say:
>
> Specifying the '-x' option will also remove ignored files. This is useful to 
> remove, for example, generated files that are normally ignored.

The "for example" just comes sticking out again. Could you put it at the
beginning of the sentence?

> I left the part about '-x' there mostly because it was already in there, so I 
> figured someone at some point thought it was special enough. I didn't want to 
> undo any good decisions that had already been made. =) That said, both -x and 
> -X are somewhat special because they change the behavior a LOT compared to, 
> say, -d.

So maybe -X should be described as well?
