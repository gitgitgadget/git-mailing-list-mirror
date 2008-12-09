From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: Getting submodules to follow symlinks?
Date: Tue, 09 Dec 2008 12:29:32 -0500
Message-ID: <ghm9ts$hib$1@ger.gmane.org>
References: <57518fd10812090455wd109843mfece11eae9e4f593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 18:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA6QG-0001oJ-Vh
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 18:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYLIR3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 12:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYLIR3o
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 12:29:44 -0500
Received: from main.gmane.org ([80.91.229.2]:48203 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYLIR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 12:29:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LA6Oz-0007RR-6m
	for git@vger.kernel.org; Tue, 09 Dec 2008 17:29:41 +0000
Received: from maclaurin-fifteen-forty-nine.mit.edu ([18.53.7.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 17:29:41 +0000
Received: from edwardzyang by maclaurin-fifteen-forty-nine.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 17:29:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: maclaurin-fifteen-forty-nine.mit.edu
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <57518fd10812090455wd109843mfece11eae9e4f593@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan del Strother wrote:
> My git repository contains a symlink to another repository.  I'd like
> to make that second repository a submodule of the first, in such a way
> that when someone else clones the repository, there's no trace of the
> original symlink.

Yeah. If you register the submodule and then commit, the first
repository would contain the submodule information, and anyone who loads
submodules in another clone will not see the symlink.

Cheers,
Edward
