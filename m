From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1] git-p4: fix AsciiDoc formatting
Date: Tue, 15 Mar 2016 08:38:36 +0000
Message-ID: <CAE5ih79btHY33vrmSt70kkttMdFRzG-tHBZ9K3fEC_OdAZygKg@mail.gmail.com>
References: <1456830320-40411-1-git-send-email-larsxschneider@gmail.com>
	<F0F4FA8A-EB42-4990-A90E-6C9245E0A9DE@gmail.com>
	<xmqq1t7dafa3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 09:38:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afkV3-0000xS-An
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 09:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbcCOIik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 04:38:40 -0400
Received: from mail-ob0-f196.google.com ([209.85.214.196]:36059 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbcCOIih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 04:38:37 -0400
Received: by mail-ob0-f196.google.com with SMTP id cf7so752424obc.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zGvTegYtW96M80QfqWp2glFG9Sjfypt4/GPeePRPfI4=;
        b=g4sA5gDBllnKwd6YfxU+z9XsvP1yEk1hDrhFGjtwVMbCeYIB7iPdpMk89zok4qpTJz
         C13MQXUpmXscCVn2YNrUJ3nfT7OTKjhk20A5r/nr4wRNpEyk8kcGYUiulOmKg2P7F0BC
         d+/PvAmpX9t2w8AlSby0I1KPt5pbuo0BStO7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zGvTegYtW96M80QfqWp2glFG9Sjfypt4/GPeePRPfI4=;
        b=I8F6tE0nXZhk9gmKQQPqc7r5//6rIlL35SfWuLKD9a7VMjS6hKIAS8kMP4+ptA4kWS
         I9zzAqGi9nGcFXlSN+pAvtY0dVxbK8K8s8YixVFnztr2R7dwm3BcQIdfwZfV2nlPzrQE
         OFIjNEI9LhSxw4o2uzwEVAuGqEMuOxJoFEEFb9+VKO/2MWzdFSxgj3wPDRHhEFHAeSJb
         oPkkQU4Op4141lSBKS9+aCa6P6ltOZJRa0PEcy6VWyZlIxGFz3Y6GbPoD7AOaKPN6ldj
         WMlyO/NPFBv3eauY3mNtZ/qZb59MWFf80Szlw850Pe4CmJ8JmqgWY6oEo3oHucjhM9uc
         z/dQ==
X-Gm-Message-State: AD7BkJJHoRytnIaar5H6exWnTLbF+ZVM3fnVXpGydNPRMBLftZDo30KDuabYAuRZrDZU09BXP7uGPBppEfux6w==
X-Received: by 10.60.70.1 with SMTP id i1mr17370842oeu.13.1458031116354; Tue,
 15 Mar 2016 01:38:36 -0700 (PDT)
Received: by 10.202.172.132 with HTTP; Tue, 15 Mar 2016 01:38:36 -0700 (PDT)
In-Reply-To: <xmqq1t7dafa3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288842>

On 14 March 2016 at 03:51, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>>> index 738cfde..140fc12 100644
>>> --- a/Documentation/git-p4.txt
>>> +++ b/Documentation/git-p4.txt
>>> @@ -528,7 +528,7 @@ git-p4.largeFileSystem::
>>> git config       git-p4.largeFileSystem GitLFS
>>> -------------
>>> +
>>> -    [1] https://git-lfs.github.com/
>>> +[1] https://git-lfs.github.com/
>>>
>>> git-p4.largeFileExtensions::
>>>      All files matching a file extension in the list will be processed
>>> --
>>> 2.5.1
>>>
>>
>> Is there any chance to get this in? The formatting error is quite obvious here:
>> https://git-scm.com/docs/git-p4
>>
>> (while looking at this website I also noticed wrong double quotes around cp1252
>> which I will fix with a subsequent patch)
>
> I ignored this when I saw it first, primarily because I assumed that
> anything related to git-p4 would get a review by somebody better
> versed with git-p4 before I get to it; I forgot about the patch
> after it was buried in the other messages without anything
> happening.
>
> Will take a look.

Comparing with the git-bisect-lk2009 page, it uses a slightly
different approach for external HTTP references. The references are
put at the end, as internal hyperlinks, and in a bulleted list. It
would make sense to try to be consistent with that, unless there's a
good reason not to.

Luke
