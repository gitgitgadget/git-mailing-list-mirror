From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: gitweb.cgi in C
Date: Fri, 9 Dec 2005 07:28:47 -0800 (PST)
Message-ID: <20051209152847.28358.qmail@web34310.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 16:32:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkkDI-00031x-SH
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 16:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVLIP3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 10:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVLIP3E
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 10:29:04 -0500
Received: from web34310.mail.mud.yahoo.com ([66.163.178.142]:44412 "HELO
	web34310.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964780AbVLIP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 10:28:48 -0500
Received: (qmail 28360 invoked by uid 60001); 9 Dec 2005 15:28:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xLgkOOk4Yo98+f4GUaAE1cvzq8xKTkxiRIDKmN8/VrHGzB1gczVUtxY5xafnM6Gx9EPcRopu7qq53cYOVIK4gS+1Z/ZyIiB5qGt8H/T9FrZyJs0K6j5Js7fy3LNwpUC1aUvweH9Qffc4HqahZhlQSFIFgSoZGJhcPNNUQ1xmloU=  ;
Received: from [65.173.207.2] by web34310.mail.mud.yahoo.com via HTTP; Fri, 09 Dec 2005 07:28:47 PST
To: merlyn@stonehenge.com, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13427>

Randal L. Schwartz wrote:
>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
Junio> Yes, that is exactly what I meant by what Smurf is working on -- 
Junio> libified git with Pyrex.

> Pyrex?  not XS?  I'd like to see Perl "use Git;". :)

I have a lot of interest in writing an XS interface for GIT but I've been waiting for 1.0
to officially release so I can be assured of a somewhat stable interface target.

I started working on a GIT-XS project around GIT 0.9 timeframe, but the changes to APIs
and calls was still way too rapid, so I decided to back burner it. 

I haven't looked at the libification work that Smurf is doing (haven't made time for it
lately), but if it's not TOO python specific, maybe I can use it too.

Cheers,
--Mark
