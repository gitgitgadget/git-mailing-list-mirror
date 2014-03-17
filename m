From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 15:51:40 -0400
Message-ID: <CAPig+cTJz30TKmnNqQUiubFKTnjH8FHc5_v1mvt9AB5eMDBHag@mail.gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqr460ek3k.fsf@gitster.dls.corp.google.com>
	<CA+SSzV3CZjpNaFuf1U1DcPXiKy=rpJH8M2q1xeMvyh9uEHxvOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdZb-0004TM-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbaCQTvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:51:43 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:45568 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaCQTvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:51:41 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so16265439ykt.4
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lwVWFZu7hrQBYDuiVpPvsajhgA65RFbow7lydgIElc0=;
        b=IOBhMc7wXzUseev2D3lq+V0oy3rjimZDq5gjOT5qHTO1P0lrMY4gCw764dUabKPMyy
         QopDKIncaDj1PPAbfDULHb4mYDejyT+eaat+j2Yeh58uaCIOo1tytSWLGDakCKBFhDR3
         wJq0UGV6yBdbFBfNlVGkZ60B7psW12FzcRdPqfE5Pl8VJ9iGtluXuxeDEm49uo/4AmX5
         +mNEdzfSDm+OriWUcfqdRHEGYzBHZB2mpF8Pgmbl2FdyDA9Bwf6BW0WA+8hrUeT0Adc9
         FBiVowablmAUQW5xl6Jze34hZhHN/qUgXZ0qX0HmX3zx74fcJOZkrNlcsa+Y1Px2VPPG
         CCgg==
X-Received: by 10.236.122.99 with SMTP id s63mr13132424yhh.19.1395085900966;
 Mon, 17 Mar 2014 12:51:40 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 12:51:40 -0700 (PDT)
In-Reply-To: <CA+SSzV3CZjpNaFuf1U1DcPXiKy=rpJH8M2q1xeMvyh9uEHxvOA@mail.gmail.com>
X-Google-Sender-Auth: F_8sI5FZNXYvtWioXDymq3dLmUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244274>

On Mon, Mar 17, 2014 at 3:46 PM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
> On Mon, Mar 17, 2014 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Benoit Pierre <benoit.pierre@gmail.com> writes:
>>
>>> Add (failing) tests: with commit changing the environment to let hooks
>>> know that no editor will be used (by setting GIT_EDITOR to ":"), the
>>> "edit hunk" functionality does not work (no editor is launched and the
>>> whole hunk is committed).
>>>
>>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>>> ---
>>>  t/t7513-commit-patch.sh | 32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>  create mode 100755 t/t7513-commit-patch.sh
>>>
>>> diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh
>>
>> Again, as I said, I'll rename this to t7514-commit.patch.sh while I
>> queue this.
>
> I assumed the "14" was a typo, will rename, but to
> t7514-commit-patch.sh right? (with 2 '-').

Yes, two '-'.

In the 'pu' branch, there is a new t7513-interpret-trailers.sh.
