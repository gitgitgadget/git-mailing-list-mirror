From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-patch: add From/Date: line to header and print to file
Date: Mon, 22 Sep 2008 20:10:51 +0200
Message-ID: <36ca99e90809221110k2d4be91co8eae665fe4735ed1@mail.gmail.com>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
	 <1221818101-14333-2-git-send-email-bert.wesarg@googlemail.com>
	 <20080922153938.GP10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 22 20:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhptC-00087h-5D
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYIVSKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 14:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYIVSKy
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 14:10:54 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37883 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbYIVSKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 14:10:53 -0400
Received: by gxk9 with SMTP id 9so3391872gxk.13
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zmg1EIfSDaBH9RsnPLZE5JaGmW6wD5Dpl6HkAFv3Cxo=;
        b=m+ia5o3sbjkz9icj0NEqszipcY7gFH2hZDXxb0P4OJp4dZpHe/6LdplWb/brr7IgwQ
         D6BByqG8zKnNpHNVawsjEPubctEBVs4NQ2+Jl5iir0oY/dr6Aep1mOUowe89zlRB2Dgu
         VLc6IGLDCYizmZCXLBj7bMbogQ4RbSOeeHOhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qEYj4p+iMy3b04oAlWHbPAaMeVwmkVStdHPp70SAiNxD3vr/c5BPILTCjwNRYuGoPh
         8PnZDLt5QrvWrYjGO4efAk3vBZfv8OSbfi3Lu4ukieJ9kl9DkFeTsqhy4vTengT8aTwU
         Z/f9VjKwp1iWGMnlokYSohN55qA53S8h3OiUQ=
Received: by 10.150.182.16 with SMTP id e16mr7682168ybf.230.1222107051970;
        Mon, 22 Sep 2008 11:10:51 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Mon, 22 Sep 2008 11:10:51 -0700 (PDT)
In-Reply-To: <20080922153938.GP10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96504>

On Mon, Sep 22, 2008 at 17:39, Petr Baudis <pasky@suse.cz> wrote:
> On Fri, Sep 19, 2008 at 11:55:01AM +0200, Bert Wesarg wrote:
>> To make this more similar to git format-patch, I added a 'From' and
>> a 'Date:' header and let 'tg patch' print to a file (which is shown as output).
>>
>> Regards
>> Bert
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> I dislike the anyway completely bogus From line. If you want mbox
> format, you should call (hypothetical) tg mail. Also, IMHO Date: should
> be simply always printed at the end of the header, it's distracting if
> it is higher.
>
> Also, the writing to file is confusing to me. What are you trying to
> achieve? If you want to export patches, why not use 'tg export' which
> already has this functionality? To me, 'tg patch' is basically
> equivalent of 'git show' for the whole branch.

You're right. I'm not familiar what is needed as a header to be used
with git send-email.

But the additional indirection with tg export/git format-patch is
overkill for one patch.

Therefore I would leave the writing to file, but drop the additional
headers for me.

Bert
>
> --
>                                Petr "Pasky" Baudis
