From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Linking with -R (rpath) not supported on Darwin
Date: Wed, 3 Oct 2007 18:39:19 -0400
Message-ID: <ECAD7CED-FFA0-46F2-8094-2FDE47CB5D54@silverinsanity.com>
References: <4D954ADB-E66E-43CA-87EE-7522FFA87370@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 00:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdCs8-0000OI-My
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 00:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbXJCWjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 18:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXJCWjH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 18:39:07 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56246 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbXJCWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 18:39:07 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 23EC31FFC013;
	Wed,  3 Oct 2007 22:39:05 +0000 (UTC)
In-Reply-To: <4D954ADB-E66E-43CA-87EE-7522FFA87370@lrde.epita.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59901>


On Oct 3, 2007, at 5:34 PM, Benoit SIGOURE wrote:

> Hello,
> I've just compiled HEAD (1.5.3.4.209.g9e417) and saw a:
>     LINK git-http-fetch
> i686-apple-darwin8-gcc-4.0.1: unrecognized option '-R/opt/local/lib'
>
> It didn't harm but the build process should be more careful to not  
> use options that are not supported by the compiler.  And it's not a  
> matter of using -Wl,-rpath instead.

I compile git very regularly on my MacBook Pro and have never seen  
this error.  Do you have the most recent copy of Xcode?  I've seen  
odd errors on one of the not very old versions of the developer's  
tools.  For me, `gcc -v` reports "gcc version 4.0.1 (Apple Computer,  
Inc. build 5367)".

~~ Brian
