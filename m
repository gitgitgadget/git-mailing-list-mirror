From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Building documentation on an isolated network
Date: Sat, 08 May 2010 09:02:18 -0400
Message-ID: <4BE560DA.2010809@artsci.utoronto.ca>
References: <393FB43C-317F-4CCB-980F-F56D1126C50F@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jack Moore <jhmoore719@verizon.net>
X-From: git-owner@vger.kernel.org Sat May 08 16:07:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAkge-0005Bw-Km
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 16:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600Ab0EHOHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 10:07:10 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:46464 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab0EHOHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 10:07:09 -0400
X-Greylist: delayed 3892 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 May 2010 10:07:09 EDT
Received: from [24.36.152.183] (port=35677 helo=[192.168.0.10])
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by jimi.chass.utoronto.ca with esmtpsa (TLSv1:AES256-SHA:256)
	 (Exim 4.69)
	 (envelope-from <bwalton@artsci.utoronto.ca>)
	 id 1OAjfc-00084W-Ab ; Sat, 08 May 2010 09:02:16 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <393FB43C-317F-4CCB-980F-F56D1126C50F@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146660>

On 05/08/2010 04:24 AM, Jack Moore wrote:

> I'm trying to setup a git repository on an isolated (not connected to the internet) network.
 > The repository is to be accessed by several developers on their own 
workstations (all running RHEL 5).
 > I have got git to build and install the executable with no problem, 
but when I try to build the
 > documentation is runs into problems with ASCIIDOC.  I found an 
ASCIIDOC rpm for version 8.x.
 > I think ASCIIDOC is looking for some standard DTDs.  Does anyone have
 > suggestions?

Once you get asciidoc, you should have everything else you need in the 
stock RHEL distribution to build locally.  This would include things like:

xmlto
sgml-common
xml-common
docbook-dtds
docbook-style-xsl

and dependencies for those.  (There might be an important item or two 
missing from that list.  It's from memory.)  Asciidoc is available from 
the EPEL repo if the one you found doesn't work for some reason.

The other suggestion of building just the quick docs is good too unless 
you really want/need them.

HTH.
-Ben
