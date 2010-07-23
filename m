From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 0/2] make git installation footprint smaller
Date: Fri, 23 Jul 2010 13:17:32 -0500
Message-ID: <8ovbiyHgA0TrkzTYhiyARaZKuacjG5kLhVLYZ4WEvkGOP9m8gKlnqw@cipher.nrlssc.navy.mil>
References: <taBDPvzBKDtgdmYKlcbFJ_fQRnY4jBMR74BF1vetbRU3OZRMPpwtU0wTG1SSa0hFgNsCN5k9Qx8@cipher.nrlssc.navy.mil> <4C49DB84.9060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 23 20:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcMoW-0001Iu-EF
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 20:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168Ab0GWSRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 14:17:35 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49975 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257Ab0GWSRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 14:17:35 -0400
Received: by mail.nrlssc.navy.mil id o6NIHXNU020742; Fri, 23 Jul 2010 13:17:33 -0500
In-Reply-To: <4C49DB84.9060001@gmail.com>
X-OriginalArrivalTime: 23 Jul 2010 18:17:33.0210 (UTC) FILETIME=[51DBA7A0:01CB2A93]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151562>

A Large Angry SCM wrote:
> On 07/23/2010 01:50 PM, Brandon Casey wrote:
>> Brandon Casey (2):
>>    Makefile: link builtins residing in bin directory to main git binary
>>      too
>>    Makefile: make hard/symbolic links for non-builtins too
>>
>>   Makefile |   15 ++++++++++++---
>>   1 files changed, 12 insertions(+), 3 deletions(-)
>>
> 
> What happens when bindir and execdir are the same?

Nothing.  See the second patch "make hard/symbolic links for
non-builtins too".  We already handled this case.
