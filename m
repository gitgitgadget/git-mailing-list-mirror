From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: gitk crashes when quitting gitk while it is is reading commits (was Re: gitk crashing on Windows.)
Date: Tue, 29 Jul 2008 17:15:50 +0400
Message-ID: <20080729131550.GA7008@dpotapov.dyndns.org>
References: <g6kmqf$q9p$1@ger.gmane.org> <loom.20080728T162025-946@post.gmane.org> <E7C7B8BA-6050-40DE-917C-200EAE9CA6E8@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNp4T-00080A-4j
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbYG2NP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYG2NP5
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:15:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:14886 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbYG2NP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:15:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2311182fgg.17
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Knr5e+i73vDId9lwexgxXWqe829oekqw8Suq7/dp3lE=;
        b=AAbbGw3RRTv1KQuhY9BPfbPM1L7WRVOxNf48IP/silCpUBA1vXmnFUXd9yeoGRR9ew
         19HWZf58MavhngcoyXxiOBGeocaaGgxij5++FGT2R/V1CZRxCmBqyvLJhLeNkoYVCREF
         WBw07w3bVP2btER9If3kcwDHr5IgUxwUmMF0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oxLuBdOAIkf1nxMpkiFy82/I+P78+qUPOK8+w5v/wyva92+7U2aTug8FCWjVwfmV4x
         Vgc3Zqg5Lgd/Y1WTqKQItRraBapCzT34Fcuok/H/wHSfy1jpoi47LuS+ZD4/DAUOMEr9
         u7vBGCFvGsK+p/ziLMqMyUX2jmEZxfzPLJi30=
Received: by 10.86.72.15 with SMTP id u15mr3708702fga.22.1217337354407;
        Tue, 29 Jul 2008 06:15:54 -0700 (PDT)
Received: from localhost ( [85.140.170.95])
        by mx.google.com with ESMTPS id d6sm10800706fga.2.2008.07.29.06.15.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 06:15:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E7C7B8BA-6050-40DE-917C-200EAE9CA6E8@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90636>

On Mon, Jul 28, 2008 at 09:18:35PM +0200, Steffen Prohaska wrote:
> 
> I don't think the problem is Windows-specific.  At least on Mac I am
> seeing similar problems.  When I hit CTRL-q while gitk is still reading
> the commits, it crashes with as segfault.

On Linux, when I hit CTRL-q (after a few attempts), I got this:

invalid command name ".tf.histframe.pwclist.canv"
    while executing
"$canv yview"
    (procedure "drawvisible" line 5)
    invoked from within
"drawvisible"
    (procedure "layoutmore" line 14)
    invoked from within
"layoutmore"
    (procedure "chewcommits" line 5)
    invoked from within
"chewcommits"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)
X Error of failed request:  BadWindow (invalid Window parameter)
  Major opcode of failed request:  8 (X_MapWindow)
  Resource id in failed request:  0x0
  Serial number of failed request:  2453
  Current serial number in output stream:  2456


Dmitry
