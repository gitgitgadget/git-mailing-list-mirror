From: Joachim B Haga <cjhaga@fys.uio.no>
Subject: Re: What to expect after GIT 0.99.7
Date: 19 Sep 2005 16:15:33 +0200
Message-ID: <85slw1rvne.fsf@riget.hn.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net> <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509181829310.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 19 16:33:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMfe-0008K2-33
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVISOa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVISOa6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:30:58 -0400
Received: from main.gmane.org ([80.91.229.2]:24805 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932433AbVISOa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:30:57 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EHMel-00084a-P6
	for git@vger.kernel.org; Mon, 19 Sep 2005 16:30:07 +0200
Received: from 67.80-203-45.nextgentel.com ([80.203.45.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:30:07 +0200
Received: from cjhaga by 67.80-203-45.nextgentel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 16:30:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 67.80-203-45.nextgentel.com
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8866>

Linus Torvalds <torvalds@osdl.org> writes:

> >   * strcasestr() in mailinfo.  We may need compat/strcasestr.c;
> 
> Totally untested, of course.
>
> +	int hlen = strlen(haystack) - nlen;

int hlen = strlen(haystack) - nlen + 1;

(otherwise you'll miss match at the end)

-j.
