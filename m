From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] test-lib: tests skipped by GIT_SKIP_TESTS say so
Date: Mon, 3 Mar 2014 18:18:46 -0500
Message-ID: <CAPig+cRnfDta9FofgH2jSdivzKvJiHwnzPZ5PoO4UTpWQLSH4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Ilya Bobyr <ilya.bobir@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKc8J-0000HU-O2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbaCCXSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:18:48 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:44560 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbaCCXSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:18:47 -0500
Received: by mail-yh0-f51.google.com with SMTP id f10so3805388yha.24
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 15:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=2V4DnG8KY1UN2NAbujBDOKm6exMY+fp9mqQ/gOYLero=;
        b=ir2Fj/Q+iKQEqAV/3EHl7jYy+Aa8xins84MtvNdW6gVVJgWb+rJn9KxpJg9CPqy3zV
         GdWc9I99gE0Jj4Ls7mL4GKmmlhFJ6SVyiyO47xpbgBPPGlyY1drqQuBHBx6rP/PRXyx6
         /08k/orXm+TFlSj2CeQK03SkR++Ms1k0YEpUlJHzWhjw7v5KxMkHiCfmENmTPsE/LsKU
         oZOY4ZFFn+p6Sfkv5yyZeb7r8PetV3CVzE30fJAt9isJPBr6LWmZmPxECwXzXuqnO2PW
         vxNz5Gj8yMy5RZolgBogNConspeRoKY0BUFF4rfzF9Lz0l9O69q+faBui/DKu30hg9m7
         ON9w==
X-Received: by 10.236.112.48 with SMTP id x36mr3589917yhg.122.1393888726980;
 Mon, 03 Mar 2014 15:18:46 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Mon, 3 Mar 2014 15:18:46 -0800 (PST)
X-Google-Sender-Auth: mVR4S0m6-UeVvRY2fLvGZh6xgwM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243306>

On Mon, Mar 3, 2014 at 6:12 PM, Ilya Bobyr <ilya.bobir@gmail.com> wrote:
> On 3/3/2014 2:59 PM, Eric Sunshine wrote:
>>
>> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>>>
>>> We used to show "(missing )" next to tests skipped because they are
>>> specified in GIT_SKIP_TESTS.  Use "(matched by GIT_SKIP_TESTS)" instead.
>>
>> Bikeshedding: That's pretty verbose. Perhaps just say "(excluded)"?
>
>
> The next patch adds another reason for the test to be skipped, so it seems
> reasonable to say why exactly.
> The patch actually makes it say "matched GIT_SKIP_TESTS".
> It looks OK on the console.

Still just bikeshedding:

That new message in patch #2 says "not in GIT_TEST_ONLY", but isn't
"(excluded)" also applicable to that case? Is it important to be able
to distinguish between the two "excluded" reasons?

(No more bikeshedding for me.)
