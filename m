From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Documentation: explain push.default option a bit more
Date: Mon, 23 Apr 2012 12:11:15 -0700
Message-ID: <xmqqwr56i7qk.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-2-git-send-email-Matthieu.Moy@imag.fr>
	<CB914FF3899C496F9E85E83B9532E055@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 21:11:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMOfW-0007lh-6g
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab2DWTLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 15:11:21 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:40101 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab2DWTLU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 15:11:20 -0400
Received: by eekc41 with SMTP id c41so586964eek.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 12:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=bPsyIHH2JwDjQNj3UrRdEvzww6rdSI6OSVfofbC/nRw=;
        b=LbynCeiwB9qiTOPLfuHAJuJ+qPuoz742sAwu4AEjZm0uhDgij6B46JqwV76GmtZpwT
         3ZIGObIlJDRREjduORpzb+fulBT2F/2JcoDjl/awTFrdLwaLvpKbzCL28sIJmS1NlsKd
         nEdwBK8exnb29+g4JUZXw2BeJHtq8jdbYhiturjRHjcgRbi9jH7UrpVFw9yWarorINxh
         dtLDWXHgqPcDKwb58zv5WVPZbK315FJIX4JTCxkZTYUqEWjxqkujNC1Cy9kmVLlew6b6
         hv2V25x7IIBnQZh+3unxvKU12aLhm3uieCjSX8P2xJ/DP5NrCz03xJ0JfHmdaaEGJHZz
         RoPw==
Received: by 10.14.96.134 with SMTP id r6mr4069322eef.1.1335208276411;
        Mon, 23 Apr 2012 12:11:16 -0700 (PDT)
Received: by 10.14.96.134 with SMTP id r6mr4069299eef.1.1335208276278;
        Mon, 23 Apr 2012 12:11:16 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si15446731eei.3.2012.04.23.12.11.16
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 12:11:16 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 18FB5200057;
	Mon, 23 Apr 2012 12:11:16 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 5AE7BE120A; Mon, 23 Apr 2012 12:11:15 -0700 (PDT)
In-Reply-To: <CB914FF3899C496F9E85E83B9532E055@PhilipOakley> (Philip Oakley's
	message of "Mon, 23 Apr 2012 20:00:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmx14Dzm8UdeFmLcVK4CsEokwG6ukgXfrDueSU1TrUkNgENSaP5xCv+va5x7W0Z9ofAL+bv3FqjoJ0ILK0sNNLKxfXr+IaKD+/Xv923ZuMAHTjAkH63mk7zks7z1xcx+TIQ44Epi19zA6DuKpEXe6cNswd4/YbRBDUnBw99+CS+uXqu1IE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196160>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Matthieu Moy" <Matthieu.Moy@imag.fr> Sent: Monday, April 23,
> 2012 9:37 AM
>> The previous documentation was explaining _what_ the options were doing,
>> but were of little help explaining _why_ a user should set his default to
>> either of the options.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ...
>> +* `matching` - push all branches having the same name in both ends.
>> + ...
>> +  updated the branch remotely. This is the default.
>
> Given the expected future change to 'simple' as the default, surely
> "This is currently the default." give the hint toward that change.

Correct, and that is exactly why this patch does not say "currently".

As the proposed commit log message explains, this change is about
clarifying what these options are and unrelated to "future" default
change at all at this step.
