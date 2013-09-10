From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Tue, 10 Sep 2013 11:03:13 -0700
Message-ID: <20130910180313.GE7470@google.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 20:03:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJSHZ-00077j-VK
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 20:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab3IJSDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 14:03:18 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59029 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab3IJSDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 14:03:17 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so8020166pad.23
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 11:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gpbDXT1WrTn3uGtKe04QjYjsmdPWxxPMSQ53Ay8MroA=;
        b=m+bRgSBwgHI1pkNt5nathXkXt7DTcMpLhjM+Yb2AR8ZMCQAK6wIKVAJUYquMMReEhV
         Sy8/Nn/1aaGN0spQC6gi//met10ZlJ4tEthdU2DYm+IGNiIT+aLYQBB3kHQUD8GcUd3D
         J5yLguNoXqiO9S9HbymlI97bcr7aryKvIx3ccwcLQmDg4wMg5Zt+8gUTw5y+t3QsfU0m
         JgZaDXyCnkHhs9S1hyCpoz36PnEIpLlf273rIEo++5d5yuQr6i9XFOXac9ARAth8iF+X
         zte6zQw38YvG2FNr/NevRykQovPLGWgu4dWpg56Nzj4eAPQRqTBKLZBDRjkeI4iY0nXA
         jJ8A==
X-Received: by 10.66.170.168 with SMTP id an8mr28193418pac.58.1378836197176;
        Tue, 10 Sep 2013 11:03:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vz4sm26247505pab.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 11:03:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq4n9tghk5.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234467>

Matthieu Moy wrote:

> I just noticed that the template COMMIT_EDITMSG was containing status
> hints, and that they were not particularty helpfull _during_ a commit. I
> think it would be sensible to ignore advice.statusHints and disable
> hints unconditionally when writting to COMMIT_EDITMSG.
>
> Any objection?

No objection from me.  It sounds like a good change.

Thanks,
Jonathan
