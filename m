From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/4] receive-pack: make it a builtin
Date: Tue, 09 Sep 2008 11:26:16 +0200
Message-ID: <48C64138.3020406@gnu.org>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com> <1220948830-3275-2-git-send-email-gitster@pobox.com> <1220948830-3275-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 11:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KczVQ-0004aX-5S
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 11:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYIIJ0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbYIIJ0W
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 05:26:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:24711 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbYIIJ0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 05:26:21 -0400
Received: by wx-out-0506.google.com with SMTP id h27so481439wxd.4
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 02:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=h168SmLvm9qI+FOjjko9yyXP+MBWwZmYX1MXA2V5YKg=;
        b=ooo5Z6IdhcRuMzkzSJebFR6MGsU+TtSO/uEYQonckOds/or3ojzRbln7lJGpLzcYLz
         llJMQQe6YpdB23dryDELKaN0HfwiFgrgYUgtkQF3k47KT9xSdwmkyd7LiPVNBKa3Q3Uu
         fAZzSvZyPH9aBzK0HuXjnODGFGfjsY4NtONfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding:sender;
        b=Uto3qpz/M3ZsGikJudZdg9T9iTAwxK/h5szkTCRL5eSbA1bmxyyngbn3mPhtVzmZSY
         4VnjNHGTg/5bLB/DdPVwz5pQH8N0W26iT4FPujc9Vn7C1pOew+LY5vgclI/d3GsOOrRi
         73lxxqkcmS+dfiYPdNBNABgDYPWhARGJlHn+8=
Received: by 10.103.198.20 with SMTP id a20mr11045750muq.56.1220952379314;
        Tue, 09 Sep 2008 02:26:19 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id w5sm23467653mue.10.2008.09.09.02.26.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 02:26:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <1220948830-3275-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95365>

Junio C Hamano wrote:
> It is a good thing to do in general, but more importantly, transport
> routines can only be used by built-ins, which is what I'll be adding next.

So how do I

        receive-pack = /home/bonzinip/bin/git-receive-pack

now?  Using libexec or ".../bin/git receive-pack" is fine, I just would
like to know it and see it in the release notes.  Or maybe
git-receive-pack should be installed in $(bindir) even if it is a builtin?

Paolo
