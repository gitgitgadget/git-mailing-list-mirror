From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: autocrlf
Date: Fri, 18 May 2007 13:45:43 +0200
Organization: eudaptics software gmbh
Message-ID: <464D91E7.FB3F9B4@eudaptics.com>
References: <200705181111.53823.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 13:45:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp0tn-0005zk-JL
	for gcvg-git@gmane.org; Fri, 18 May 2007 13:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344AbXERLpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 07:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXERLpY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 07:45:24 -0400
Received: from main.gmane.org ([80.91.229.2]:51653 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbXERLpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 07:45:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hp0ta-0007UN-MJ
	for git@vger.kernel.org; Fri, 18 May 2007 13:45:18 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 13:45:18 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 13:45:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47595>

Andy Parkins wrote:
> What I had imagined was that I could use .gitattributes to tell git which
> files in my tree were text.  Then the line endings on checkout would be set
> as appropriate to my platform, and on check in set to LF.
> 
> What actually happens is that any file with the crlf attribute is being
> checked out with LF expanded to CRLF (I'm running Linux of course), which is
> completely not what I wanted.

If I understand the documentation correctly
(Documentation/gitattributes.txt) then you set core.autocrlf to true on
Windows and false everywhere else, and things should start working like
you imagined.

I have not checked whether the behavior is according to the
documentation, though.

-- Hannes
