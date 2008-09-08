From: Jaap Suter <git@jaapsuter.com>
Subject: Re: Storing Large Flat Namespaces
Date: Mon, 8 Sep 2008 04:26:08 +0000 (UTC)
Message-ID: <loom.20080908T042124-621@post.gmane.org>
References: <21d738060809071858p703149ccmbec0276ad4ad8f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 06:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcYPP-00042E-NK
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 06:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYIHEaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 00:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbYIHEaL
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 00:30:11 -0400
Received: from main.gmane.org ([80.91.229.2]:41614 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138AbYIHEaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 00:30:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KcYO3-0001dr-3s
	for git@vger.kernel.org; Mon, 08 Sep 2008 04:30:03 +0000
Received: from S0106001346cd705f.vc.shawcable.net ([24.81.24.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 04:30:03 +0000
Received: from git by S0106001346cd705f.vc.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 04:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.81.24.155 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.29 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95213>


> I'm investigating the possibility of using Git to store a large flat
> namespace. As an example, imagine a single directory containing
> thousands or millions of files, each named using a 16-byte guid,
> evenly distributed.

I realize that an obvious suggestion may be to figure out if there is a way to 
leverage the internal structure of the files to create a more Git-friendly tree 
layout.

Unfortunately the internal structure is largely opaque to me, and highly 
dynamic.

Thanks,

Jaap
