From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 0/4] port upload-archive to Windows
Date: Thu, 29 Sep 2011 23:01:14 +0200
Message-ID: <CABPQNSbU01=y-Z8n5+zkhQfBZwU2M+2HhKr961gCvYBB-Mbc7A@mail.gmail.com>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 23:02:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Njz-00035U-O4
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 23:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631Ab1I2VBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 17:01:55 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64727 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab1I2VBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 17:01:54 -0400
Received: by pzk1 with SMTP id 1so2633835pzk.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=g33rHmRGAzXJdB7LRsB7pCd8QnhnVsJ0KUD3LrXsCpI=;
        b=ZtCEwWUgoUMk5AAG1V6RFfwerT88WUciL1nrSh06+BsVrX31NnNo5fQSdWCHpGXizd
         PD+MsUMJAGiXmQdKb0YamYNBFNPsSsYEWlWtlpAPuh4k57USdM+JTN8slCFvN1vb8+4F
         xupoM/atud4RwjQUTtMOvGrbre9/iYSR4DK1A=
Received: by 10.68.21.103 with SMTP id u7mr54077433pbe.129.1317330114152; Thu,
 29 Sep 2011 14:01:54 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Thu, 29 Sep 2011 14:01:14 -0700 (PDT)
In-Reply-To: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182439>

On Thu, Sep 29, 2011 at 10:59 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> It's been a while, but here's another updated version of this
> series.
>
> The only change since last time is that the series has been made
> compatible with Peff's "when remote, disable some features"
> changes.

Oh, and I forgot to mention here in the cover-letter: I dropped the
NO_MINGW-prereq from the archive --remote tests as well.
