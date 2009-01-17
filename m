From: jidanni@jidanni.org
Subject: Re: log-tree.c: date hardwired
Date: Sun, 18 Jan 2009 07:27:29 +0800
Message-ID: <87fxjhcy3i.fsf@jidanni.org>
References: <87r637oq41.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 00:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOKb2-0001ez-TI
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 00:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761593AbZAQX1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 18:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761530AbZAQX1d
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 18:27:33 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:42918 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761201AbZAQX1c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2009 18:27:32 -0500
Received: from jidanni.org (122-127-32-36.dynamic.hinet.net [122.127.32.36])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id CF833119DC7
	for <git@vger.kernel.org>; Sat, 17 Jan 2009 15:27:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106110>

Can I get a go-ahead from somebody for me to begin work on implementing a fix?
(Yes, trivial.)

>>>>> "j" == jidanni  <jidanni@jidanni.org> writes:

j> In log-tree.c: printf("From %s Mon Sep 17 00:00:00 2001\n", name);
j> Wouldn't it be more aesthetically pleasing to use current local or UTC time?
j> Or at least comment in the code that the date is hardwired like that
j> in the fear that otherwise people will think it is the actual commit time.
j> No, I can't think of any other tool that hardwires the From separators
j> they produce.
