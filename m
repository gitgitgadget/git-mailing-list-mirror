From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Build without BUILT_INS
Date: Tue, 24 Apr 2012 12:41:35 -0700
Message-ID: <xmqqwr54gbo0.fsf@junio.mtv.corp.google.com>
References: <CAAXzdLVbqp-_9A+BwcOuiHi3A39gAJb7_NqANfhAfuK9-+iZ0g@mail.gmail.com>
	<xmqqmx61hmtu.fsf@junio.mtv.corp.google.com> <4F96650E.7040900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMlcM-0000dD-Oa
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160Ab2DXTli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 15:41:38 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:58583 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757012Ab2DXTlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 15:41:37 -0400
Received: by wibhj13 with SMTP id hj13so60167wib.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=xwqk2OhE8Uv76Snn7+ZfKJrOkAGofaKckXmjn4NfCvA=;
        b=DH+hOOMoKDYBI4mz0k59IHuUs5EBFVaD9wdL45xV9QQM6gEQiSsPWzqHMKuNrIcgtm
         5Qg+F/RYF3YV7YUcRcdJKp05iNfX4GcQzC4sip3rACG0YGNPOSn0ne3gP52SmsTCdfjQ
         qasFNf1WGCSbx605Sgf2TjTHqbCVmRjUXMABPLAu0LxM4fyFOLd7Mvtcv53ZEVl6Q6hR
         L+eCQnQcnX380iZZo+GRFxNxzsDnTLaJoC9XN6OuDgoxGIS89f6neyTL5uIbpU2bKXY4
         ZmRedSWm7wp4POB3n4FNyie8eS6zMnfXFTimGqJf+f5DvLsjtkB2OMErLtPYSkr2/1lE
         8nTg==
Received: by 10.14.101.16 with SMTP id a16mr5148578eeg.0.1335296496459;
        Tue, 24 Apr 2012 12:41:36 -0700 (PDT)
Received: by 10.14.101.16 with SMTP id a16mr5148560eeg.0.1335296496343;
        Tue, 24 Apr 2012 12:41:36 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si18669493een.0.2012.04.24.12.41.36
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 12:41:36 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 28067200057;
	Tue, 24 Apr 2012 12:41:36 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 76171E125C; Tue, 24 Apr 2012 12:41:35 -0700 (PDT)
In-Reply-To: <4F96650E.7040900@op5.se> (Andreas Ericsson's message of "Tue, 24
	Apr 2012 10:32:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnXMgJ7mFTNuUNMf0SdCqPp44NDuDl15ovVAjNDnXrEHCft34iC1UFXCSV94um+e2PbzMhzCuxAc3gu3y8taWfwSD9e2kh9FGOR0kySMCKy5AZ32s8/MjhE6Wse2pOWm7q755w1mw/mvU7uLBk8nsIrU3/rIe4BrHjNf6hmmusxa/rPih8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196240>

Andreas Ericsson <ae@op5.se> writes:

> On 04/24/2012 04:42 AM, Junio C Hamano wrote:
>>  ...
>> And no, it will *not* be a compilation option, as the resulting
>> installation will break the age-old promise we made to script writers.
>
> Otoh, we did warn that we were going to deprecate the 'git-foo' form back
> in 2005 when the git wrapper was rewritten in C, so perhaps we should
> consider...

We already discussed it and shot it down soon after 1.6.0 fiasco.

    http://thread.gmane.org/gmane.comp.version-control.git/93511

Please do not drag me into that mess again.
