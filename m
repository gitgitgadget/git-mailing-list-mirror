From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 15:38:40 -0500
Message-ID: <CAMP44s044amTqdshNAm=EaT1UgEtKU6yLWAxsk3GwCcX+GQKxQ@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7va9ohhzsi.fsf@alter.siamese.dyndns.org>
	<CAMP44s3ghzcfTthEEYZgr7ydJFUeA5xKyAxgR1JUYVtWG7f=qg@mail.gmail.com>
	<7v1u9thyq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 22:38:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWuqU-00084S-1D
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 22:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab3D2Uim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 16:38:42 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:65324 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab3D2Uil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 16:38:41 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so2145542lab.38
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Al8FKbnPCEnheVuYpe9v9a9aFNRVj+MqlCzR6WYNTVg=;
        b=z2ZV7CzNw5QU1oTBnn2Q/JJxFwqS+Yj7FEM0JX69QvATH/x3SL4XcX8XRCp6JB5ZWj
         cJ0CoiI8ipmi8ktxgn69E2VQMcDKP1CEU1lKu1GSNNcRSUhzWKJu5UTgdoCiXGks5sMM
         Hww8RWTnRNu3cYn0eM3I5K0O4KR4S/JklzfPO/eMIxi9rbnO7Hol5Ohz2yCwhy5C0aSQ
         cvi1HYrdkMdi266t+vyNuuyoSE1o3dqeOEu5TNDW3shOj1zNVrxAaz/0ePaG4rme4G/5
         Xf0X+575gVa540G3rErs1b4168ItcbNdUIu5ZxftrY4viKCTTsW5TVCEg6+SJxZdQyr/
         vhBQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr26152880lbb.8.1367267920094;
 Mon, 29 Apr 2013 13:38:40 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 13:38:40 -0700 (PDT)
In-Reply-To: <7v1u9thyq9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222861>

On Mon, Apr 29, 2013 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> But @ is not used just for reflogs, there's @{now}, @{-1}, @{upstream}.
>
> True.  @{now} is a reflog, @{-1} is also but @{u} is not.  It is a
> kitchen sink and you shouldn't have to have reflog on a branch in
> order to use @{upstream} (I didn't check---I wouldn't be surprised
> if the code for @{u} is buggy and barfed).

It shouldn't matter if @{u} is buggy or not (which I doubt), @ is
basically @{nothing}, or @{same-commit}, whether a reflog is present
or not doesn't really matter. HEAD@ -> HEAD, master@ -> master, and so
on.

-- 
Felipe Contreras
