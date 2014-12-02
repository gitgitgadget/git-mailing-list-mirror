From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Tue, 2 Dec 2014 18:50:59 +0700
Message-ID: <CACsJy8C9pVZ+y79WL-SqfXDMrLFmXE7Dze-jcstTAbE3khMPmg@mail.gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
 <1417335899-27307-25-git-send-email-pclouds@gmail.com> <547B5170.6050206@gmail.com>
 <20141201103818.GA20429@lanh> <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 12:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvlzS-0002Vp-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 12:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbaLBLvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 06:51:31 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37830 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbaLBLva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 06:51:30 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so10627043igi.12
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WErxaJ/wnvDDONJWQbB/ZnWkFd9Ez9FvAatB1wXGoE8=;
        b=HMHFE/hu5uOy/lC5IyHommHP7PKVRQCbQtN5YPEdtvmaRQXud0pn7S80Exb8Z1npq7
         P/q8KnWIoqfH2ulRHx2khaLLpIL5BWCTs6FwqA9TbtdL8MA6FHoqVycoawpOb5+TnQSN
         6w91NSDY1n2Io/3j7j7me6/NHPJRQTjCfNMYVD6raVZqGuPi4xSZlEmPUYL4ArwcndS9
         DyIowCbpoYNYxNyVMDC1rGvU4rVaFwvv6e9tr+ltkpqCygUjBjJtcwgl2os/a565q4Af
         nCmYS1kggpRd8hzPoTF6Bz9/zqpElLaF+Mgq2xlgBHtWqrlsxT6jI2UbuX+yvjsA2iOL
         bIVA==
X-Received: by 10.107.3.157 with SMTP id e29mr11046718ioi.44.1417521089638;
 Tue, 02 Dec 2014 03:51:29 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 03:50:59 -0800 (PST)
In-Reply-To: <xmqq1tojqnfg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260555>

On Tue, Dec 2, 2014 at 12:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, what is a hic?

Off topic. It's the sound (in Vietnamese) when you inhale through your
nose, e.g. like when you cry.. I know there's an equivalent in
English, just can't remember it now.
-- 
Duy
