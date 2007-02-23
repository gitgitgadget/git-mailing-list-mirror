From: Bill Lear <rael@zopyra.com>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Fri, 23 Feb 2007 11:56:10 -0600
Message-ID: <17887.10938.419368.304761@lisa.zopyra.com>
References: <17885.60477.53356.123095@lisa.zopyra.com>
	<20070222193625.GA4489@pasky.or.cz>
	<ern9gn$h4d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 23 18:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKefO-0000M5-LT
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 18:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbXBWR4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 12:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbXBWR4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 12:56:16 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61803 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932500AbXBWR4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 12:56:15 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1NHuDl06850;
	Fri, 23 Feb 2007 11:56:13 -0600
In-Reply-To: <ern9gn$h4d$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40456>

On Friday, February 23, 2007 at 18:52:22 (+0100) Jakub Narebski writes:
>Petr Baudis wrote:
>
>> On Thu, Feb 22, 2007 at 08:17:17PM CET, Bill Lear wrote:
>>> Git "indexing" of commits has a way to "go back":
>>> 
>>> % git diff HEAD~3
>>> 
>>> Can I say "all the way back", or "all the way back - 1" somehow?
>> 
>> What would that mean? :)
>> 
>> Do you mean to the "root" of the history? The trouble is, there can be
>> many of such roots (coming up from merges of previously disjunct
>> histories); even the git project itself has several. Which one to
>> choose?
>
>Actually HEAD~n follows first parent, so it would be only one such root.

Exactly what I was after.  Something like:

% git diff HEAD~-1

or

% git diff ^HEAD~0

whatever ...


Bill
