From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 17:26:17 -0700
Message-ID: <20070919002617.GA22187@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org> <46EF7DD1.9090301@vilain.net> <20070918154918.GA19106@old.davidb.org> <3f4fd2640709181053t70b7abcdi2c4eaf67e7b75338@mail.gmail.com> <20070918231921.GA17652@old.davidb.org> <46F06B5C.2050207@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Reece Dunn <msclrhd@googlemail.com>, Git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:26:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnOc-0006lO-2h
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXISA0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXISA0U
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:26:20 -0400
Received: from mail.davidb.org ([66.93.32.219]:34746 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbXISA0T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:26:19 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IXnOT-0005oD-E2; Tue, 18 Sep 2007 17:26:17 -0700
Mail-Followup-To: Sam Vilain <sam@vilain.net>,
	Reece Dunn <msclrhd@googlemail.com>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46F06B5C.2050207@vilain.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58667>

On Wed, Sep 19, 2007 at 12:20:44PM +1200, Sam Vilain wrote:

>If you can get a hold of the "checkpoint" and "journal" files, you could
>probably throw the client spec data into a few Pg tables, chuck a couple
>of constraints on it to confirm that it works the way you thought, and
>then get the information on what's where using a SQL query.  The file
>images themselves can come from wherever, it doesn't really matter
>because there are MD5 hashes in the data tables you can use to confirm
>you got the right file.

In my instance, I don't have an account on the P4 server, so I'm going to
have to deal with this through P4's normal client.

I don't have much confidence that P4 really knows what it is doing when it
comes to integrate, so I'm not much worried about branches.  But, I do want
to accurately get the history of a particular branch.

So far, the only thing that isn't working is the execute bit doesn't get
set on files that should have it.

Dave
