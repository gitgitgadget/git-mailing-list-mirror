From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] refs.c: rename the transaction functions
Date: Tue, 2 Dec 2014 18:24:44 -0800
Message-ID: <20141203022444.GD6527@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
 <1417506402-24257-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:24:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvzca-0001O9-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 03:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbaLCCYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 21:24:48 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35543 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaLCCYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 21:24:47 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so12027267igd.7
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TV9ICWyT9fJ/jVKs29a5Jk+7FYhFqBcl23p1GhCPvWA=;
        b=nzmCaVvIyyfYnnt+mhru2GF+A+emCQz00Pn1EzLB75hdAhbbX4OZPMI2N7Qw1YsxBW
         AhuOWZUI/LHT9wRd93VxLw2V+s/YlJ/AnuMJECTuNu99EXxx4TDIi7XjBME+xVYK8YUe
         0+uMGe8sFzGCtqU840H4HZyq+JVcX00K1s+CqziPFnJglwPHaHEQ+nWErX6D+qhznJH7
         kqimn3+d0KRdDP52v9b8OCw27LFbQwSFm+3QHdwH6B4X2+rV0RYNip/i+0tHB6VIcs8o
         m2/nZJDF9/xUNU4Jof6Kh4FQ9zEIIlbr53L34DLrFgJkehWDXWrTwz49qj7xndn2saN5
         6gXA==
X-Received: by 10.43.129.196 with SMTP id hj4mr5437787icc.21.1417573486880;
        Tue, 02 Dec 2014 18:24:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id qc7sm6724194igb.5.2014.12.02.18.24.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 18:24:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417506402-24257-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260615>

Stefan Beller wrote:

> No changes since sending it 5 days ago.
>
>  branch.c               | 13 +++++----
>  builtin/commit.c       | 10 +++----
>  builtin/fetch.c        | 12 ++++----
>  builtin/receive-pack.c | 13 ++++-----
>  builtin/replace.c      | 10 +++----
>  builtin/tag.c          | 10 +++----
>  builtin/update-ref.c   | 26 ++++++++---------
>  fast-import.c          | 22 +++++++-------
>  refs.c                 | 78 +++++++++++++++++++++++++-------------------------
>  refs.h                 | 36 +++++++++++------------
>  sequencer.c            | 12 ++++----
>  walker.c               | 10 +++----
>  12 files changed, 126 insertions(+), 126 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
