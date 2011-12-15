From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Improve git-bundle builtin
Date: Thu, 15 Dec 2011 14:54:56 -0600
Message-ID: <20111215205340.GA16160@elie.hsd1.il.comcast.net>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <1323967528-10537-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 21:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIKh-0006lS-Rf
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 21:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759350Ab1LOUzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 15:55:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53011 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1LOUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 15:55:07 -0500
Received: by wgbdr13 with SMTP id dr13so4695957wgb.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 12:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G5fpqJeF6daWuqCMOPpgQNQsKjdnnAyxCAaLGV4joPY=;
        b=eXutfzAislPJp5sfHwsCiIqW768oozwRb+SzOaruVUsfqMpWDqdW+5vBdgQsoHUr+/
         6hheS5uiU4iIBZwr0oUvTt5NMEKkaCfBlLMMNx9ykojtCtzoOiU/nWzIPFkx5UM/3zwz
         ZPtOl489L9lI0L0hBOynO27bZXo0BjuDiTKhQ=
Received: by 10.216.138.76 with SMTP id z54mr1677208wei.17.1323982506467;
        Thu, 15 Dec 2011 12:55:06 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b5sm11232867wbh.4.2011.12.15.12.55.03
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 12:55:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323967528-10537-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187230>

Hi Ram,

Ramkumar Ramachandra wrote:

> 1. There's a SP between the OBJID and the ref name in list-heads as
> opposed to the TAB used by other git commands such as ls-remote,
> diff-tree.  Will fixing it break someone's parser somewhere?

I don't know.  Would there be any advantage at all to changing the
output format of the tool?  Bad idea.

If the goal is to avoid confusion, perhaps a note in the documentation
would help.

> 2. Is it worth fixing the "--stdin" tests?  What is the usecase?

Is "script that wants to list which revs to bundle, possibly exceeding
the command-line length limit" not enough of a use case?  Yes, I think
it is very much worth fixing.

Thanks for looking at this.
Jonathan
