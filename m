From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 08 Sep 2008 16:57:21 +0200
Message-ID: <48C53D51.50502@gnu.org>
References: <20080907103415.GA3139@cuci.nl>	<7vhc8rjyxj.fsf@gitster.siamese.dyndns.org>	<20080908115129.GA19031@cuci.nl> <48C522F6.7090308@gnu.org>	<20080908134222.GA20998@cuci.nl> <m34p4qpuuu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 18:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kck37-0003PQ-1t
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 18:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYIHQ4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 12:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbYIHQ4E
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 12:56:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:20597 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbYIHQ4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 12:56:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1539298fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 09:54:39 -0700 (PDT)
Received: by 10.86.82.16 with SMTP id f16mr11400214fgb.9.1220885851615;
        Mon, 08 Sep 2008 07:57:31 -0700 (PDT)
Received: from scientist-2.lan ( [89.96.108.150])
        by mx.google.com with ESMTPS id 12sm4613035fgg.0.2008.09.08.07.57.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 07:57:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <m34p4qpuuu.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95274>


> Second, unless such header would be for informational purposes only
> (there was even proposal to add generic 'note <sth>' informational
> only header, but it was shot down; see the archives), you would have
> to do quite a bit of surgery to revision walking code.  For example
> you would have to think about how commits pointed by 'origin' header
> would be protected against pruning; if you allow to prune parents of
> grandparents of cherry-picked commits, you would break I think a lot
> of assumptions in the code, and assumption in git design that if we
> have commit, then all that it references should be available (well,
> there are grafts, and there is shallow clone, but those modify
> reachability...).

I think it would be used mostly for informational purposes (for
hyperlinks in gitk, and in git-cherry).

Paolo
