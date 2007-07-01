From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: t7004-tag.sh fails (old gpg?)
Date: Sun, 1 Jul 2007 18:06:06 +0200
Message-ID: <1b46aba20707010906s5b515419q48247801efe80515@mail.gmail.com>
References: <20070701124953.GH7969MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0707011507310.4438@racer.site>
	 <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 01 18:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I51wL-0001ku-Mw
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbXGAQGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbXGAQGI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:06:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:61816 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbXGAQGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:06:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1970445wah
        for <git@vger.kernel.org>; Sun, 01 Jul 2007 09:06:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kmXsm3x9Wv20WshVThfLdvFR+FyAHDaEx8HF3ZNQ/JBwMa3daqcNEyH7dnQMqjpecz1fyu6Tt1FxjBDSP8OYC3HljqDYoE0EeKNvJxMBGEzQXeEMDGP9mXv2rUJDPowfufNdJ8T3gIHVQrwbm53p07SZ9BXLx7befFcKnai8qnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+ozQcuh6QvzXgh4dyo8Pz/cdXHAHWyN8hiLNif4fhU9rIaNhwmr966T4d7SOvfUH8QjAxSoO92erqzzKXiflOdmdHdchkKMBPtfN5mEiJCJfI/oKDkMA/UqLbxl5NUUTqWru2dUIussHgI0RPp7ztXD93GKvUic/xM607Ilvjs=
Received: by 10.114.80.4 with SMTP id d4mr4366453wab.1183305966882;
        Sun, 01 Jul 2007 09:06:06 -0700 (PDT)
Received: by 10.114.61.17 with HTTP; Sun, 1 Jul 2007 09:06:06 -0700 (PDT)
In-Reply-To: <20070701153443.GI7969MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51305>

> > On Sun, 1 Jul 2007, Sven Verdoolaege wrote:
> >
> > > gpg: Warning: using insecure memory!
> > > gpg: [don't know]: invalid packet (ctb=00)
> > > gpg: read_keyblock: read error: invalid packet
> > > gpg: enum_keyblocks failed: invalid keyring
> > > gpg: skipped `C O Mitter <committer@example.com>': invalid keyring
> > > gpg: signing failed: invalid keyring

I don't know if it could be due to the deleted t/t7004/trustdb.gpg file,
you can check the same including it (if you didn't get it already):
http://article.gmane.org/gmane.comp.version-control.git/51271

Can you verify the other tags, like those from Junio on each version?
