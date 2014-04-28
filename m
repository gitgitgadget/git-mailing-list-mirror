From: enzodicicco@gmail.com
Subject: Reference to a commit inside a commit message
Date: Mon, 28 Apr 2014 20:35:52 +0200
Message-ID: <20140428183552.GA9709@workstation.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:45:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerUF-000689-Pi
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773AbaD1TpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:45:04 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:59067 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbaD1TpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:45:01 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so5150048eek.24
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        bh=7Bzog8B3lpI7BqMM/ihJ+dDHU6yj2AV8CBq7YRAmQ5k=;
        b=WpDs9szqWbaFTJG0e2oQ+NEvgR5Mzqs73+BMCX4aJf76GauOBaK0XDQd1Gz+og94KK
         swc0ZcGuIEm+A3x0QQWH0B6K520eACVairNNI1Bw5iHcJA4O2L/8XgXIn9N34Nirt/P+
         zOHwI+/81KooO5ntg2yErbiQYGLpPBN3EoxQBLPkh6blx4qvIWq6i1FHvBn2GeuIT+MU
         IXrD3o120/dQn447kLrq1WjEo98x92zrTgswCqoPvKPCY7YdISLjbm8Lkrvb1FVumLtu
         UxmnazQFfs6yTzWI0ThGFrqfqPwEJsKd2DoxgCFessroZnyR408Jj8I61NA6tbJts9ee
         uMLg==
X-Received: by 10.14.194.133 with SMTP id m5mr34848245een.38.1398710279937;
        Mon, 28 Apr 2014 11:37:59 -0700 (PDT)
Received: from workstation.Belkin (ppp-141-16.15-151.iol.it. [151.15.16.141])
        by mx.google.com with ESMTPSA id u46sm52477096eel.1.2014.04.28.11.37.58
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 11:37:58 -0700 (PDT)
X-Google-Original-From: nan@workstation.Belkin
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247421>

Hi to all, I'm trying to figure out what is the best way (and if it exists) to link a message of a commit to another commit.
I start by saying I don't know Git very well so maybe this question can be very trival for someone but I've googled and searched into the Mailing List with little success.

The goal would be to be able to refer to a specific commit (or a set of it) through its Hash in order to justify some actions done in a commit, mantaining the message compact.

Obviously I don't mean to put the raw Hash, rather I would be happy to find a way to automatize the visits and the insertions of the commits inside the message.

What I mean is  what Gitweb do, naturally adapted for the use of Git through shell.

For example, thinking about it, I've imagined to add this feature to `git commit`:

    git commit --see-also <commit1> <commit2> ...

that adds a label (like "Signed-off-by") such as:

    See-also:
        1: <commit 1>
        2: <commit 2>
        ...

And, to other side, `git show` could have a feature like this:

    git show <commit> --see-also 1

that simply call `git show <commit-1>`.

So, there is a better way to obtain a behaviour like this?
Has ever been discussed the possibility of implementing a similar feature? and There is a way to handle a similar behaviour through Hooks?

Thanks to all,
NaN
