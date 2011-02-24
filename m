From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 15:23:59 -0600
Message-ID: <20110224212358.GF17412@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142841.GD15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 22:24:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsifV-0001wv-Vy
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 22:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab1BXVYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 16:24:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62571 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab1BXVYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 16:24:06 -0500
Received: by wyg36 with SMTP id 36so990496wyg.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YcrZDVX/4zrm9BDRCPWzu0dqKneBQkP85LcSW46g3e8=;
        b=kBY2HQlHAwSdm7pOWY+duXo4kgkz5pCpbBf4SNDIoGZLqAjV0jqogy6m4oic/q4sn+
         Yx1+7MmQKTfLc3FS14L0SCbyIoQsHlnjW4BeTHOHvqQj6HOowZz7lSpN43EEpAhoGakv
         pqezAKslko+uDV+c+YsUtSRY+bYRwukXSAPnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bdsYG0yY8Tv59Obvq5D2Fki2LC+WtjFQa5U4kvirCSiGcVuvzlqPWHia3OO1YH0GsW
         yt3uMn/WvoNZs6hlSekC4GptMstq+pNN+R+e/9DTW7yBv0YscD3u7FpfKDjRzst/c6hT
         j2sR4ffHm0mfZLnLp0QjfxzgbIp/MvNJIGdOM=
Received: by 10.216.177.9 with SMTP id c9mr1321670wem.34.1298582644995;
        Thu, 24 Feb 2011 13:24:04 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id r38sm4017261weq.47.2011.02.24.13.24.03
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 13:24:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110224142841.GD15477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167864>

Jeff King wrote:

> However, we still maintain
> the trace_printf interface so that existing callers do not
> need to be refactored.

Hmm, so trace_printf means "trace exec, notes_merge, and
RUNTIME_PREFIX"?
