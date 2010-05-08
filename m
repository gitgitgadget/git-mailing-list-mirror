From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Building documentation on an isolated network
Date: Sat, 08 May 2010 11:23:43 +0200
Message-ID: <4BE52D9F.1040305@dbservice.com>
References: <393FB43C-317F-4CCB-980F-F56D1126C50F@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jack Moore <jhmoore719@verizon.net>
X-From: git-owner@vger.kernel.org Sat May 08 11:31:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAgNc-0003F8-7L
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 11:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab0EHJXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 05:23:54 -0400
Received: from office.neopsis.com ([78.46.209.98]:55056 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0EHJXx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 05:23:53 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 8 May 2010 11:23:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <393FB43C-317F-4CCB-980F-F56D1126C50F@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146651>

On 5/8/10 10:24 AM, Jack Moore wrote:
> I'm trying to setup a git repository on an isolated (not connected to the internet) network.  The repository is to be accessed by several developers on their own workstations (all running RHEL 5).  I have got git to build and install the executable with no problem, but when I try to build the documentation is runs into problems with ASCIIDOC.  I found an ASCIIDOC rpm for version 8.x.  I think ASCIIDOC is looking for some standard DTDs.  Does anyone have suggestions?--

$ make quick-install-doc

tom
