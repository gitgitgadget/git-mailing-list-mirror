From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 13:58:58 -0700
Message-ID: <xmqqoaiwc831.fsf@gitster.dls.corp.google.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	<xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
	<1438113266.18134.26.camel@twopensource.com>
	<xmqq6154dpkt.fsf@gitster.dls.corp.google.com>
	<xmqq1tfsdp60.fsf@gitster.dls.corp.google.com>
	<1438115304.18134.33.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:59:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBxq-0004c5-4R
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbbG1U7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:59:01 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32921 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbbG1U7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:59:00 -0400
Received: by pdbnt7 with SMTP id nt7so76475563pdb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UJGKfDeiAPogcsE9uXGmrDkcdOCb0aVtuaTSdO/W6Ag=;
        b=a+o8/rNCAU77qKR7Od8MwrXZT+F1ZTfvcTj373RTODKz62bnpn2qqp/5twG9FFvhKd
         AeolZoSaBFGQKboJcHcPs4uQb4BdMexN8JGxdG4tdlIRoGTYeNye4Y+IEkNfPp7NqMTa
         LZafKP5dUpl71Wq7+9AN5Ma0aoZmF3G9Xc+JkCS3xXH1Gjqdc3QFEvSRENiuC4dW5XQR
         P4jZHuddvxpWnvOHJD2x3KIP1JZmguLTOdaQX4qeeO2rtHWlWKqr6zALxKFHyyvjN9qk
         TXYLWun3Gl11DoE+BmOJUOS+KgcwHumEHSxULnIN6oIb0yglelXBc60vVR89rG0YhGiH
         CX3g==
X-Received: by 10.70.6.161 with SMTP id c1mr84407636pda.76.1438117139922;
        Tue, 28 Jul 2015 13:58:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id jw13sm34621271pad.48.2015.07.28.13.58.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 13:58:58 -0700 (PDT)
In-Reply-To: <1438115304.18134.33.camel@twopensource.com> (David Turner's
	message of "Tue, 28 Jul 2015 16:28:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274844>

David Turner <dturner@twopensource.com> writes:

> Git checkout $branch already populates the cache-tree; this is due to
> patches I added last year:
>
> commit aecf567cbfb6ab46e82f7f5df36fb6a2dd5bee69

Heh, our mails crossed ;-)

Thanks.
