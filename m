From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help listing
 for vim
Date: Fri, 25 Jan 2013 11:23:24 +0100
Message-ID: <51025D1C.2030307@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com> <1359107034-14606-7-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:22:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TygQd-0007gB-E1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab3AYKWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:22:16 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:48313 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab3AYKWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:22:12 -0500
Received: by mail-we0-f180.google.com with SMTP id k14so98267wer.11
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 02:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:newsgroups
         :to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CRhTv86NIxC9rh3J2P0t/re7Ag4AwF2p5tO2GD8/WrU=;
        b=fTbBi+12EwZpH94MZNTpuaWBWCOuEBl8tT2O7VYAQhfE2FqmXk/rVeGpjcdCbEx8aX
         BZdmoJjkANMv4H1Dg/dc1qyn9CRkQVCJY5ZvdYRAp43Ei/+AiVqAGgz3geS04MrBAjFe
         /+X3uqhA0LJNLKibfY2lXUn1OcMT6pKSE3ozZrX0S+A7odxt+P/DIwUM7hfSJIn5xRwb
         z0Qd7rCETUAYsOo+GZCghJRuQK5o28bYeBwlROfsDM/dwKkUttYDtO2g+NiHYxoEmYA6
         F19DYKMXwLXnWLPK4gnoV/+/uArGwopQMajAJYbjfKX5aST4B4W4GY20+IkOMoTcf8sX
         JhWg==
X-Received: by 10.194.20.231 with SMTP id q7mr7831787wje.44.1359109331156;
        Fri, 25 Jan 2013 02:22:11 -0800 (PST)
Received: from Sebastians-MacBook-Pro.local ([192.100.123.82])
        by mx.google.com with ESMTPS id g2sm1074636wiy.0.2013.01.25.02.22.09
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 02:22:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1359107034-14606-7-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214537>

On 2013/01/25 10:43 , David Aguilar wrote:

> Remove the exception for "vim" and allow the scriptlets to be found
> naturally by using symlinks to a single "vimdiff" scriptlet.  This

I guess that won't work on platforms where Git does not support 
symlinks, then, like Windows. But Windows has (g)vimdiff, so loosing 
these on that platform would not be so nice.

-- 
Sebastian Schuberth
