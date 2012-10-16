From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: feature request
Date: Tue, 16 Oct 2012 19:27:26 +0200
Message-ID: <CAB9Jk9DaJnN9wmzi-4P3+PqBOobOapnU50y5zkKV9-1CNpV3Yw@mail.gmail.com>
References: <CAB9Jk9AwTVM4TPwPg1Gmi8TCnnXWUsMAfaz8DdfcEhBNW_15Ug@mail.gmail.com>
	<CAH5451=1VU6oUzAyGXZvOW-Pk3+Os1mq1neum572venNjRfT+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOAvh-0007X2-QY
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab2JPR1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:27:32 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55892 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab2JPR11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:27:27 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so6815445vbb.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 10:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D9WII8O79CVFAUTCdVDoUQTc4/s8ln5H9PsVF0fD32k=;
        b=a/b6fU4UFSlduW+kG4zFeYgu+DQWMlLkh1i0lZWai5M0fNuGGZV744K9BqTRDqwAtX
         38cVORB17FM5oKCRoJiSlOaCA1bp8dILMayEaCDQozNF5J8Q2bIYl6vXRq6YyOlx8Vmy
         fmS+NFfAzXcHrH6Z/CHy0YeVvWHzXv2uGAFF40I+f3sa8N8+PMCMd7H+4XdjDV8Jl/5G
         I2l1gVH29J/makxhrgLQ12bTq8fKNB2Y6h4htI6Ok1y/tLBEoRF/ftncYG7rluQXA3F8
         mipD7s8fIA8+7FkRZ2WgWCCCtw7KXKmfTkr/OaeUyQa/dL2vujmrhUmw4YVZgtxh47+7
         BbsQ==
Received: by 10.58.189.33 with SMTP id gf1mr9363186vec.41.1350408446677; Tue,
 16 Oct 2012 10:27:26 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 16 Oct 2012 10:27:26 -0700 (PDT)
In-Reply-To: <CAH5451=1VU6oUzAyGXZvOW-Pk3+Os1mq1neum572venNjRfT+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207860>

Hi Andrew,

one nice thing is to warn a developer that wants to modify a source
file, that there is somebody else changing it beforehand. It is nicer
than discovering that at push time.
Take into account that there are changes in files that may be
incompatible to each other, or that can be amenable to be
automatically merged producing wrong results. So, knowing it could
help.

-Angelo
