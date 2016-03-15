From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: fix AsciiDoc formatting
Date: Tue, 15 Mar 2016 10:09:24 +0100
Message-ID: <6B365D58-9788-4B2F-88B0-4F8AC10321DB@gmail.com>
References: <1456830320-40411-1-git-send-email-larsxschneider@gmail.com> <F0F4FA8A-EB42-4990-A90E-6C9245E0A9DE@gmail.com> <xmqq1t7dafa3.fsf@gitster.mtv.corp.google.com> <CAE5ih79btHY33vrmSt70kkttMdFRzG-tHBZ9K3fEC_OdAZygKg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Mar 15 10:09:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afkz2-00048d-4c
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 10:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbcCOJJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 05:09:29 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36272 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934232AbcCOJJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 05:09:26 -0400
Received: by mail-wm0-f42.google.com with SMTP id l124so2181846wmf.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/eey8i6Gm3ZRpbQVDmvoe07ww8OIaYtY3m0buyATDSU=;
        b=JrM6kMvboO5jdgGbpquOnpdM25/sciBJxti8MvXZZXlMTuj5fNtpaa9YY/B1IqPQnQ
         18L7E98R8R8m3Wm2+KIWSXNS1FwvYEcrHms4y5xtVsB9REX5y4WZpOiUWXURogMliKab
         SGyEnCCb5qH7rNbcokixnDCSYEgXzf9SXpsOQIQylgwpENHKiUoFp8QYFEkhcWspitax
         rhVt6w75jOXa+TWFncvc5VuvPB4HslpbZNIbTH1dEsT5hHmebjee/VRrjAX5R3sSM9Fo
         SdsE2YlKwbRhOnjdU57diTDCGaCBiWZ8mMUYiVRU/svlb2Cc3FrgamIkdGpck76+tcLk
         6fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/eey8i6Gm3ZRpbQVDmvoe07ww8OIaYtY3m0buyATDSU=;
        b=ZZtwVgPphob3uAgEa8kTaGqT0QrFoIxC1910v4q598d6H+YCouObUvNSjadR7d/AsI
         LMQ6d5zBX/VvVvy51ga7y5RDnyU8tZ+GDTvLGnLKwdnU93eFGcLRk7v1v54U2f4UNcnQ
         Sgk8UXW1LGCcUOhHYZBmOeWrLSllqeYpnijWCk9vzqJboqCD02lY+zgZzcoqGUH5ofeU
         yh2fQKJOgj4RobAuNMRGyO4hHfMbBleDXS2jUcJfYaSf+MpUm6E3YVd6ul+xDjhv74s5
         1spftoDYxAk44FoSfaAsJUIKwwhQqlQUPYXU8JaEjKHYcjgLYcKY3gFCkZjBOaWHiWMd
         mFwQ==
X-Gm-Message-State: AD7BkJLNuU3UEUL+ILnz9GtN44R2c1CGR9otuTxPGv2WH0RYJMunYjXAgbFvxXeUknWDFg==
X-Received: by 10.28.0.148 with SMTP id 142mr21585875wma.72.1458032965314;
        Tue, 15 Mar 2016 02:09:25 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y62sm19878887wmg.12.2016.03.15.02.09.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 02:09:24 -0700 (PDT)
In-Reply-To: <CAE5ih79btHY33vrmSt70kkttMdFRzG-tHBZ9K3fEC_OdAZygKg@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288843>


> On 15 Mar 2016, at 09:38, Luke Diamand <luke@diamand.org> wrote:
> 
> On 14 March 2016 at 03:51, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>>>> index 738cfde..140fc12 100644
>>>> --- a/Documentation/git-p4.txt
>>>> +++ b/Documentation/git-p4.txt
>>>> @@ -528,7 +528,7 @@ git-p4.largeFileSystem::
>>>> git config       git-p4.largeFileSystem GitLFS
>>>> -------------
>>>> +
>>>> -    [1] https://git-lfs.github.com/
>>>> +[1] https://git-lfs.github.com/
>>>> 
>>>> git-p4.largeFileExtensions::
>>>>     All files matching a file extension in the list will be processed
>>>> --
>>>> 2.5.1
>>>> 
>>> 
>>> Is there any chance to get this in? The formatting error is quite obvious here:
>>> https://git-scm.com/docs/git-p4
>>> 
>>> (while looking at this website I also noticed wrong double quotes around cp1252
>>> which I will fix with a subsequent patch)
>> 
>> I ignored this when I saw it first, primarily because I assumed that
>> anything related to git-p4 would get a review by somebody better
>> versed with git-p4 before I get to it; I forgot about the patch
>> after it was buried in the other messages without anything
>> happening.
>> 
>> Will take a look.
> 
> Comparing with the git-bisect-lk2009 page, it uses a slightly
> different approach for external HTTP references. The references are
> put at the end, as internal hyperlinks, and in a bulleted list. It
> would make sense to try to be consistent with that, unless there's a
> good reason not to.

Right! Thanks for the hint! I will post a reroll soonish.

Thanks,
Lars