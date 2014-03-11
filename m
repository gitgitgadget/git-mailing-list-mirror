From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #02; Tue, 11)
Date: Wed, 12 Mar 2014 06:22:51 +0700
Message-ID: <CACsJy8D7TbjK+E5-1A4KktZF4M=1HqZ8gXGi6Eu0jNYdQ+qxvw@mail.gmail.com>
References: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 00:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNW1M-0004IO-CK
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 00:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbaCKXXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 19:23:32 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:62781 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaCKXXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 19:23:21 -0400
Received: by mail-qc0-f170.google.com with SMTP id e9so10437812qcy.15
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EYwTcTfB878XkuawCnUCQFN+/UM6bf86qCgtpQpzSCQ=;
        b=uA8yiyLyAT/rHjU37hEIqyojNxM7+nobV4m6zZwe+IP3VqR9N7nI37gAYridJcKYjJ
         4Nm3BWKc938SnWUzwsXHHzD2aoP+xLrGmqc8g2WVxmNTqbi/Wdue8w5v5P1sWrxdRu/C
         4LCUi68rQA6CEGOb/T0J67ZLSPjdLXFkAEGJLuXI+fDkxK7ZDzVJlbMFRT9VoJ+WBwmw
         fsKYFPEGQuGOatHFrAk4xnx0fAnzc1ZRC8J07ivtOIFiahA7SlP1TlZBUgID1ZEEi2nq
         BS5Yng8LjOnO/UTvYtrFEObTVOSGpqXFhhER/zFkhm7LnSgZtAw4zWGNNrWHKNzW1Tkv
         Q4mA==
X-Received: by 10.140.93.244 with SMTP id d107mr10853877qge.41.1394580201380;
 Tue, 11 Mar 2014 16:23:21 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Tue, 11 Mar 2014 16:22:51 -0700 (PDT)
In-Reply-To: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243912>

On Wed, Mar 12, 2014 at 5:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/log-show-linear-break (2014-02-10) 1 commit
>  - log: add --show-linear-break to help see non-linear history
>
>  Attempts to show where a single-strand-of-pearls break in "git log"
>  output.
>
>  Will merge to 'next'.

Hold this one. I haven't found time to check again if any rev-list
combincation may break it. The option name is coule use some
improvement too.
-- 
Duy
