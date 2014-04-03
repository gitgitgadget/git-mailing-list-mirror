From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Thu, 3 Apr 2014 18:07:02 +0400
Message-ID: <20140403140701.GA24817@seldon>
References: <20140403131850.GA24449@seldon>
 <20140403174808.9ae91c3bd477d276e3e80d68@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Apr 03 16:07:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WViIt-0007dt-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 16:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbaDCOHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 10:07:06 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:53416 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbaDCOHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 10:07:05 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WViII-0006ST-14; Thu, 03 Apr 2014 18:07:02 +0400
Content-Disposition: inline
In-Reply-To: <20140403174808.9ae91c3bd477d276e3e80d68@domain007.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245738>

On Thursday 03 April 2014 at 17:48:08  Konstantin Khomoutov wrote:
>
> What is the state of Unicode support in WinGit?

I haven't seen any Unicode-related issues when using through TortoiseGit.

Command-line usage is currently broken: no UTF-8 <->cmd.exe encoding
conversion is performed. Fixing this is a high-priority issue though,
most likely by migrating to newer (yet-to-be-released) msys lib.
