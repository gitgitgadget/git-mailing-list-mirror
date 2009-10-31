From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Sun, 01 Nov 2009 00:34:33 +0100
Message-ID: <hcihi9$jkq$1@ger.gmane.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> <20091030202628.GA26513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 00:36:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4NUb-00059E-6b
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 00:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbZJaXew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933330AbZJaXew
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 19:34:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:41571 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933320AbZJaXew (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 19:34:52 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N4NTD-0004gi-Se
	for git@vger.kernel.org; Sun, 01 Nov 2009 00:34:55 +0100
Received: from 85.93.118.17 ([85.93.118.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 00:34:55 +0100
Received: from bonzini by 85.93.118.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 00:34:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 85.93.118.17
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <20091030202628.GA26513@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131863>


> So my suspicion is that there are some people who almost always want
> --new-timestamp, and some people who almost always want --old-timestamp,
> depending on their usual workflow. In which case a config option
> probably makes the most sense (but keeping the command-line to override
> the config, of course).

I'd say the config option should be per-branch (so that you can set the 
old-timestamp option only in integration branches, and not in topic 
branches), and that with such an option you could make the default be 
--new-timestamp in all three cases.

Paolo
