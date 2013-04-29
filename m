From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 16:36:21 -0500
Message-ID: <CAMP44s0mHxv24GtpY2KzmrKQjZo+97FNN_T7tQk_peyWmusMWA@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7v61z5hzqg.fsf@alter.siamese.dyndns.org>
	<CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvkL-0004jX-8c
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363Ab3D2VgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:36:24 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:48603 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290Ab3D2VgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:36:23 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so5254396lbh.20
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EUu/gZh62qjU/4vXGckol9H5cWmzEncSEN7dRMVXxW0=;
        b=qe0s30mReLeryNIpPn7ktv7ewmdwO3eUhj9YuKz7gdHAZKs0x8dZ5xxW6tmkKtSpZa
         4nuA+1evHG8Dq6hdqPzYFGRRRqPuKhdhXzYKZb+Bpf4FJko/tv/8P+ieXssmfbEUIzfT
         h/Vp7M9HEtJMG+OEpsPkEEdgWmq7xUBFkJA53mBqTUbcaHJJ+2RmRuQ71MFVHTr5Olzp
         pHZd7ZCRIE7Uzr63oQh53rGKQrXJ0otB+WGMxDcBC1/xMYQM4hK6OzefMFHuGHAdK6f4
         rymkqCRFtfOkAH99cOyyYY+1C9zgeTzsV0um7t3QfBalAFV82m0sA3X98sn31BJWZKEV
         9OYQ==
X-Received: by 10.112.22.198 with SMTP id g6mr23679133lbf.135.1367271381520;
 Mon, 29 Apr 2013 14:36:21 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 14:36:21 -0700 (PDT)
In-Reply-To: <CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222868>

On Mon, Apr 29, 2013 at 3:23 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Apr 29, 2013 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
>>> remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?
>>
>> Another technical issue, even if you have reflogs.
>>
>> HEAD@{0} and @{0} are referring to two different reflogs, and means
>> different things, even though they may refer to the same commit.
>
> How? AFAICS the code substitutes @{0} with HEAD@{0}.
>
> Plus 'git show HEAD@{1}', 'git show current-branch@{1}', and 'git show
> @{1}' all show the same thing, even though 'git relog HEAD' shows a
> different commit for HEAD@{1}.

Never-mind, now I see the difference, still, I don't think it's
relevant for this patch.

-- 
Felipe Contreras
