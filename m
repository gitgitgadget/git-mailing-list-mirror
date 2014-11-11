From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 9/9] t3301: Modernize
Date: Mon, 10 Nov 2014 20:07:32 -0500
Message-ID: <CAPig+cQuZ7F5OEVDJ8M-p8B5YB9YNgnNzbbNXS2Dzy6u5_rxdw@mail.gmail.com>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
	<1415536255-19961-10-git-send-email-johan@herland.net>
	<xmqqioim9498.fsf@gitster.dls.corp.google.com>
	<CALKQrgec-_9kbqba7PBFvNpCpeRAb=Pq6-OMnrJ2nw0fh_5LjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	"James H. Fisher" <jhf@trifork.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:07:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnzvl-0002tp-RV
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 02:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbaKKBHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 20:07:34 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:45394 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaKKBHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 20:07:33 -0500
Received: by mail-yh0-f54.google.com with SMTP id 29so842526yhl.41
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 17:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TxeMRMrqsB04ku+xQSjs0b2j0/9E2SN052P4dNp/vTM=;
        b=kM05qhoyRXyXF1aoiBj7LhqedH97X0X6Eu+ofYNT75hso7f8YfArNZvtzLtf9UPgRl
         dRUVBq8BL2GlV9R8u8tQ1Rt1C1+inJFWZZbt0SZTqoDQ8lle/CM32FWpWabXA7E1z7lj
         Gi7lZrJa77G+tA4rEO5mqnaryyV30u8m2/BWaAbQLbO4VX/RVX1Tnz9XUtg94/19Xf2w
         BH3iHyhGCeurg18dgEGZow4v2ZlNQnatqDFncbwz/jVyeN5BaSTQ9Qzn7hB17J/L2nbS
         olk2w+5nhfUl9H25TMkSQ1+8rk7nfTr+9bcXD1HSw0BML8+vbLVFivxp1rYqZZqnB1oe
         LAkg==
X-Received: by 10.236.53.69 with SMTP id f45mr34226058yhc.65.1415668053025;
 Mon, 10 Nov 2014 17:07:33 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Mon, 10 Nov 2014 17:07:32 -0800 (PST)
In-Reply-To: <CALKQrgec-_9kbqba7PBFvNpCpeRAb=Pq6-OMnrJ2nw0fh_5LjQ@mail.gmail.com>
X-Google-Sender-Auth: I5pP5qHY0en7b0ynFyyCwE98by4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 8:04 PM, Johan Herland <johan@herland.net> wrote:
> On Mon, Nov 10, 2014 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>>> Make this test script appear somewhat less old-fashioned:
>>>  - Use test helper functions:
>>>     - write_script
>>>     - test_commit
>>>     - test_write_lines
>>>     - test_config
>>>     - test_unconfig
>>>     - test_path_is_missing
>>>  - Remove whitespace between redirection operators and their targets.
>>>  - Move preparation of "except" files into tests.
>>
>> expect, I think (no need to resend; I've fixed it up locally).
>
> Thanks.

One further modernization would be to use the name "actual" rather
than "output" for files holding actual contents (as opposed to the
"expect" contents).
