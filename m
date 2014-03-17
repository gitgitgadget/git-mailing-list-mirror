From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 17 Mar 2014 20:46:18 +0100
Message-ID: <CA+SSzV3CZjpNaFuf1U1DcPXiKy=rpJH8M2q1xeMvyh9uEHxvOA@mail.gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
	<1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
	<1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
	<xmqqr460ek3k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdUN-0006jg-DH
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaCQTqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:46:19 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39198 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbaCQTqT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:46:19 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so6219158oag.27
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jT/g3KKZL1c4EzM4su91OhVXQTL9QzX3A9Qj95xcfwc=;
        b=rDxaO1zIiMXJ/bNrQIk/P/7nw1PQ72F1zTXjxGPCpgRWAvmSzJXowiWbFm8EkKKgRy
         LB1QFCASZm9jrBZC7sMCAemeqHpcOdlbdvoIOWHckhLAgvAtAgZWET4g2C+d2yGy6Uv7
         PiFFI7urTQ5QeAzxJ8Fa9d5Yxg2JpvqMRDFs1JGlR5ZvMHtyeSDZLUb/CI+URuJsYYa+
         wpza6sWh6InNUnkZm3huU9WSeHmzgntZ3sNIYnVcXjE6C1UuSi40owxogvqaE7fkyLJV
         2tghNI5r3rUCnTWCyc6IE+0iMggum7BjuxHN/8AAMQEyu93e855Z0PjVO0fzaWHq6oWI
         z3ig==
X-Received: by 10.182.20.111 with SMTP id m15mr3052264obe.61.1395085578613;
 Mon, 17 Mar 2014 12:46:18 -0700 (PDT)
Received: by 10.76.94.143 with HTTP; Mon, 17 Mar 2014 12:46:18 -0700 (PDT)
In-Reply-To: <xmqqr460ek3k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244273>

On Mon, Mar 17, 2014 at 7:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Benoit Pierre <benoit.pierre@gmail.com> writes:
>
>> Add (failing) tests: with commit changing the environment to let hooks
>> know that no editor will be used (by setting GIT_EDITOR to ":"), the
>> "edit hunk" functionality does not work (no editor is launched and the
>> whole hunk is committed).
>>
>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>> ---
>>  t/t7513-commit-patch.sh | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100755 t/t7513-commit-patch.sh
>>
>> diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh
>
> Again, as I said, I'll rename this to t7514-commit.patch.sh while I
> queue this.

I assumed the "14" was a typo, will rename, but to
t7514-commit-patch.sh right? (with 2 '-').

-- 
A: Because it destroys the flow of conversation.
Q: Why is top posting dumb?
