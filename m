From: Belmar-Letelier <luis@itaapy.com>
Subject: "tla missing -s" equivalent with git/cogito
Date: Wed, 18 Jan 2006 15:53:26 +0100
Message-ID: <43CE5666.90502@itaapy.com>
Reply-To: luis@itaapy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 18 15:53:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzEfq-00030X-24
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWAROwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWAROwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:52:25 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:29450 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030301AbWAROwZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 09:52:25 -0500
Received: from [192.168.0.102] (itaapy-255-90.cnt.nerim.net [195.5.255.90])
	by kraid.nerim.net (Postfix) with ESMTP id 38BEF40EC5;
	Wed, 18 Jan 2006 15:52:23 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: fr, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14832>

Hello,

Could someone say me how we do in cogito or git the

arch-tla equivalent of

$ cd project--luis--0.1
$ tla missing -sD paul@mail.com--public/project--paul--0.1

so I get the information like what are the interesting patch to get

and then I take all of them with

$ tla star-merge -t paul@mail.com--public/project--paul--0.1

or I cherry pick only one of them (here patch-6) with

$ tla replay  somefriend@mail.com--public/project--branchA--0.1--patch-6

tks


-- 
Luis
