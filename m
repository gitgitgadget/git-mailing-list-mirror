From: "James Pickens" <jepicken@gmail.com>
Subject: Re: [PATCH] Modified the default git help message to be grouped by topic
Date: Tue, 2 Dec 2008 13:11:25 -0700
Message-ID: <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
References: <20081201173037.GA41967@agadorsparticus>
	 <20081201183258.GB24443@coredump.intra.peff.net>
	 <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 21:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7bbw-0006jD-9k
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 21:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbYLBUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 15:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYLBUL1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 15:11:27 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:52906 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbYLBUL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 15:11:26 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3331175wfd.4
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3TyIYUPDp5Wc7o+2g9gaIiqMqS558ze295QaC0bw5nk=;
        b=a6ih3CU09/ZwhriWk49CAjbXb24mC/K5uESSLzd/nlt2XFDC2LxGCJz/iBIVkEcKUt
         cGBlAUWBNb6mERC/YEVHSkN0it1LI3fpik044fZoLgwzgPun1c2l5N10xfwTuJbVOgrB
         zL1yDafeYd8XMHr9GyGS3SUxo9c7e5GpJ5zKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t2+rGH/KjKJDYiRvQVjE3fQvKMF/P7cVgVxWPfmh8d5OW9u1+JlTQ3RRDZsG49pQB7
         At5CQC4Ne1h5N+68USQY7wolscKU4UPX+CWS7Ll5yvxqtO36aQ+bpExMDYSuMPELckeC
         pGZBfxxMnAij8aT/CshngUgVpWOXHkd0TkDrY=
Received: by 10.114.193.1 with SMTP id q1mr7568383waf.153.1228248685654;
        Tue, 02 Dec 2008 12:11:25 -0800 (PST)
Received: by 10.114.192.8 with HTTP; Tue, 2 Dec 2008 12:11:25 -0800 (PST)
In-Reply-To: <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102172>

On Mon, Dec 1, 2008 at 11:10 PM, Scott Chacon <schacon@gmail.com> wrote:
> Hi,
>
> On Mon, Dec 1, 2008 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> If this list is meant to show "the most commonly used" basics, then you
>> can trim the list somewhat.  For example, "rm" and "mv" can be safely
>> discarded, "status" can be replaced with "diff", and "diff" can be removed
>> from "History Commands".
>>
>
> I sent a new patch that removes 'rm' and 'mv' and removes the
> common-cmd.h build process. I did keep the 'status' command, since in
> my personal experience people tend to like having that command.

Even though 'rm' might not be used very often, I think it's an important
enough command that it should not be removed from the 'basics' list.
AFAIK, the only other way to delete a file is 'rm file' followed by 'git
add -u' or 'git commit -a'.  Imagine a git newbie trying to figure that
out.

I'm tempted to say the same thing about 'mv' as well.  And FWIW, I use
'status' a lot more than I use 'diff', so I would vote to keep 'status' in
the list too.

James
