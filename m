From: Marcus Camen <mcamen@mcamen.de>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 22 Oct 2009 21:48:30 +0200
Message-ID: <200910222148.31016.mcamen@mcamen.de>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091016143154.GS10505@spearce.org> <ca433830910161604g5a6bde76n26eb2b1e8155fb36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 22:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14Ke-0007gG-BE
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992AbZJVUcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbZJVUcO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:32:14 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:56700 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbZJVUcN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:32:13 -0400
X-Greylist: delayed 2626 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2009 16:32:13 EDT
Received: from [91.46.221.116] (helo=home.localnet)
	by smtprelay08.ispgateway.de with esmtp (Exim 4.68)
	(envelope-from <mcamen@mcamen.de>)
	id 1N13bb-0000oP-Ky
	for git@vger.kernel.org; Thu, 22 Oct 2009 21:45:51 +0200
User-Agent: KMail/1.12.90 (Linux/2.6.31.3-1-desktop; KDE/4.3.72; x86_64; svn-1039117; 2009-10-22)
In-Reply-To: <ca433830910161604g5a6bde76n26eb2b1e8155fb36@mail.gmail.com>
X-Df-Sender: [pbs]OTI0NTA5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131054>

On Samstag 17 Oktober 2009, Mark Lodato wrote:
> I just realized I forgot to say something in my last email: THANK
> YOU!!!  I have been looking forward to this for a long time.  I was
> planning to one day to sit down and start thinking about how to
> implement a smart protocol, and then I see a post saying that not only
> has someone figured out the protocol, but he has implemented it!
> Amazing!  This is really crucial for corporate adoption, at least at
> my job.  We need to have strong authentication for many users, and the
> SSH key management is just a nightmare, not to mention that not all
> users can SSH due to firewalls.  This will save me so much time and
> frustration.  Thanks!

As I am using git in a corporate environment I couldn't agree more. smart-
http definitely is the most import addition to git in the last months.

So far I didn't carry out extensive production runs but my first tests 
already showed that the smart-http backend solves many problems we have 
with the dumb webdav approach (no hooks, insane amount of http requests, 
slow performance, ...).

As I have a systems engineer (not a C coder) perspective on git I cannot 
comment an any possible glitches of this implementation. I just want to 
make sure that everyone recognizes just how import smart-http is for 
corporate environments and that the current patch already solves a lot of 
problems.


Regards,
Marcus
