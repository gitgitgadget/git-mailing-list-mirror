From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/6] A smoother transition plan for cvsimport
Date: Sun, 13 Jan 2013 23:47:41 -0800
Message-ID: <20130114074741.GM3125@elie.Belkin>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 08:48:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuem7-0004gF-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab3ANHrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:47:47 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:39888 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab3ANHrr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:47:47 -0500
Received: by mail-pb0-f47.google.com with SMTP id un1so2012905pbc.20
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 23:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PR0CIHDLIIS1DDRiX0yB43IgYZRupN9a2ePmjzo3p6g=;
        b=eBl0wlWONBGQeLr+Geg4SXLW+Fp7O5y/dA/HgjCJQcHWNigqsuNtfFptQl/lzz4n+1
         Ye92HGEz5V3Eq9v98d4kdccOEVtNKbas5kXSfAEUZmA5VmmVXNerJZQQ9Dj3hCcHE+9n
         6g6qWETfZOSXfd09eOxXrpwOsk+pvwOkgid3BhdyLb1JAaCpnGPZpEsrZmDPnh2ZUY9X
         8lCmDHlq2nXZPkJHtEVYuApAkBjeffy3zE3wS0baSLAeTg+YdeXqX9U+CfmIcZwtqYgv
         b83l4YtDHvS2TLah3KL2gx5OaKQKtvRiVEyylQ8bHCroFn748j5wHPQldjL3/1JRbdM2
         53eA==
X-Received: by 10.68.143.162 with SMTP id sf2mr251456127pbb.137.1358149666454;
        Sun, 13 Jan 2013 23:47:46 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id pl10sm7754384pbc.60.2013.01.13.23.47.44
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 23:47:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213466>

Junio C Hamano wrote:

> Junio C Hamano (6):
>   Makefile: add description on PERL/PYTHON_PATH
>   cvsimport: allow setting a custom cvsps (2.x) program name
>   cvsimport: introduce a version-switch wrapper
>   cvsimport: start adding cvsps 3.x support
>   cvsimport: make tests reusable for cvsimport-3
>   cvsimport-3: add a sample test

Looks very sane.
