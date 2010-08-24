From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: Why does git-mergetool use /dev/tty?
Date: Mon, 23 Aug 2010 21:58:23 -0400
Message-ID: <D4C0AFB5-EC8C-44B6-9280-9915DE224CB6@gernhardtsoftware.com>
References: <3D6C7B12-FA06-4EAD-9781-5CA74FE23057@gernhardtsoftware.com> <20100824015337.GC17406@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 03:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnimV-00050R-LW
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 03:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab0HXB61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 21:58:27 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:36961 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab0HXB60 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 21:58:26 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 208551FFC43C; Tue, 24 Aug 2010 01:58:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 174891FFC43A;
	Tue, 24 Aug 2010 01:58:15 +0000 (UTC)
In-Reply-To: <20100824015337.GC17406@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154277>


On Aug 23, 2010, at 9:53 PM, Jonathan Nieder wrote:

> Brian Gernhardt wrote:
> 
>> Why does git-mergetool ignore the provided STDIN and STDOUT when not given a path to merge?
> 
> See af314714 (mergetool: Remove explicit references to /dev/tty,
> 2010-08-20) in pu.
> 
> Hope that helps,

It does really help, actually.  One thing removed from my TODO.

~~ Brian
