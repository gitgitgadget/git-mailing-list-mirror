From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How can I download a git commit as a diff patch?
Date: Wed, 30 Sep 2009 22:40:16 +0200
Message-ID: <200909302240.17729.jnareb@gmail.com>
References: <20090930154410.GA31502@thumper2> <m3tyyk9ost.fsf@localhost.localdomain> <20090930202527.GB22159@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alejandro Riveira =?iso-8859-1?q?Fern=E1ndez?= 
	<ariveira@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>,
	Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753949AbZI3Ukf@vger.kernel.org Wed Sep 30 22:40:55 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753949AbZI3Ukf@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt5yo-00027Q-6k
	for glk-linux-kernel-3@lo.gmane.org; Wed, 30 Sep 2009 22:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbZI3Ukf (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 30 Sep 2009 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbZI3Uke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Sep 2009 16:40:34 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:65312 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZI3Ukd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Sep 2009 16:40:33 -0400
Received: by bwz6 with SMTP id 6so3129817bwz.37
        for <multiple recipients>; Wed, 30 Sep 2009 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lg34p0HjyF8f0Q1pddojnQcA2CDDbuGAuhP0dau1KxY=;
        b=x67nZZTb3K6OU0wQTQw20OAnZNkWnUz9trZliRMp1KRiqyu2KNCbOP4BtlYY019vSg
         CkO671UKitD5dmXdLP1mwvO45Z4GwWOM02T5o85obJyuZnwx6QrTTgGvwNdy3sEYJNTk
         RZYz4+5y5S4PiTzNqikp+bkw0AlzXzpK6MYfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GLKdyGSKW7F8dC6irxZ3wwYm/WI7zHl/vvtfz1igO6WwFpE4vfyczftpFzLKvTSMYW
         dP0S685A8QkZPgbxBDY/wANpd3q8PUlMiNyroBUa8lCZhzHU/4Sa2tZlBw17rxBcVH1R
         +RfMNE3xBcAujTeFbq/ZOwPywbGB0D1DmTatU=
Received: by 10.204.10.143 with SMTP id p15mr203950bkp.167.1254343235833;
        Wed, 30 Sep 2009 13:40:35 -0700 (PDT)
Received: from ?192.168.1.13? (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id d13sm1844888fka.22.2009.09.30.13.40.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 13:40:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090930202527.GB22159@csclub.uwaterloo.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129356>

On Wed, 30 Sep 2009, Lennart Sorensen wrote:
> On Wed, Sep 30, 2009 at 01:10:51PM -0700, Jakub Narebski wrote:

> > Or better yet, if given installation of gitweb supports it, on the
> > 'patch' link just on the right of 'raw' view.  Such patch can be
> > applied better by git-am (but both should work for GNU patch or
> > git-apply).
> > 
> > Yes, by default for merges the 'commitdiff' view (and the 'raw'
> > version, i.e. 'commitdiff_plain' view) shows **combined** diff of
> > changes brought by merge (see git-diff manpage for details on this
> > format).
> > 
> > For merge commit you have to choose which of parents you want to have
> > diff from.  Go to 'commit' view, there in the header would be two or
> > more parents.  Click on the 'diff' link beside chosen parent, check if
> > it is the diff you want to get, and then click on 'patch' (or 'raw')
> > link.
> 
> Is there a git command to show me a diff I can use with patch if I want to
> select a given patch as long as I can tell it which tree I want to follow?
> I don't care to use gitweb if I can do it with the command line git.

You can specify parent explicitely: "git diff <rev>^1 <rev>" for diff
to first parent, e.g. "git diff HEAD^ HEAD".

> 
> git show obviously shows the git combined diff format, at least by default.
> 
> Or is the idea of trying to use the diff from the merge commit just
> silly in the first place?

Just so you know that this single diff is not enough to redo a merge.
It is only partial information.


BTW. there is also "git diff-tree -m <rev>") to show diff to *all*
parents at once:

    -m    By default, `git-diff-tree --stdin` does not show differences for
          merge commits. With this flag, it shows differences to that commit
          from all of its parents. See also `-c`.

-- 
Jakub Narebski
Poland
