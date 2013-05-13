From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH resend 0/2] git-svn: improve documentation of multiple fetch
 lines
Date: Mon, 13 May 2013 14:30:55 -0700
Message-ID: <20130513213055.GE3657@google.com>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
 <20111217100521.GA12610@elie.hsd1.il.comcast.net>
 <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
 <20111220012236.GB20979@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Gray <n8gray@n8gray.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 13 23:31:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0Ks-0007Ca-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab3EMVbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:31:02 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62562 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab3EMVbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:31:00 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so4928075pab.24
        for <git@vger.kernel.org>; Mon, 13 May 2013 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zLIPYSP/f5sNIW+1Q7Wsd7w7fZIh30wzc9/CjFif2CY=;
        b=kS/WY32QUUkYx18Wqhq5L0fhqNPUb9zyXaDR80bzILIu6Ws/zkdks4G2ZOmYvYEpng
         2ngsfq6pzCWCF8Iwl5b5Z99uHieOZpyiQ0pYn1l5eEUfURVm4ZRgXzXMil0A1EhiZnlX
         Iu+86iwf0X9YZT/E5YMUU+l1JKq+GCNykWe//kGmow0Dqh8Br/mxAMRoZCmLb8U/YXSD
         NgncJ2gNtuKdfHVJxNx826H6ogTyYiVty1kPNaVdtpsH06tpRFSi83Lghkx+CG3cf7Qi
         YXLWtqhH2UfwGgvVNPPgXtoIx35gyQi9K/muqr/vv4jncYV1zOZuik3U1ReboAaBJWJU
         43NA==
X-Received: by 10.66.252.4 with SMTP id zo4mr32062412pac.100.1368480660124;
        Mon, 13 May 2013 14:31:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wt5sm15319514pbc.38.2013.05.13.14.30.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 14:30:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111220012236.GB20979@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224210>

Hi Eric,

I last sent these patches as an RFC a year and a half or so ago[1].
Nathan seemed to like them and they still seem valid, so thought
I'd resubmit. :)

Thoughts of all kinds welcome, as always.

Jonathan Nieder (1):
  git-svn: clarify explanation of --destination argument

Nathan Gray (1):
  git-svn: multiple fetch/branches/tags keys are supported

 Documentation/git-svn.txt | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/187312/focus=187489
