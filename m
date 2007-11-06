From: Bill Lear <rael@zopyra.com>
Subject: Re: git pull opinion
Date: Mon, 5 Nov 2007 18:36:16 -0600
Message-ID: <18223.46848.109961.552827@lisa.zopyra.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	<7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCRa-0007O4-Gy
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbXKFAhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbXKFAhK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:37:10 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60460 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755227AbXKFAhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:37:09 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lA60aG014931;
	Mon, 5 Nov 2007 18:36:16 -0600
In-Reply-To: <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63600>

On Monday, November 5, 2007 at 15:33:31 (-0800) Junio C Hamano writes:
>Aghiles <aghilesk@gmail.com> writes:
>
>> Is there an "easier" way to pull into a dirty directory ? I am
>> asking this to make sure I understand the problem and not
>> because I find it annoying to type those 4 commands to perform
>> a pull (although some of my colleagues do find that annoying :).
>
>You need to switch your mindset from centralized SVN workflow.
>
>The beauty of distributedness is that it redefines the meaning
>of "to commit".  In distributed systems, the act of committing
>is purely checkpointing and it is not associated with publishing
>the result to others as centralized systems force you to.
>
>Stop thinking like "I need to integrate the changes from
>upstream into my WIP to keep up to date."  You first finish what
>you are currently doing, at least to the point that it is
>stable, make a commit to mark that state, and then start
>thinking about what other people did.  You may most likely do a
>"git fetch" followed by "git rebase" to update your WIP on top
>of the updated work by others.
>
>Once you get used to that, you would not have "a dirty
>directory" problem.

I respectfully beg to differ.  I think it is entirely reasonable, and
not a sign of "centralized" mindset, to want to pull changes others
have made into your dirty repository with a single command.


Bill
