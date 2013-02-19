From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: feature request
Date: Mon, 18 Feb 2013 22:26:25 -0500
Message-ID: <CAM9Z-n=2vWS0MXx8GWZ0UpkfDQapRcHFhWKhiVvXx5oaz=YQ4w@mail.gmail.com>
References: <BLU0-SMTP2753D5BFC50D7334EDDE278E1F40@phx.gbl>
	<CABVa4NgsbeNGS2F2jQJ5d9bDcFb4=oEVrBg_-n2eYjwnfQzMqA@mail.gmail.com>
	<20130218204511.GA27308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: James Nylen <jnylen@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Jay Townsend <townsend891@hotmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 04:26:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7dr0-0005uN-RX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 04:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151Ab3BSD00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 22:26:26 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63089 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758115Ab3BSD00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 22:26:26 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so8128890ieb.11
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 19:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=W5547wI4MM/ATW1mLM/NFjC8jK/suOjcDoTW57EJxN4=;
        b=kwO7/JDNx1MnREKZ4uqRRYA1ADrmI4dVGAodTtB4fNBGrU1Hf6ETdoRD5kHYP7YrwD
         34tCILx2QU22DooUmGH2GqB1c/DktrNnWRo69BSGP4WyFYOQMPfL8M4fMbqCdirEf9wK
         IGAtLnFnAwpTPXjVcFOGwM7Fggvx8AQv2LH/FJPxjQB06GSkQKIUY9rVXNST5AO2jUFZ
         +zkPyB5Vbft3na6AJy27gn95jkP5ZAmclheRDK3lZYOcivBuily7iqv3IGtN4f6o1PVP
         qKEWvoX5xaKJd2Q3s7jx/LWOlZXt6fsvHg6d9NfnpnfKkE8l8NSwKPjiEZgmVBrxqc93
         rDXA==
X-Received: by 10.50.15.138 with SMTP id x10mr8480195igc.16.1361244385802;
 Mon, 18 Feb 2013 19:26:25 -0800 (PST)
Received: by 10.42.173.70 with HTTP; Mon, 18 Feb 2013 19:26:25 -0800 (PST)
In-Reply-To: <20130218204511.GA27308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216555>

On Mon, Feb 18, 2013 at 3:45 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 18, 2013 at 02:54:30PM -0500, James Nylen wrote:
>> > Just would like to request a security feature to help secure peoples github
>> > accounts more by supporting 2 factor authentication like the yubikey more
>> > information can be found from this link www.yubico.com/develop/ and googles
>> > 2 factor authentication. Hope it gets implemented as I think it would make a
>> > great feature
>>
>> I like the idea, and I would probably use it if it were available.
>> Jeff, what do you think?
> [1] I don't know if Google's system is based on the Google Authenticator
>     system. But it would be great if there could be an open,
>     standards-based system for doing 2FA+cookie authentication like
>     this. I'd hate to have "the GitHub credential helper" and "the
>     Google credential helper". I'm not well-versed enough in the area to
>     know what's feasible and what the standards are.

I don't know what the specific infrastructure they (Google's
engineers) are using is (something written in python if I'm not
mistaken), but @$dayjob we've managed to authenticate to Google Apps
using SAML 1.1 & SAML2 wrappers "living" in both CAS and Shibboleth.
SAML is a standard and is supported (in whole or in part) by a lot of
systems and SSOs out there. Given the way that systems like that work
I don't see Git authenticating that way any time soon (but I've been
surprised before).

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
