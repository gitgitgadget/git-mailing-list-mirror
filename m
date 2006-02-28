From: linux@horizon.com
Subject: Re: the war on trailing whitespace
Date: 27 Feb 2006 20:07:15 -0500
Message-ID: <20060228010715.31275.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtKq-0005Ct-BI
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWB1BHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWB1BHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:07:25 -0500
Received: from science.horizon.com ([192.35.100.1]:57929 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751873AbWB1BHZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:07:25 -0500
Received: (qmail 31276 invoked by uid 1000); 27 Feb 2006 20:07:15 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16900>

The only language I know of where the presence of whitespace on blank
lines matters is make(1).  Even there, it's subtle.  It's okay to have
(using "cat -e" syntax)

foo : bar$
	command$
$
	command$

But there's a difference between

foo : bar$
	$

which specifies an empty command and will therefore not use a default rule, and

foo : bar$
$

which does not specify any command and so will use a default rule if one exists.


(Of course, you can also get [ \t]\n inside an arbitrary binary file, too.)
