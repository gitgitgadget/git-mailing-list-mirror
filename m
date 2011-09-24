From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Sat, 24 Sep 2011 14:37:33 -0500
Message-ID: <20110924193733.GB10955@elie>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 21:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Y2j-0002X0-GF
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 21:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab1IXThj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 15:37:39 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44569 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab1IXThi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 15:37:38 -0400
Received: by yib18 with SMTP id 18so3364289yib.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T7xqqLTA20juwqPcf4JioK/Usb1TKcpmZmbRID9jBxo=;
        b=dIyljXjVoxRTTWx1vQOzqR1XqVH3LOWFfWfMT4bmozz5dDKfg74GOTarwoXLSY3F9X
         ifPqCtmitW/li/WcWbSYNwq8A0ZGRUKj1CBmRN7a0Ott2M9YEFGyBDmTkq+pR4elBjlf
         w9yd2Ap1W6tCAo3yvvPm2UfqNHrv9aEv4K0kg=
Received: by 10.236.154.5 with SMTP id g5mr30862368yhk.3.1316893058159;
        Sat, 24 Sep 2011 12:37:38 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id z53sm21944220yhj.7.2011.09.24.12.37.36
        (version=SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 12:37:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1316878065-11782-2-git-send-email-vitor.hda@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182038>

Vitor Antunes wrote:

> The drop command deletes the given branch reference, allowing
> fast-import to actively ignore it in the final checks.

Thanks.  I must have missed the earlier discussion.  What are the
semantics of this command and its intended purpose?  For example, what
happens if the branch already existed or if there is a checkpoint
(perhaps triggered by the impatient user sending SIGUSR1 to
fast-import) before the "drop" command is processed?

Jonathan
