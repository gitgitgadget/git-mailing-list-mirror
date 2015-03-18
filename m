From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Git with Lader logic
Date: Wed, 18 Mar 2015 15:53:25 -0400
Message-ID: <00bd01d061b5$331874c0$99495e40$@nexbridge.com>
References: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Bharat Suvarna'" <bharat.bs84@icloud.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 20:53:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYK26-0006Yh-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 20:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469AbbCRTxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 15:53:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:59719 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbbCRTxd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 15:53:33 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t2IJrSPA079582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Mar 2015 15:53:29 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <5F9B9EBF-CD4D-42A8-8A0C-9806702231A1@icloud.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGgj0ZsDH/SCESknr0YCLhOqCeapp2CR8bg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265753>

On March 17, 2015 7:34 PM, Bharat Suvarna wrote:
> I am trying to find a way of using version control on PLC programmers like
Allen
> Bradley PLC. I can't find a way of this.
> 
> Could you please give me an idea if it will work with Plc programs. Which
are
> basically Ladder logic.

Many PLC programs either store their project code in XML, L5K or L5X (for
example), TXT, CSV, or some other text format or can import and export to
text forms. If you have a directory structure that represents your project,
and the file formats have reasonable line separators so that diffs can be
done easily, git very likely would work out for you. You do not have to have
the local .git repository in the same directory as your working area if your
tool has issues with that or .gitignore. You may want to use a GUI client to
manage your local repository and handle the commit/push/pull/merge/rebase
functions as I expect whatever PLC system you are using does not have git
built-in.

To store binary PLC data natively, which some tools use, I expect that those
who are better at git-conjuring than I, could provide guidance on how to
automate binary diffs for your tool's particular file format.

Cheers,
Randall
-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
