From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] gc: reject if another gc is running, unless --force is given
Date: Sat, 3 Aug 2013 17:01:11 +0700
Message-ID: <CACsJy8Bu55BY0iUSGWS-WgZic6mkFA1oD1+UH15_PLf3+7XEvw@mail.gmail.com>
References: <1375503605-32480-1-git-send-email-pclouds@gmail.com>
 <1375510890-4728-1-git-send-email-pclouds@gmail.com> <CALkWK0k1vf_WE=pV5XTMAM6Ax6rL3sXu4qx_eyYwvWGsZjXgmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 12:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Yem-0007lt-9Y
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 12:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab3HCKBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 06:01:43 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:60000 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3HCKBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 06:01:42 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so3087657oah.23
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F2G4YUAjXpzh5WKq18u9QPnyDLdhfwUsMO5cFsSdffg=;
        b=xPnOlXPO0qzj25w78hsAT3vTER0KDiz+q/8BhCMg3eKpxy5X9BYkqfsGBHrrQprznG
         oRsiVTDvkAr68Wplwgw3cOzxF+J3BSNWS9oyZkPxUX7D6laTX9vxXBRSdcNkC4gIsKrQ
         x17DErbrTBgiC3nXnyEmnJF/wmBcBOQNWKW5uuNATYcZsZBS/Wi1x6ZryL3vM7yw8PkV
         Mi7KsQNDFNnCmgEeXvIY/1FY9QnXTdR09no227jT8r0h9rBt+pFf4FV+jMnar0Qa+H4+
         YiAzC0Ye+rqbAAknmYjpF6YxXa4G/KshEGeDtmaCR31Zsfzf9hKI7dCVXRwlIhXB/kvU
         tooA==
X-Received: by 10.60.143.68 with SMTP id sc4mr8270831oeb.24.1375524101456;
 Sat, 03 Aug 2013 03:01:41 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 3 Aug 2013 03:01:11 -0700 (PDT)
In-Reply-To: <CALkWK0k1vf_WE=pV5XTMAM6Ax6rL3sXu4qx_eyYwvWGsZjXgmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231574>

On Sat, Aug 3, 2013 at 2:52 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> +           time(NULL) - st.st_mtime <= 12 * 3600) {
>
> Quick question: is this kind of file-lifetime used anywhere else in git.git?

I don't think so.
-- 
Duy
