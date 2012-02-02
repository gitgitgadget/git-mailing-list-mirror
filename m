From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 2 Feb 2012 06:03:40 -0600
Message-ID: <20120202120340.GA25190@burratino>
References: <jgdgcv$h8n$1@dough.gmane.org>
 <jgdn5j$v4g$1@dough.gmane.org>
 <87haz97c2k.fsf@thomas.inf.ethz.ch>
 <4F2A70DA.6020107@native-instruments.de>
 <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Norbert Nemec <norbert.nemec@native-instruments.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 13:04:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsvOc-0007cM-65
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 13:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab2BBMED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 07:04:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39827 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2BBMEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 07:04:02 -0500
Received: by iacb35 with SMTP id b35so3053223iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 04:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nQfsYjFFukVdIxbotKAmPXg4mw9K7hqMsBBccVaheUU=;
        b=X2FZ4OlkfQuxLeda8k2V0nDo4UN183G8BgmqizCbaJXADohCuvBd3jnYXZuvvrKA4M
         COR7Sm2X5Yb8wsixwbMml5UL9wFl327hK8ojz8w/T3hWbvabCaHrfRyynkorRS3AuzKq
         1ExUzQRIOU1LNiuOx8YyIQJZVTtG1WFzstuuE=
Received: by 10.50.160.131 with SMTP id xk3mr2931482igb.19.1328184241395;
        Thu, 02 Feb 2012 04:04:01 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ko6sm19305621igc.2.2012.02.02.04.04.00
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 04:04:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189633>

David Barr wrote:

> Do the -c --cc or -m flags for git log help in this case?
> They alter the way merge diffs are presented, as described under Diff Formatting
> in the git-log(1)  man page.

I suspect Norbert was running into history simplification, so the --full-history
flag would be the relevant one.

See the thread [1] for a few relevant side-notes.

[1] http://thread.gmane.org/gmane.comp.version-control.git/188904
