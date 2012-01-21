From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: Suppress stderr and fix the "both added" test
Date: Sat, 21 Jan 2012 15:58:02 -0800
Message-ID: <-1651957157444815476@unknownmsgid>
References: <1327141578-54796-1-git-send-email-davvid@gmail.com> <7v39b8d9w6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Cc: "jcwenger@gmail.com" <jcwenger@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 00:58:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RokpP-0008Dj-AZ
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 00:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab2AUX6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 18:58:07 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43052 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab2AUX6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 18:58:05 -0500
Received: by yhoo21 with SMTP id o21so828454yho.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:from:in-reply-to:mime-version:date:message-id:subject:to
         :cc:content-type;
        bh=/KSHZvuwc1QDlVsOdudI13/u8evXDR7rSDP/gf95t2o=;
        b=LGbLH7hMzDqGFG30YPKbUxcORorM/ZWUDS4W/mX879kPuoPWiz1XvdndFDsh+pDPhF
         rcFKFaJ0K6S8nm/2isozLzc96cFSt1L5t2mW+TzfgDbztH3WKd2hc4mIuOh/8t48uyR0
         PVz9OAEVgwj+dOXhfBinJ2meFpCUmCeEowbwU=
Received: by 10.236.189.105 with SMTP id b69mr4655804yhn.90.1327190284478;
 Sat, 21 Jan 2012 15:58:04 -0800 (PST)
In-Reply-To: <7v39b8d9w6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188942>

On Jan 21, 2012, at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:

> David Aguilar <davvid@gmail.com> writes:
>
>> Silence error messages when "git checkout-index" is used to
>> checkout a stage that does not exist.  This can happen now that
>> mergetool calls checkout_staged_file() unconditionally when
>> creating the temporary $BASE, $LOCAL, and $REMOTE files.
>>
>> Fix the test so that it checks the contents of the "both added"
>> file.  The test was passing as a consequence of accidentally
>> handing a bad path to "cat".
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> This applies on top of da/maint-mergetool-twoway in pu.
>
> Thanks.
>
> It might make sense to squash this into the previous patch, which luckily
> hasn't hit 'next' yet, though---which I can do locally without need for
> re-send if you like.

Yes, please squash this commit. This is certainly a fix up.

Thanks,
David
