From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 01:09:07 -0700
Message-ID: <20130421080907.GF10429@elie.Belkin>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com>
 <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
 <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
 <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:09:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpLG-0001l4-Nk
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab3DUIJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:09:20 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43316 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab3DUIJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:09:17 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so1067924pad.6
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2WcTno8AIGWangJD0yOZ5LK80ztd0I3irScw8zqNekc=;
        b=Xk2Ptwi6hPRMzUwDuO0OarqIFKMX6wSbruY1cYgp1BQW+G+8KglqrUAuj/O35yFY1c
         7hI5k2F2TwWN4QL3v9shll6IVXcUZzK8jdDTjxJv77PZ4ZMHQruBxPIUAoGkORhStmuK
         kRtaUlMjQGJysqlldK2pDZXoxQZl+Y0OSjCpkq2xDasrhgWwGn788fx8F1kGF1K9ECix
         PPOdXnHZNDt3UfSLN3qD4xTu/jDVjkqoNhEJK+wGbaDur+cjZGE21OLt4WFmfDEYntM9
         yfLKUtbWHxADvax2KWnG3GxX4lu3yRkBcYFfdhSKxywzrSBnxnBvIuu1t8VVWkslV5Qc
         Z4aQ==
X-Received: by 10.68.135.231 with SMTP id pv7mr26335388pbb.108.1366531756564;
        Sun, 21 Apr 2013 01:09:16 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id l4sm14638869pbo.6.2013.04.21.01.09.14
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:09:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221914>

Ramkumar Ramachandra wrote:

>                       I would say the most technically accurate
> description of what 'git log' takes is a "committish range" (basically
> a "revision range" that resolves to commits).

What is a revision range that doesn't resolve to commits?  Am I wrong
in thinking revision is nothing more than a synonym for commit?

When gitrevisions(7) says "A revision parameter <rev> typically, but
not necessarily, names a commit object", I suspect it is residue from
3a45f625 trying to apologize for the extended SHA1 syntax parser being
called "git rev-parse" instead of "git object-name-parse".
