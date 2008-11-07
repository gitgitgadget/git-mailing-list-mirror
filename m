From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Fri, 7 Nov 2008 22:57:05 +1100
Message-ID: <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-2-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-3-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-4-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-5-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-6-git-send-email-angavrilov@gmail.com>
	<1225652389-22082-7-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:58:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyPz8-0004dQ-4z
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYKGL5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbYKGL5K
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:57:10 -0500
Received: from ozlabs.org ([203.10.76.45]:44026 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778AbYKGL5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:57:09 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2A0ECDDE1C; Fri,  7 Nov 2008 22:57:07 +1100 (EST)
In-Reply-To: <1225652389-22082-7-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100309>

Alexander Gavrilov writes:

> For some reason, on Windows all transient windows are placed
> in the upper left corner of the screen. Thus, it is necessary
> to explicitly position the windows relative to their parent.
> For simplicity this patch uses the function that is used
> internally by Tk dialogs.

Is there any reason to call tk::PlaceWindow under Linux or MacOS?
If not I'd rather add an if statement so we only call it on Windows.

Paul.
