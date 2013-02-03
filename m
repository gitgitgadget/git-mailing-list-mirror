From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 0/3] Make Git compile warning-free with Clang
Date: Sun, 3 Feb 2013 18:13:39 +0100
Message-ID: <CALWbr2wz2yEP9bBxS5UG1abtsRR-BdaP1vFLMp7JL2jwCkoFFA@mail.gmail.com>
References: <cover.1359901732.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 18:14:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U238p-0008Hh-P2
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 18:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab3BCRNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 12:13:41 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:50025 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab3BCRNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 12:13:40 -0500
Received: by mail-qa0-f42.google.com with SMTP id cr7so967418qab.15
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=cDvDcsjcyN7QJCim3Bbdp4pimKPcvnApdBUb0xHP14k=;
        b=wQl8UILyZXGL6eeT7zlTVwx2KFQrsShv/v06vhdX8LMbb8XB/3myVsjEeeIaBcve7W
         Abh6QmLFEMaH8BNgxqsg+7ZrfxYxdH/IEatORKyaEdhPfbkMAvXLUBPtVYSa3os/U1px
         r57HrVdDSQExlZpmd3gWyRjAYSRFJ5Gzmbib24/EY0S9JEgwPlH9QE/2w+qEM+xSvULL
         r9x+vDICkVzAvnaYfanbsb5OE1QpCbzrxaspwxBTrFqNb28IUEstqaIWQPIrGMwUzcM8
         b6EdXoNPfhRplCJgaIAuevNj/3GKvyxaA2Ig/SPTvrfR2xR1a5qAn+aSWuBiygW6aEZh
         /1IQ==
X-Received: by 10.224.34.195 with SMTP id m3mr17253343qad.77.1359911619680;
 Sun, 03 Feb 2013 09:13:39 -0800 (PST)
Received: by 10.49.13.200 with HTTP; Sun, 3 Feb 2013 09:13:39 -0800 (PST)
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215318>

Thanks John,
I couldn't find any time to send that "sum-up" series.

On Sun, Feb 3, 2013 at 3:37 PM, John Keeping <john@keeping.me.uk> wrote:
> The first two patches here were sent to the list before but seem to have
> got lost in the noise [1][2].  The final one is new but was prompted by
> discussion in the same thread.
