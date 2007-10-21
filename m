From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: .gittattributes handling has deficiencies
Date: Sun, 21 Oct 2007 12:27:52 +0200
Message-ID: <B61AE1A9-E983-4ACE-BF71-8FDC113A4F34@zib.de>
References: <1192956535617-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0710210204580.4818@asgard>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Oct 21 12:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjY15-0006NP-OE
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 12:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbXJUK0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 06:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXJUK0c
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 06:26:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:64901 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbXJUK0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 06:26:31 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9LAQPBX027168;
	Sun, 21 Oct 2007 12:26:26 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b164.pool.einsundeins.de [77.177.177.100])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9LAQOSW001964
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Oct 2007 12:26:24 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710210204580.4818@asgard>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61897>


On Oct 21, 2007, at 11:19 AM, david@lang.hm wrote:

>> But this is really hard to solve. We would need to compare
>> attributes before and after for _all_ files that have attributes
>> in one of the two commits and check if they changed. If so, we
>> need to do a fresh checkout according to the new attributes.
>
> if you know that you will get the new .gitattributes if it changes,  
> setup a post-checkout hook to checkout everything if it has  
> changed. it's far from ideal, but it should be a good, safe, first  
> approximation.


That's not good enough. I'll stop using .gitattributes. I
need to teach >40 devs how to use git on Windows. I only use
features that work flawlessly. .gitattributes doesn't. It bit
me twice now.

Luckily, core.autocrlf works if you set it before the first
checkout and never change it. This seems sufficient for me if
all files that have mixed line endings are fixed right away.

	Steffen
