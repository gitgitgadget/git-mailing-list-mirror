From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: t7610-mergetool.sh test failure
Date: Tue, 24 May 2016 18:53:32 +0200
Message-ID: <CALR6jEiSfCQBZHKc8Ki46A3uTf2prhqOzADin7vE7360o7pvxg@mail.gmail.com>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
	<CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:53:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5FaL-0001gj-RV
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbcEXQxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:53:34 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35105 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbcEXQxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:53:33 -0400
Received: by mail-yw0-f176.google.com with SMTP id o16so21864485ywd.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7LHLNKonf5NlLd5ApipuratLx4b5si6xrdpzfNpFLh4=;
        b=RpaI60PcBHywpMe//92Idlb5HhTgPYfFW/PdTvqAjqOEA71dP2s8oPf7YEpLM7f/4u
         Ox460TQpcrC1ky3YrdtaiwURyOg9Q2KlTM/3bqV+AJALaGqSqH+DCEQuXsah7BICf0Ow
         dsKS6BbCq14wIeyV8ZPJRd+nW498ifFpj9ndAuCz93r5CK6M5SFyc0OCX/haKWcooSYM
         +pxPXLsdJIWDPGdtuGPtBlKq5gtVyLkZMNvorzeJPzfVU0/q5/pgoZdnffOhCzDi14Ao
         b9f7RH8WI4ql41CiBpJSG4p/HmITbyNZ7CK5vNp1iIM4YPCn+L+/NMFsCMMrS3NDMZQM
         tv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7LHLNKonf5NlLd5ApipuratLx4b5si6xrdpzfNpFLh4=;
        b=Wqp6Di1xYM/wQ/IbusKc1dl4CuEXW0v+/h6hdXgaGLOCVHCDd6Xwhgb8/y/XE7REuo
         QLC1WrewZYYYBOH3ShjhOFL1j+KiutfPN+6nypBKr8osTy+3Epsun6KtWJEX4kokKThN
         PnX1Ov6bzwkqEE7hfGQWhWe+WRW3vOZDrInH3j3l0Icj7bXVBdqLN2XhPcFZgyMbQSy9
         megncSsrBi4lqQ7sCPSK/+uks0+zusa/5ldEMkmupyv4V0vEVRO6RJe7l3Cc8V69ssLA
         1sHHWSK0BDHu+au9yVS8wm0+faXphIddATzxn3XLh9/3S8sQbZ8ZaiBgOvNtZ1dSSIc9
         iaGw==
X-Gm-Message-State: ALyK8tLYNFRuNkz1dMIVfWofiOgLEPZGrk1lhqHpRRlUxX5UOaI6lZ8n+nQLvZG1Lc2zoseOPXo7SuBy6ZHGig==
X-Received: by 10.13.202.151 with SMTP id m145mr3519047ywd.63.1464108812214;
 Tue, 24 May 2016 09:53:32 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 24 May 2016 09:53:32 -0700 (PDT)
In-Reply-To: <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295504>

On Tue, May 24, 2016 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:

> 3. find and install mktemp?
Sure, but which one? :-) mktemp is not mentioned in POSIX.
http://stackoverflow.com/questions/2792675/how-portable-is-mktemp1
