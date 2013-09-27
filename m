From: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: git rebase is confused about commits w/o textual changes (e.g.
 chmod's)
Date: Sat, 28 Sep 2013 02:32:44 +0300
Message-ID: <20130928023244.1ce16dc5@x34f>
References: <20130924225648.48af3f4e@x34f>
	<20130927222807.GA18384@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Sep 28 01:32:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPhWo-0002fl-8z
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 01:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab3I0Xcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 19:32:50 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:52266 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab3I0Xct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 19:32:49 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so1495694eei.35
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=H/CzYaCy8JsuQrKmqN3DoLLzzD+Wd4rkns8DucFMBFg=;
        b=R64JcJL7TAlUE3UyVybE2cRSkz+7gjquTZZhvRdMtosw7Yntfq5oN7yh0J+piyOSVc
         nsuroVGZY5W5xyIju2WY50Ek6QskTOZllCwwe4w7X+Wzy9yvCzybT5BdgvuDaQ6DlbW4
         /gRhCnniSI9W5WJ7L54PlFzvt/LJylruszPqaMOz1rh4+ne5r88XDrqIDFCBp0SzyQ1c
         f+H/mxivU8l7dhxMr/KDkc5hA7sCWjDFBoYg5DLnqQXh8NIxeIuUxAUDfzCzje2M1fq6
         5Tx0psaOvlP0OF6OT77ZsvFYnIoNEm1d9OknYIL1AEoY5Ru9Nql554cTzXyFhM5OfLay
         al/Q==
X-Received: by 10.14.109.66 with SMTP id r42mr14333619eeg.43.1380324767966;
        Fri, 27 Sep 2013 16:32:47 -0700 (PDT)
Received: from x34f ([95.15.182.200])
        by mx.google.com with ESMTPSA id j7sm21247250eeo.15.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 16:32:47 -0700 (PDT)
In-Reply-To: <20130927222807.GA18384@vauxhall.crustytoothpaste.net>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235479>

Hello Brian,

On Fri, 27 Sep 2013 22:28:07 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> On Tue, Sep 24, 2013 at 10:56:48PM +0300, Paul Sokolovsky wrote:
> > Hello,
> > 
> > git rebase is confused about commits like
> > https://github.com/pfalcon/civetweb/commit/ce8493837bf7676c6d824cdcb1d5e3a7ed476fe1
> > - it stops, telling user to just run rebase --continue. I remember
[]

> 
> I'm interested in solving this, but I can't seem to reproduce it with
> the following script.  Can you provide more information about which
> branches specifically you were using (as well as which git version)
> so I can reproduce the problem and look into fixing it?

Thanks for your reply - I wondered if my message went thru (I'm not
subscribed to the list). I'm running:

$ git --version
git version 1.8.4

Specifically from Ubuntu PPA:
http://ppa.launchpad.net/git-core/ppa/ubuntu


Script to reproduce the issue is:
https://gist.github.com/pfalcon/6736632 , based on a real-world case of
merging histories of a fork created from a flat tree snapshot with
the original project it was created from.


Thanks,
 Paul                          mailto:pmiscml@gmail.com
