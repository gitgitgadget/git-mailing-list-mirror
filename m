From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Thu, 21 May 2015 16:00:47 +0200
Message-ID: <CAP8UFD2iOUH-dJAUJvoQTS_BxJU-9ZrmjaBHutUPVc_=_u71GQ@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Thu May 21 16:01:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvR1p-00046M-Nc
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 16:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbbEUOAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 10:00:49 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36655 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbbEUOAs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 10:00:48 -0400
Received: by wizk4 with SMTP id k4so15962174wiz.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mAkuG5DlZrgD9wxeNHS3vUrtheMMgtz4YTmICbRyUP4=;
        b=i+ofyKy2JaT0lt+vVZ0fFvqAU97Vjeig6UKUrEigQP6DsgRo0pcke6eQg9G166byEA
         F4vx6NEwpju8YGm/2ELMeFn3QnPGi89U+WxvXPAfaQx7FqcyaG+MhEW+BwBz8QaMF2s/
         5ICGV8cmtiQV20YlqxDAOxXDNFqbB06NW9ZLvWHAabBIlSdrfTZ0u1ncpDzssV5WAt4V
         fHlMqUTPdw7DZgtUTWi5Bj26QdMOg4YHJf15ZApPqtxZNOFXGaKvb1gNDX32neHASxC1
         4CJLHFhjy/HpiJDMv07WqDIzAkbaNzbOrqPg1L1uzKVyZjxz5phKXYce9UefkA9jmOLe
         5p5A==
X-Received: by 10.180.105.38 with SMTP id gj6mr6511552wib.90.1432216847495;
 Thu, 21 May 2015 07:00:47 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Thu, 21 May 2015 07:00:47 -0700 (PDT)
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269594>

On Thu, May 21, 2015 at 3:13 PM,  <steve.norman@thomsonreuters.com> wrote:

[...]

> So the questions are:
>
> 1) Should I expect a clone to NFS to be that much slower?
> 2) Is there anything I could do to speed it up (I've tried --bare as that is what the repositories will be when stored on NFS and there wasn't really a difference).
> 3) What else can I use in git to compare the performance on local to NFS to see if it is just clones that are affected?
> 4) I assume I could bisect between 1.8.4.1 and 1.8.4.2 to find exactly where things get worse for me?

Yeah, it would be very nice if you could bisect further.
You can probably do it automatically using a script such as the one
Junio used in this email:

http://thread.gmane.org/gmane.comp.version-control.git/45195/

Thanks,
Christian.
