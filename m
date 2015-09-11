From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] Documentation/git-send-pack.txt: Flow long synopsis line
Date: Fri, 11 Sep 2015 09:22:11 -0700
Message-ID: <xmqqfv2l0vv0.fsf@gitster.mtv.corp.google.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
	<1439998007-28719-3-git-send-email-dborowitz@google.com>
	<xmqqtwrv8328.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRtXX3OqeQF_USwiNYA-y+92X65MSJqPKjhNjGka9QXBw@mail.gmail.com>
	<xmqqlhd782fp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Borowitz <dborowitz@google.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:23:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaR5e-00048G-4C
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbIKQWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 12:22:14 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35574 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbIKQWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 12:22:13 -0400
Received: by pacfv12 with SMTP id fv12so80417201pac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=R1FczTwFlZSVFGqJcEyXRIz8izmVxzgluWuHTKH4jME=;
        b=qC9mtVMfDxgKpu1FlrWB6149BeExwsdn94s0wamIPlkIxv8rdfXSbPZCuTvV9bQKOW
         I4Y1kbwM/3nvfGzrgGqvns4duSGlWO5zGyOV0ttksC+jcd/maCM3zogX1/BFK/XFVtHS
         RkzKIJNUJYxbJvnGpFxLpkTzOepmH+H5dFH/z+EkO5WQ3921upWhbeyxN+1+vWuqR+1c
         r9Zp/tRY26h1SwZoq9lr0dvEA+SXMvcGeYCk6ukrWT7tgH3MbNNOg9DcpViABeLzmQXZ
         S1ji+oygDLv9lDljQuMVBJUj63xBv6eLlU8pfklaeEK53h/NZBErAxPFf2g16WbCJkHi
         WB+w==
X-Received: by 10.68.106.197 with SMTP id gw5mr98563857pbb.1.1441988533027;
        Fri, 11 Sep 2015 09:22:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id wj12sm1245619pac.9.2015.09.11.09.22.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 09:22:12 -0700 (PDT)
In-Reply-To: <xmqqlhd782fp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Aug 2015 13:10:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277678>

Junio C Hamano <gitster@pobox.com> writes:

> Dave Borowitz <dborowitz@google.com> writes:
>
>> I produced the patch with "git format-patch --subject-prefix='PATCH
>> v2' --cover-letter @{u}.." and mailed with "git send-email
>> --to=git@vger.kernel.org,gitster@pobox.com 0*.patch"; is there a way
>> that would have preserved whitespace better?
>
> No need to worry, I suspect that this is a local Emacs/GNUS glitch
> on the receiving end.  Sorry for a noise.

PSA, as I figured this out.

It turns out that gnus-treat-fill-long-lines was set to (typep
"text/plain"), which meant that I cannot trust what I see in my MUA
as an exact copy of the patch the sender intended to give me.

Here is what "Describe variable" gave me (after I fixed it, that is).

    ---
    gnus-treat-fill-long-lines's value is nil
    Original value was 
    (typep "text/plain")


    Documentation:
    Fill long lines.
    Valid values are nil, t, `head', `first', `last', an integer or a
    predicate.  See Info node `(gnus)Customizing Articles'.

    You can customize this variable.

    This variable was introduced, or its default value was changed, in
    version 24.1 of Emacs.
    ---
