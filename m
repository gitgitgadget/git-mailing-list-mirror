From: marcel partap <mpartap@gmx.net>
Subject: git apply-diff / am cannot deal with patches generated with git diff/format-patch
 --noprefix?
Date: Thu, 11 Aug 2011 00:25:00 +0200
Message-ID: <4E43053C.5080407@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 00:25:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrHD9-0000xc-DX
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 00:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab1HJWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 18:25:08 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:58353 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752269Ab1HJWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 18:25:08 -0400
Received: (qmail invoked by alias); 10 Aug 2011 22:25:05 -0000
Received: from 149-042.oih.RWTH-Aachen.DE (EHLO [137.226.149.42]) [137.226.149.42]
  by mail.gmx.net (mp035) with SMTP; 11 Aug 2011 00:25:05 +0200
X-Authenticated: #724076
X-Provags-ID: V01U2FsdGVkX1//kJ521Jr/RIHVQMHbpyXrRa6/7HThve06hpeymI
	Ked8vlFNZ8V2IE
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11 ThunderBrowse/3.8
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179078>

...at least it seems so. -p0 does not help:
> fatal: git apply: bad git-diff - inconsistent old filename on line xx
So it is not possible to have diff.noprefix set as default and generate 
patches that can be circulated? Or am i missing something there?
#regards/marcel
