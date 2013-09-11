From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 11 Sep 2013 12:07:56 -0400
Message-ID: <CAPig+cT6XmcpQLQWyC_mU0sHRGNb87QUVpzNG2HBhmOCx12KTg@mail.gmail.com>
References: <cover.1378732710.git.brad.king@kitware.com>
	<cover.1378773895.git.brad.king@kitware.com>
	<74c081c4004f3a8afb38ab15aff7d3178de4a1f8.1378773895.git.brad.king@kitware.com>
	<CAPig+cQ=PSQbF4+YfZC-Ps2Te47VNTRm_yDTVY48vGh4G2UFgQ@mail.gmail.com>
	<523063D7.7000305@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:08:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJmxa-0001qx-BT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141Ab3IKQH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:07:59 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:41032 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840Ab3IKQH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:07:58 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so7542219lab.2
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 09:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iGInVN1xZDVO47jyH51SmUYBIFwUrlwJSObjbtFswb0=;
        b=Lw1K8eeVQbhsh+xT2OCMXM7hpVLLflGXgAfiZGA12YMSWBmXtYF97zvfItpLBRg86l
         D/2Lqxcv55ZdSd9grPbajii/6h2p45YUxliB6ctFyIJLGR5UBAoYQS/crLpiW2sWuQOO
         pB2/eCIxI9wunHsxlk319i/eGr657Q0vu9UB9xbfbq+/QBX2bc5KF19NDfQ8zB9JrHOh
         xAXwZRLv2KoK7gnHqmXh6vSOpm1W9xZld+VAr0pMMSdArM/czJBUVfoVrdOogE36v5f/
         SdSzQ+VstNBRJ0GDlltskrh2Cxl1cRPWUmYqL8iHulKf1Q/C1tTJti568D0CPR9uInp/
         1eZQ==
X-Received: by 10.112.51.166 with SMTP id l6mr3288315lbo.5.1378915676587; Wed,
 11 Sep 2013 09:07:56 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Wed, 11 Sep 2013 09:07:56 -0700 (PDT)
In-Reply-To: <523063D7.7000305@kitware.com>
X-Google-Sender-Auth: q-3EH-pnpWsVIuvGtDUvIa3SpHE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234572>

On Wed, Sep 11, 2013 at 8:36 AM, Brad King <brad.king@kitware.com> wrote:
> On 09/10/2013 06:51 PM, Eric Sunshine wrote:
>> On Mon, Sep 9, 2013 at 8:57 PM, Brad King <brad.king@kitware.com> wrote:
>>> +Use 40 "0" or the empty string to specify a zero value, except that
>>
>> Did you want an 's' after the "0"?
>
> The same description without 's' already appears in git-update-ref.txt
> above this location in the existing documentation of the command-line

Thanks for the explanation. (I could have checked the surrounding text
but didn't think to do so.)

> option behavior.  I see 0{40} in git-receive-pack.txt and also in
> howto/update-hook-example.txt.  Perhaps a follow-up change can be made
> to choose a consistent way to describe 40 0s.
>
> -Brad
