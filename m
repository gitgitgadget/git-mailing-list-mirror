From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] git-svn: add support for --first-parent
Date: Thu, 6 Sep 2007 09:18:30 +0200
Message-ID: <8c5c35580709060018p50398071s32b271d52f4dc7e3@mail.gmail.com>
References: <1188984929315-git-send-email-hjemli@gmail.com>
	 <20070905101929.GB11074@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 09:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITBdN-0006D7-27
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 09:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbXIFHSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 03:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbXIFHSc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 03:18:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:46046 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbXIFHSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 03:18:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so87096wah
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 00:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VrukOK1JFZuxod6caueJef2JjsKdF3XxWjzXDalNWn4=;
        b=RryDv+2rWDpOw7LkQKbyVCwn5v67uLH2JyKK0M+H3h6UFKp0nF0UK1vw5k+EGqcLZxKTuWVR/+a+xZq5Be7kkdxOomty6SPB1fPDlfI74DNzIS7YssSWAuFiYmbf3x2/6ZJmdnOzfwiRz5Gri0ReqA25BfOlF9s6xQ7ltwOThOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K2XZN3TmeMAGkS/5RxVlsptVNBjtA3hM7+rfSTBqZDw4FmyRMbaNDsCmq0ZbfCoRNKQIw6YBtesoPyHbbaaAcMbvb9jV3RlbKpsHnUsWEAI2bdi5/xvMT62bH3MiuFPWNWYjp369SbB9KD+J4aoGCNOt4X4GfWzP+VfE0Onwb3s=
Received: by 10.114.169.2 with SMTP id r2mr40246wae.1189063110242;
        Thu, 06 Sep 2007 00:18:30 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Thu, 6 Sep 2007 00:18:30 -0700 (PDT)
In-Reply-To: <20070905101929.GB11074@soma>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57836>

On 9/5/07, Eric Wong <normalperson@yhbt.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > When git-svn uses git-log to find embedded 'git-svn-id'-lines in commit
> > messages, it can get confused when local history contains merges with
> > other git-svn branches. But if --first-parent is supplied to git-log,
> > working_head_info() will only see 'branch-local' commits and thus the
> > first commit containing a 'git-svn-id' line should refer to the correct
> > subversion branch.
>
> Ideally, we'd probably stop, say something and give the user the choice
> of branches if multiple parents available.

Could you elaborate? (I don't understand how following the first
parent of a merge could end up at the wrong svn branch)

--
larsh
