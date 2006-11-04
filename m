X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: git and branches newie questions
Date: Sat, 4 Nov 2006 07:46:23 +0000
Message-ID: <200611040746.23619.alan@chandlerfamily.org.uk>
References: <6844644e0611020902tc6251f7i2eda0d3fc82e0502@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 07:46:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <6844644e0611020902tc6251f7i2eda0d3fc82e0502@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30908>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgGEv-0002Rj-9y for gcvg-git@gmane.org; Sat, 04 Nov
 2006 08:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964842AbWKDHqn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 02:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWKDHqn
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 02:46:43 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:29902 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S964842AbWKDHqm (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4
 Nov 2006 02:46:42 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GgGEj-0005Z3-O0 for git@vger.kernel.org; Sat, 04 Nov 2006 07:46:41 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 02 November 2006 17:02, Doug Reiland wrote:
...
> I want to use internal_testing as a branch to merge and test the
> latest Linux branch with changes made to internal_current. Once this
> testing is complete, merge the changes into internal_current.
>
> That is the best way to do this. I am open to use cogito. I have
> messed up this merging process just about each time, and I want to get
> a stable process before I open this up to other users.

I notice that nobody has responded to your questions and a couple of days have 
gone past, and whilst I am not sure I know enough to respond correctly, I 
will do so to keep the thread alive so that perhaps someone more 
knowledgeable than me can comment too.

It sounds as though you are setting up a central repository type concept.  So 
why try and do the work of merging Linus' repository there?  Why not clone 
from Linus in a local repository, merge in changes from this common 
repository into your local repository and test, and when happy push them back 
out to the common one?


>
> Also, I can't figure out permissions. I have setup the allow_users
> hook in .git/hooks/update. My repository is "owned" by gate_keeper. My
> user login is dreiland. I push changes back to the gate_keeper
> repository and stuff under .git gets owned by me. Now, I log as a
> gate_keeper to get a Linus update or perform the internal_testing
> merges and things fail because it is owned by dreiland.

Did you do a git-init-db --shared ?

does gate_keeper and yourself belong to the same group?


-- 
Alan Chandler
