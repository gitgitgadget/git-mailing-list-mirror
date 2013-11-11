From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Mon, 11 Nov 2013 17:50:21 -0600
Message-ID: <CAMP44s2ubU_R0GkEUpEh24TxER3uONQJprh9Ot7+PL0QiDRmDg@mail.gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:50:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg1FS-0007WO-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab3KKXuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:50:24 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:35192 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab3KKXuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:50:22 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so2087241lab.15
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WxgpaQs5nw7WiSHiB/47aEOLmC0GOaX4pRk0rTGHOUY=;
        b=nl6didtuaPQetp/5uPpq+F2qhX4FZd20ZxWn274CwTGdFrEhAVkSPuVEuslSYhcjx8
         Aq+z+Sv7eAE9vTrsN4dY01htyHNwsF0QyxCTqJk8Q4sb905uMRGZ/7GhlM3+/OjDlO4a
         yNIyEareAksftjfIB3qZc80xTP9PiHh5SyelE8z7OQtf6rqWfde94nng+bo3b13RoxFt
         Af5MdEGS4805uU9sIM2R1ygYahw37OCcCvrAzL/Hc6heWpNlQmRk9/l68T+6f92MPA07
         gPnF8gWphYYa6X1VfqWEFwLGHSWDwIsp2OWDQQ/P2jqLOdUFWCk9VievQCt0mpV7rkb9
         bjHQ==
X-Received: by 10.152.116.7 with SMTP id js7mr24864012lab.11.1384213821432;
 Mon, 11 Nov 2013 15:50:21 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 15:50:21 -0800 (PST)
In-Reply-To: <xmqqd2m6jyue.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237682>

On Mon, Nov 11, 2013 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So that we can convert the exported ref names.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> I thought that the discussion agreed this option should not be
> called --refspec but something like --refmap?

I don't know what you agreed to, but I didn't agree to anything. What
you pass to this option is a refspec, so it makes sense to name the
option --refspec.

-- 
Felipe Contreras
