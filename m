From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Followup: Managing EXCEL with git - diff problem.
Date: Tue, 7 Apr 2015 08:55:11 -0400
Message-ID: <02d801d07132$159f76a0$40de63e0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 14:58:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfT5T-0007H2-As
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 14:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbbDGM6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 08:58:33 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27047 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbbDGMzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 08:55:17 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t37CtCCs020655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 7 Apr 2015 08:55:12 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdBxMSvjJhsVQmIwSKaIeXEHh8/9Cg==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266909>

Hi all,

There was a discussion a while back on how to manage EXCEL content in git.
This involved a simple trick of modifying the file extension from .xlsx to
.zip and unpacking the file - resulting in a whole bunch of XML files. Git
is happy with that part and the content can be managed - slightly.

Unfortunately, EXCEL stores its XML content in single lines. Git has no
problem with that either, as far as managing the content, but the lines can
be really long. However, after about 20K in size, while the config:

	alias.wdiff=diff --color-words

The ability of git to report differences goes away - as in no output from
git diff. This occurs on Windows and Linux under git 2.3.3 and git 2.3.0.
I'm not sure whether this is a user error, a usage error, or an actual
problem.

I had originally raised this as a SourceTree problem figuring it might be
there: https://jira.atlassian.com/browse/SRCTREEWIN-3145

Any advice (preferably no teasing - :-) - I am considering smudging but
would rather avoid that)?

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
