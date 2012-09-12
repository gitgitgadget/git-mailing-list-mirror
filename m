From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH] git-am: Handle "git show" output correctly
Date: Wed, 12 Sep 2012 17:26:39 -0400
Message-ID: <CAPBPrntHOpDaH3cSNiKKxVJDbZTpPrLc99TgPM_GdoXecUvs9w@mail.gmail.com>
References: <1347472823.12986.3.camel@eddie.install.bos.redhat.com>
	<1347473304-21418-1-git-send-email-pjones@redhat.com>
	<7vtxv3atvu.fsf@alter.siamese.dyndns.org>
	<1347482918.21933.5.camel@eddie.install.bos.redhat.com>
	<7vpq5raqiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Jones <pjones@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 23:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBuSP-0008P2-CB
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 23:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab2ILV0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 17:26:41 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52638 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2ILV0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 17:26:40 -0400
Received: by eaac11 with SMTP id c11so1047896eaa.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jcIHAS75KINH8ta25XZujqzS1FYWT/XsQ4ZU799qUW0=;
        b=QbOzQSYNzpGN5Nzva4HPFkx7FdVRvj/7ADYwk6j1huL1oj6KEdeFqN0D1pGZRTqklu
         GoFXhRWGluhEMlVRLxOVI7sFzgA7EnBF33H4A7LkVZdvXm5lmBPQmvQtjQDzxHKMk1nS
         1NVdIAVKDGvED+j5WIIOtYevIEqXxeGOBtnsOdOobQ5mZCJyWlApD/vDF3MpcMIdoU2w
         QOSSDUd7YbdHAoOeNhzIBhN96EUj9UuGbwBTks4wRVQdNe6kjFoUv2yTsDmtbeUGl9lU
         GaJDk5eXBezNQ/F85ZzKuX4TQbPQfCQUx13SvTvSssNxFlpWrLH2iNFgxBbhWAXKyVzy
         Mbwg==
Received: by 10.14.223.9 with SMTP id u9mr33080188eep.10.1347485199727; Wed,
 12 Sep 2012 14:26:39 -0700 (PDT)
Received: by 10.14.119.199 with HTTP; Wed, 12 Sep 2012 14:26:39 -0700 (PDT)
In-Reply-To: <7vpq5raqiq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205342>

On Wed, Sep 12, 2012 at 5:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Peter Jones <pjones@redhat.com> writes:
>
>> Well, if that happens, maybe we could regexp match on
>> "[[:alnum:]_-]+: /someexprthatlookslikeanemailaddress/" ?
>
> I doubt that would be even reliably done.
>
>> But we could
>> also just wait to cross that bridge until we get to it?
>
> Not really.  If we start encouraging people to use "git show" output
> as a kosher input to "am", we would have to support such use
> forever, and we end up painting ourselves in a corner we cannot get
> out of easily.

If git am emitted a warning when accepting "git show" output, it seems
like it would support Peter's use-case without encouraging bad
behavior?

-- 
-Dan
