From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 20:08:21 +0200
Message-ID: <49E62295.3070100@op5.se>
References: <1239797816-24582-1-git-send-email-ae@op5.se> <49E5D372.1090504@drmicha.warpmail.net> <49E5E8C5.4050501@op5.se> <7viql5vnqd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:10:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu9Yf-0007MP-0L
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 20:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbZDOSI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 14:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZDOSIZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 14:08:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:29625 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbZDOSIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 14:08:24 -0400
Received: by fg-out-1718.google.com with SMTP id e12so7761fga.17
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 11:08:23 -0700 (PDT)
Received: by 10.86.3.4 with SMTP id 4mr354750fgc.66.1239818903305;
        Wed, 15 Apr 2009 11:08:23 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm11557445fge.3.2009.04.15.11.08.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 11:08:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7viql5vnqd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116642>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> The reason for this patch is that we published some repositories publicly
>> a week or two ago and one such malicious person started attacking all our
>> public servers with the usernames found in the commit messages.
> 
> Interesting.  Do you also worry about the names on committer and author
> lines?

We don't refuse anyone who's allowed to push by file-permissions. Perhaps
we should, but we don't. This was discovered as a nasty after-shock, and
"unfortunately" a bunch of people are already working with the commits
exposed by the code. Since we're not really affected at all by the bad
parts of the code, we've decided not to bother rewriting history. We'd
rather keep life simple for our contributors (we're not as lively a
community as git, so we can't afford to lose half a dozen just to protect
ourselves; It's better to just alter those usernames and keep going with
the history we've got).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
