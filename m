From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 18/19] setup.c: document get_pathspec()
Date: Fri, 28 Dec 2012 20:40:41 +0000
Message-ID: <CAOkDyE-UXGhe1aiWy_1_y7cvrmfvivSBxY9LHudOmeZD=M-12A@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-19-git-send-email-git@adamspiers.org>
	<7v7go1j4ml.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:41:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Togjp-0001dz-FF
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2L1Ukr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:40:47 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:65369 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab2L1Ukn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:40:43 -0500
Received: by mail-we0-f175.google.com with SMTP id z53so5203622wey.34
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=QZMeiPXisGxYuhHXp5iSSWi/T74K54QtiySSuoPHNMo=;
        b=kiXfud+CY06bJwTKQ+6SXPVuaDXhMC2LBXhkss6nMzfUbCfTMPEZSlY0KYlSuvh5RM
         nwBUWETW0Wl45R2o+gDNeb1+FBtIsd+oJX9WP3ZBso18x62H7Wd8cg05cCsMeNmnNXQi
         p8s7mdVzqSKmKPbtxeZKcelL4vSgJv+wZuPzexrBpos70jonJqW0Kgssfv7056WaP9rl
         Vzfc66dZyWHnpGyn1IbaI1dpHiYnj5sYQfIo+H76ZTngYuuMn0g8/eJkSeWurI5jU+hb
         +MqlwDKuDhufli3smkXqWhOQyThhT+vN+hdH+Zpkn0Bq5X44BUzFgxnVxFZ6xmM7xD6a
         xiWg==
Received: by 10.180.101.104 with SMTP id ff8mr53858915wib.11.1356727241908;
 Fri, 28 Dec 2012 12:40:41 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 12:40:41 -0800 (PST)
In-Reply-To: <7v7go1j4ml.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 6L2PNgPrmXQbaMHcGINUreMMkjo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212260>

On Fri, Dec 28, 2012 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> Since we have just created a new pathspec-handling library, now is a
>> good time to add some comments explaining get_pathspec().
>>
>> Signed-off-by: Adam Spiers <git@adamspiers.org>
>> ---
>
> Yes, but we would rather not to see new users of this function added
> to our codebase in its current form, as explained in the nearby
> comment.  We would want to migrate everybody to "struct pathspec"
> based interface to support magic pathspecs in the longer term.

I see.  Please feel free to drop that patch from the series or amend
as you see fit.
