From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Tue, 9 Nov 2010 17:46:44 -0800
Message-ID: <833D47AD-041C-47BF-9AF3-69FD97F42712@sb.org>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan> <7vd3qfr7ki.fsf@alter.siamese.dyndns.org> <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org> <20101108222937.GH3167@home.lan> <20101110014215.GA1503@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@free.fr>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 02:46:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFzm0-00067v-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 02:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab0KJBqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 20:46:47 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48815 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0KJBqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 20:46:47 -0500
Received: by pwj1 with SMTP id 1so23334pwj.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 17:46:46 -0800 (PST)
Received: by 10.142.139.17 with SMTP id m17mr6964948wfd.41.1289353606825;
        Tue, 09 Nov 2010 17:46:46 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w3sm102900wfd.2.2010.11.09.17.46.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 17:46:45 -0800 (PST)
In-Reply-To: <20101110014215.GA1503@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161119>

On Nov 9, 2010, at 5:42 PM, Jonathan Nieder wrote:

> Yann Dirson wrote:
> 
>> |Keep in mind that any commit in the original todo list, that would
>> |not be there after your edits, would not be included in the resulting
>> |rebased branch.  In case you realize afterwards that you need such a
>> |commit, you can still access it as an ancestor of @{1}, see
>> |git-reflog(1) for details.
> 
> Do you mean @{-1}?

@{-1} is the previously-checked-out branch. @{1} is the previous commit
that the current branch was pointing to. I believe @{1} is correct here.

>> Maybe we could list a copy of the todo list in the comments, as a
>> reference for double-checking.  Such a list could even be used for a
>> final check before applying, that would ask confirmation if the set of
>> patches has changed, and offer to edit again.  The same config item
>> (eg. advice.interactiveRebase ?) could be used to hide the note and
>> the check.
> 
> Mm, but intentionally dropping commits is common, no?
> 
> What would be nice is to be able to do
> 
> 	git rebase --change-of-plans
> 
> and somehow get my editor of choice to open with the original todo
> list (read-only) and the current todo list (read/write).
> 
> Well, a person can dream. :)

Not a bad idea. It would be especially nice if you could then selectively
roll back to the state after previous entries in your todo list so you
could change something you've done without having to start all over again.

-Kevin Ballard
