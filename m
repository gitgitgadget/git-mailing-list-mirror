From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 13:47:34 -0400
Message-ID: <CABURp0p+2XUtFGW+7hEzna9qvANZGxTRw0oULfo+iM2UFrwqSA@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com> <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 19:48:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcJKR-0003Cp-OT
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 19:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004Ab3ENRrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 13:47:55 -0400
Received: from mail-vc0-f173.google.com ([209.85.220.173]:39519 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab3ENRrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 13:47:55 -0400
Received: by mail-vc0-f173.google.com with SMTP id ht10so889045vcb.4
        for <git@vger.kernel.org>; Tue, 14 May 2013 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IN/dRM9ilQChJlGbQROSE+xRSkKH7F0jQWDNzHdNm5s=;
        b=WjetXANlYU2c14W1KpC2eY5yqscRvl5DFkfhgo7m2H6XjmaQr0prI+2XJWhTEWOPcU
         Utj8g+cd6QA8As7TO9QqO1rwXasHwFiN8oWal9xD7Bk1nQWaFqXG76v40RymtQ4/taN0
         Bb/SitDzwtGPQ+qRDHE9+cC8qCMZw4AKvstTijndqlkh+2Dbg0BsDMu2POiNYJKvAXfc
         a9pJZzqaBv1m0yOtkKLd6eh0bFvBoYO3ZQr8MAYN54Z0QAdzhr7zPbAzVF9AGP6fL7nA
         G3Gi0aXqO2L1aA5W+e/TcBkNfbkDkIG7MHSxvZOhAu5fcuHhJFnGne28gs9Mf36h2VF0
         /OJA==
X-Received: by 10.52.156.232 with SMTP id wh8mr17509635vdb.103.1368553674424;
 Tue, 14 May 2013 10:47:54 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Tue, 14 May 2013 10:47:34 -0700 (PDT)
In-Reply-To: <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224306>

On Tue, May 14, 2013 at 1:44 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Tue, May 14, 2013 at 10:12 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>>
>>  -S<string>::
>> -       Look for differences that introduce or remove an instance of
>> -       <string>. Note that this is different than the string simply
>> -       appearing in diff output; see the 'pickaxe' entry in
>> -       linkgit:gitdiffcore[7] for more details.
>> +       Look for commits where the specified string was added or
>> +       removed.  More precisely, find commits that change the number
>> +       of occurrences of the specified string.
>> ++
>> +It is often useful when you're looking for an exact string (like a
>> +function prototype), and want to know the history of that string since
>> +it first came into being.
>>
>>  -G<regex>::
>
> It looks like you have deleted the -S and -G references here.  Am I
> reading this right?

Doy!  Yes, I was reading it wrong.  Sorry for the noise there.

Phil
