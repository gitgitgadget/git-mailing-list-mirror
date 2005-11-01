From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 21:30:06 +0000
Message-ID: <b0943d9e0511011330v7045c568u@mail.gmail.com>
References: <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
	 <436787BD.9080705@citi.umich.edu>
	 <20051101153650.GB26847@watt.suse.com>
	 <b0943d9e0511010918ob2dbcfcv@mail.gmail.com>
	 <20051101181352.GD26847@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chuck Lever <cel@citi.umich.edu>, Petr Baudis <pasky@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 22:32:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX3ht-0000fE-HD
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 22:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVKAVaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 16:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKAVaJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 16:30:09 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:59710 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751254AbVKAVaH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 16:30:07 -0500
Received: by xproxy.gmail.com with SMTP id i30so1447015wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 13:30:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UDD0BDPafEuD+YnbNkczqiNL582pKs5KoKTZewhXshC8CNt4w++0Ka9P0QsKclFnLyK5DkM+Q4MFStxrMu+R0AZHOiTaV8hD08BCGbnJ2AvsNOJuQMhSOl0zooR6dzTji4YYEgeS2haE8SMm5Pl4s9DuJyTO3A2foIUITfmk8Po=
Received: by 10.70.31.17 with SMTP id e17mr2806735wxe;
        Tue, 01 Nov 2005 13:30:06 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 13:30:06 -0800 (PST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <20051101181352.GD26847@watt.suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10957>

On 01/11/05, Chris Mason <mason@suse.com> wrote:
> I would suggest just putting the .git/patches directory under revision
> control.

Putting them under a separate revisions repository, i.e. having a
.git/patches/,git directory? Otherwise there would be some problems
with the modified files automatically included in a patch.

> More importantly, you can reuse gitk and all of the other history
> functionality in the SCM.

Doing it the above way wouldn't be of much help with gitk. You would
get files like .git/patches/master/patchX/top etc. under revision
control which only contain some hash strings, not meaningful. With GIT
you have the advantage of being able to specify the DAG structure. It
is pretty simple to just link the commit objects corresponding to a
patch into a DAG and using gitk would allow you to navigate through
the history and also look at the diff itself.

--
Catalin
