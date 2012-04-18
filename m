From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v3 5/7] t4052: Add tests to illustrate issues with
 restrictive COLUMNS
Date: Tue, 17 Apr 2012 19:31:24 -0700
Message-ID: <CACz_eydRcYNs1TOpRjM91tzmBrXjs4sKzBrFFvXGk0hEQ9zEMw@mail.gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
	<1334573095-32286-6-git-send-email-lucian.poston@gmail.com>
	<7v7gxfv7h5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 04:31:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKKg5-00018q-Ow
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 04:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab2DRCbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 22:31:25 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41111 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab2DRCbY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 22:31:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so8353357pbc.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TCbsuPPxWg30svx3ytSS1p1RETSW8CAs0uVPgak+l7s=;
        b=ZNOunuTV3fa+ma04ikQJkaig1vMe+9vsMzy9YnL11cX8/qyTYs693FMVHmiuz5W8DP
         wIUaIqbiJCMa1W1o062/xyp/AfjVtiwhBIYkpKk+ppNnurTSsIkepWQRba2nqCNUcYxr
         +tbda+LY4euATkTfP8YkTP+lLMoK6KaySNM/JRf9yhAhrkpDS5KhNZ97JlP1WLVY/nnz
         +NN4AIdU3UoNHqiy/+XB8CCmB8gQxz0e4C/qEIH2S9IwFPiAuPEEvDG2fb4UDnwaZOD1
         naxY310lTKSaW1oavYmrVru8n8UidA8zL9xDWpxrcJLDUpgk+YnTkvdZ0YwZRd1HEZFY
         xkwg==
Received: by 10.68.236.197 with SMTP id uw5mr2333077pbc.27.1334716284289; Tue,
 17 Apr 2012 19:31:24 -0700 (PDT)
Received: by 10.68.58.129 with HTTP; Tue, 17 Apr 2012 19:31:24 -0700 (PDT)
In-Reply-To: <7v7gxfv7h5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195831>

On Mon, Apr 16, 2012 at 11:48, Junio C Hamano <gitster@pobox.com> wrote=
:
> Lucian Poston <lucian.poston@gmail.com> writes:
>
>> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
>> ---
>
> Sorry, the patch text itself does not tell me what it wants to "illus=
tate"
> at all.
>
> I _guess_ that you are saying that the output for expect1 and
> expect1-graph should be limited to very narrow width, not like the
> humongous output like we see in the added test vector, and it will be
> fixed with your patch 6/7.
>
> If that is the case, please structure this part of the series like th=
is:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A05/7: add test vector to illustrate what th=
e correct output should
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be, but mark the test with =
"test_expect_failure".
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A06/7: update the code to fix it, and flip t=
he "test_expect_failure"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in 5/7 to "test_expect_succ=
ess".
>
> And 7/7 will become unneeded.

Done. Thanks.
