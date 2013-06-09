From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Sun, 9 Jun 2013 14:33:45 -0500
Message-ID: <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllNA-0006jJ-7d
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab3FITds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:33:48 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:35994 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3FITdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:33:47 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so5018026lab.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sbW0GmFAmE97KJ1ehhe/jkRJZCTx8zmijV0NDhgFmIY=;
        b=SuEctQqsE3JNrQVGIRLvQ/EuzRbLwUs428JZRpr88qeyOvta66iwPMIdY3ZhLeIx2l
         92c2kSfgF8KzglE1LLxIvxniK7oSy8sKjwPEuIG8qsZU+/1xZvGILOhgUF6dUKtEBUd3
         ZfFY3xPvqCoieQnH8lolRg4fkqb0MagfyPk8Ym9vFepu/pvqQWyCgtm4ms90dg2ZDSZ1
         HDXsx6OCT6z+nw8ffW1gjZqt/TTOXCKzmfzQuR7CCbWrHiyDBZj0dABa06mIl5kfOaop
         egqohxWyiR90jn5Wi7HTGM0fxF64QktVUuoTto0oofaInW1p+tXTlMoyGV+46WWdeTqj
         f32w==
X-Received: by 10.152.22.130 with SMTP id d2mr2961228laf.33.1370806426015;
 Sun, 09 Jun 2013 12:33:46 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 12:33:45 -0700 (PDT)
In-Reply-To: <7vy5ajozuj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227149>

On Sun, Jun 9, 2013 at 2:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Jun 9, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> --- a/t/test-lib-functions.sh
>>> +++ b/t/test-lib-functions.sh
>>> @@ -606,6 +606,18 @@ test_cmp() {
>>>         $GIT_TEST_CMP "$@"
>>>  }
>>>
>>> +# Check if the file expected to be empty is indeed empty, and barfs
>>> +# otherwise.
>>> +
>>> +test_output_must_be_empty () {
>>
>> Why such a big name? test_empty() does the trick.
>
> Primarily in order to avoid that exact name "test_empty" that others
> may want to use for a helper to check that the contents of a string
> variable is empty.

Which is never going to happen.

-- 
Felipe Contreras
