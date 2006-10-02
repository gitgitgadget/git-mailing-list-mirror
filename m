From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Stop making git-merge-recur
Date: Sun, 01 Oct 2006 21:52:58 -0700
Message-ID: <45209B2A.8070900@gmail.com>
References: <45207D32.8040300@gmail.com> <7vu02nz5w6.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 06:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUFnw-0000KF-P2
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 06:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWJBExF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 00:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWJBExE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 00:53:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:15980 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932607AbWJBExD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 00:53:03 -0400
Received: by py-out-1112.google.com with SMTP id n25so2324787pyg
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 21:53:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=D6m8ZGZBLGno4pNvkXGZhYMUQuk4SY0YAFjG6mLD/HAlPNdUDKFjjpLRxURToK4DQAI6+yltvk+KF/L9h/jx4CdUh6ENLu0l8lmu9xaIx+nfv6BfPc7P4qaH2pLRXzzrGhv4xiixvT4BU21GGtb4lTy8tlSVqzrksth8gWbzm7Y=
Received: by 10.64.180.4 with SMTP id c4mr6602234qbf;
        Sun, 01 Oct 2006 21:53:02 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.gmail.com with ESMTP id e15sm5341963qba.2006.10.01.21.53.01;
        Sun, 01 Oct 2006 21:53:02 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu02nz5w6.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28215>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> Git-merge-recur is no longer installed and make clean no longer
>> removes it, so creating making it.
> 
> Thanks for noticing.
> 
> The bug is actually not installing nor cleaning it.  People who
> wanted to stay on the bleeding edge could add "-s recur" on the
> command line, or have "merge.twohead = recur" in the config;
> this is what we actually encouraged people for wider testing.
> We do not suddenly break them.  I planned the removal for the
> release after 1.4.3.
> 
> This should fix it -- could you eyeball it please?

+1
