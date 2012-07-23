From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 3/5] difftool: Move option values into a hash
Date: Sun, 22 Jul 2012 20:49:21 -0700
Message-ID: <CAJDDKr7NA7rQ8xM-uZbboDmhwi2D4nZA2V2Qiij6h569Es9exA@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<1343014940-16439-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:50:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St9ek-0002ya-G8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab2GWDtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 23:49:23 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35354 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab2GWDtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 23:49:23 -0400
Received: by vbbff1 with SMTP id ff1so4300635vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8ft8lp9RzRuujiOXSDLj+uFLHReckv12HyucpALkEIQ=;
        b=C9/+kVO9U7HeRDkkqHWgA2Gjel4AOPV9io1DkHZzxPrcm7CyhgAmOA/Cvp1H0bjcXk
         vo/M2sTVo9unNZ+VnfB7is+eLM3T9wzy1XansHTJGLbfIrWaH+06JlCmF+pfzvoN+fWs
         DhmHhsOSGlNDmTSMcreW/abO3UlU455iImb8/SO6oqrQh1DP6PE0NmXWsXCLYwsIKC6u
         41qyVBCpYMd+Y3hmcZTdPba5Ew8uSy8ajnXfDm5X2f8V/zn3wygfz9lKTjdzl2DbkK9A
         apfEezYiI9n5e0PQ+KcSWMJjxCDxswpuLJp4d/Xi/xQAyfTxMjkcIiCVsupSAdl+A34I
         RhCw==
Received: by 10.52.174.81 with SMTP id bq17mr9852939vdc.119.1343015361100;
 Sun, 22 Jul 2012 20:49:21 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Sun, 22 Jul 2012 20:49:21 -0700 (PDT)
In-Reply-To: <1343014940-16439-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201885>

On Sun, Jul 22, 2012 at 8:42 PM, David Aguilar <davvid@gmail.com> wrote:
> ... This makes also gives us a place to specify default values

Oops, please drop the word "makes" from the commit message here if you
apply this, or I'll fix it in a re-roll if review finds other issues.

Thanks,
-- 
David
