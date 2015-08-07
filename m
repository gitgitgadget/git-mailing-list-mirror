From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git
Date: Fri, 07 Aug 2015 11:47:48 -0700
Message-ID: <xmqq1tffylyj.fsf@gitster.dls.corp.google.com>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
	<20150806045535.GA7014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 07 20:48:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNmge-0001T6-37
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 20:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946198AbbHGSsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 14:48:04 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36860 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946062AbbHGSru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 14:47:50 -0400
Received: by pdco4 with SMTP id o4so48118634pdc.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aBqJNwgkvcFV1QTngi2qe81kunj89VAe4UTTXexQ3uU=;
        b=EuZw0WwV8azf7icU3RaeGKVBIws0WAElHugHilf06z7pNY+hFCO6c2lHbwsyJPC3o2
         LEnD54/WQg1vftY9eokSRPHrcI9ivURjN8pOS9/yOSfGXVwAE/ilTCAor4U4EZTz15aA
         VLnvjJpzaZwixzrcpk+WvGlYVO/C9ju2j9+PIrDmB13Zntn3m/nCIU4KOY5BgpRln976
         NQqqXtwQQ1li9zw2MN/bqEZh6DGKeU4fz62B1HoSnF3r0Z5v49d4wlyCMeqCHXcrZPlS
         0i4R1jDr9KSyLMtt8XwejBmcHKVeOT3Bwrm6nin0+GGT2ZIWUFY7aee+jVPb9YGLjRiK
         OTOA==
X-Received: by 10.70.37.77 with SMTP id w13mr17622964pdj.49.1438973270428;
        Fri, 07 Aug 2015 11:47:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id bd5sm10939928pdb.41.2015.08.07.11.47.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 11:47:48 -0700 (PDT)
In-Reply-To: <20150806045535.GA7014@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 6 Aug 2015 00:55:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275480>

Jeff King <peff@peff.net> writes:

> PS I don't recall the outcome of our last discussion on the "verbose"
>    test function. Here it makes debug output for the "grep" above more
>    readable when it fails. But it also looks weird not to have the
>    matching negative one for the final grep (which could be
>    test_must_fail in this case, but we do not usually apply that to
>    non-git commands). If you would prefer to strip out the "verbose"
>    (from here and the test just below) while squashing, I am OK with
>    that.

Yeah, let's do that then.
