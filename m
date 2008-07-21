From: Joshua Roys <roysjosh@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Followup-To: gmane.comp.version-control.git.gittorrent
Date: Mon, 21 Jul 2008 09:23:27 -0400
Message-ID: <48848DCF.30803@gmail.com>
References: <200807080227.43515.jnareb@gmail.com> <200807210029.31543.jnareb@gmail.com> <1216601739.6523.48.camel@maia.lan> <200807211223.45707.jnareb@gmail.com> <20080721104032.GI32184@machine.or.cz>
Reply-To: gittorrent@lists.utsl.gen.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: gittorrent@lists.utsl.gen.nz
X-From: git-owner@vger.kernel.org Mon Jul 21 15:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKvNW-0006Bv-Tt
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 15:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbYGUNXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 09:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbYGUNXj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 09:23:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:37447 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbYGUNXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 09:23:38 -0400
Received: by yx-out-2324.google.com with SMTP id 8so199040yxm.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5qpjOL7j4kDGrBd8RhAZsBt2UA47X7lYGDaE5D4ngz8=;
        b=EbW8Heo/OhLL3whWAk53DdO57kRi16BgufXiIRKQpgBu9PCr42A+Q7JeP9Pzg5cSp1
         L9iKVOWpBKleuFddu50nqlO7NeaS1wM6a6jQktMwTE8XhIqj5UYLmApDqS0Gu7/+rX2A
         JRlkO6al43xwuHkqe1r2wdEp1024lrdo9GNb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lVsmtlIM9vm2dtaqMt5xw5RI4uc+gIgeWNtfa6FN6HEDB7MAplqHkqyrKr9Kwu6ayo
         o/uiWyjE+6La639oaWhnngxJEU6EEOPnZgypAH4cbsftpqzURb7gFD/QiKvEBu6f2nPC
         +DJv0+L38tciJO7vHB0RfLO1vqgiRmrUZroPc=
Received: by 10.151.100.17 with SMTP id c17mr3816326ybm.112.1216646617796;
        Mon, 21 Jul 2008 06:23:37 -0700 (PDT)
Received: from ?192.168.1.250? ( [67.167.142.145])
        by mx.google.com with ESMTPS id 6sm931406ywp.3.2008.07.21.06.23.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 06:23:37 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080721104032.GI32184@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89355>

Petr Baudis wrote:
> On Mon, Jul 21, 2008 at 12:23:45PM +0200, Jakub Narebski wrote:
>> [*1*] "the current implementation is quite slow (requiring two calls to
>> 'git-cat-file' for each object)" <-- why you don't use '--batch' or
>> '--batch-check' options to git cat file: see also Git::Repo and friends
>> implementation send by Lea Wiemann to git mailing list as part of
>> "Gitweb caching" project?  BTW. by keeping discussion off the list,
>> you are off the knowledge of git community, too.
> 
> I concur. Only now I realized that this project might be an important
> Git Perl API user. Can you please reconsider having a separate mailing
> list for discussions etc.? The traffic seems to be very low anyway, and
> I'm not sure what benefits does it actually have at all.
> 
> 				Petr "Pasky" Baudis

Thank you for that suggestion!  I made it call cat-file only once in 
batch mode and it goes quite a bit faster now.

Josh
