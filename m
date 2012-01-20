From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1) implementation
Date: Fri, 20 Jan 2012 21:33:35 +0100
Message-ID: <CALxABCZAaNwxJJRsMo7ESTP1sskjXbhk+OvPWOybS==D8FwNUA@mail.gmail.com>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com> <7vobtydu0o.fsf@alter.siamese.dyndns.org>
 <CALxABCZJATyVRf9akmfpn3WpJ8Xt80Ky0isFOTwDGpFKvFp3nw@mail.gmail.com>
 <7vfwfadt10.fsf@alter.siamese.dyndns.org> <CALxABCZnz-8BuXf=-HrH7UZXi6pQ3VzL4HrOKgKHqWwUMnwJQA@mail.gmail.com>
 <7vbopydst0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoL9t-000699-Vf
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 21:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab2ATUd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 15:33:57 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62865 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753894Ab2ATUd4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 15:33:56 -0500
Received: by obcva7 with SMTP id va7so1153418obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L8eEC5sPa5wfcSeU0thVTzWTvTXdvpl/g7fK+ZvYIfU=;
        b=rhZAK96SzdOQBgou2mYZZt940/PbMciW5ljzlr0/1wwhAHl2wRBJAEcwHVYrf/Ygv8
         YXyi+0GdXjo1o3pkoSxyZrXjtzgysZMsoqdY++ffsriEeqkuzqei0UC/QyntgkqcntfR
         VlLIbiBoT5NVLGG5PY5GmTQyzIZSWKfT7SEro=
Received: by 10.182.122.71 with SMTP id lq7mr27977783obb.33.1327091636238;
 Fri, 20 Jan 2012 12:33:56 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Fri, 20 Jan 2012 12:33:35 -0800 (PST)
In-Reply-To: <7vbopydst0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188903>

On Fri, Jan 20, 2012 at 21:26, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> .... Besides, the current version
>> wont have problems with such an upgrade.
>
> Yes, but at what cost?

A fixed number of "fork and exec" for every executed ". git-sh-i18n" line?
The overhead might be considered negligible...

Er. Am I missing something very obvious? (not obvious to me, yet)
