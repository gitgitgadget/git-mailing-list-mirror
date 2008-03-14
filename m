From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: builtin-status submodule summary
Date: Fri, 14 Mar 2008 22:30:51 +0800
Message-ID: <46dff0320803140730jeef5808r7da67a103ce7b171@mail.gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 15:31:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaAwr-0005yb-0i
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbYCNOa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYCNOa4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:30:56 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:35186 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbYCNOaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:30:55 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2166960ika.5
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Sg1dy3tKv/kxgDgvWrRS8No4szwIYElFfzEiyC/bCPI=;
        b=C0iuhQ31enKGdKZ0Pqa0LyF818JvVYdDohcrhaXphFm1w/8cBtpQc4b2fGZdJMlWbL/+g4eCAPsvGe/mxcp0uoS9nNNcBMjcwkPidJkI1A5ETsahgVJFR8dDsWn04KALDGltJNkSnYTb8Aqr91M8BHdPQ7TCLDQjVH2XDW7owCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W8QFTI3+0Rc5G4+MlSdZ8riz98/ANx3TyLzk9+qPPY0BPmUn3SkDAvJhgMvezENUJcQ8BG6CctUpTZ1/0F3rnzQ3/x6xeGz/cDtmh8ngmUzTQYyqUaZqUtxPlzTEFeaJkTqpMgiGjdeT1cD81aVZ77oZcdUfwKuOYa6qqN8pUZg=
Received: by 10.151.10.7 with SMTP id n7mr6372596ybi.6.1205505051662;
        Fri, 14 Mar 2008 07:30:51 -0700 (PDT)
Received: by 10.151.14.4 with HTTP; Fri, 14 Mar 2008 07:30:51 -0700 (PDT)
In-Reply-To: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77229>

On Thu, Mar 13, 2008 at 9:48 PM, Ping Yin <pkufranky@gmail.com> wrote:
> This patch series builds on top of next. It teaches builtin-status/commit
>  summary for submodules.
>
>  It contains
>       git-submodule summary: --for-status option
>       builtin-status: submodule summary support
>       builtin-status: configurable submodule summary size
>       buitin-status: Add tests for submodule summary
>
>  with diffstat
>
>   git-submodule.sh             |   17 +++++-
>   t/t7401-submodule-summary.sh |   13 ++++
>   t/t7502-status.sh            |  136 ++++++++++++++++++++++++++++++++++++++++++
>   wt-status.c                  |   38 ++++++++++++
>   4 files changed, 203 insertions(+), 1 deletions(-)
>

IMO, git submodule summary is not so useful for me if it's not
integrated into git-status. In fact i never use "git submodule
summary" directly. git-status with submodule summary support is very
useful to help user figure out what is going on in a more global level
when cooking the commit message.

So i think this series should go along with the submodule summary series.



-- 
Ping Yin
