From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 6 Feb 2012 15:13:21 -0600
Message-ID: <20120206211321.GA2949@burratino>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 <7vwr7z653f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVsT-0003Il-R3
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab2BFVN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 16:13:28 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43583 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab2BFVN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 16:13:28 -0500
Received: by ghrr11 with SMTP id r11so2841511ghr.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nUaXl85YIUj+q0z7Ts4uasYXoN1RuaYMISiOv3ZRm2w=;
        b=VCsUQnaH/+aSQuE+HkfN/7qQhmJzznxoF4R146t65sVPf+M3ElPZSGR0cCfP3qBTiS
         tDCO8E5Wu+fQsdIEtCWYhoeRV7CY5tU27S1yVaLfl1o6cFRdEbhT9Kb3585E22ZEi2cU
         6JxPu4rZt4eG9bdAfRmTXy/CfVG7nWIsTHSI8=
Received: by 10.50.236.5 with SMTP id uq5mr12501528igc.13.1328562807526;
        Mon, 06 Feb 2012 13:13:27 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nq10sm9784389igc.6.2012.02.06.13.13.26
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 13:13:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwr7z653f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190105>

Hi,

Junio C Hamano wrote:

> IIRC, the original motivation of intent-to-add "add -N" was in response to
> users who curse Git because they often forget to add new files before
> committing, and they wanted to say "Here I have a new file, it is not
> complete yet, but I do not want it left out of the commit. While my memory
> is fresh, let me tell Git to keep an eye on it, so that it can remind me
> if I forget to add the final contents."

I agree with everything up to here.  But I believe these people were
_already_ paying attention to "git status" output from the commandline
and in the editor window when they run "git commit", to notice other
changes they forgot to add, too.  I don't think this series would
inconvenience them.

Hoping I can find time to look over the other changes soon.

Thanks,
Jonathan
