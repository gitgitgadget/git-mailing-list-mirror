From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 17:08:24 +0100
Message-ID: <200602271708.24656.Josef.Weidendorfer@gmx.de>
References: <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net> <20060227133124.GA8794@informatik.uni-freiburg.de> <4403086F.5040704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDkvH-0003fH-0f
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWB0QI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWB0QI2
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:08:28 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:26325 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751450AbWB0QI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 11:08:27 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 6001722DB;
	Mon, 27 Feb 2006 17:08:26 +0100 (MET)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.9.1
In-Reply-To: <4403086F.5040704@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16856>

On Monday 27 February 2006 15:10, you wrote:
> So in essence, a multi-line statement is closed when a completely empty 
> line is found,

As I read this reference, such handling of completely empty lines is
done only in interactive mode, ie. when python is attached to a terminal...
Git is about storing python scripts, and not "interactive input"; therefore,
this seems to be a non-issue.

I just checked it. The following, with a completely empty line 3, is working
as expected, and not looping on an empty statement:
===================
a = ['cat', 'window', 'defenestrate']
for x in a:

  print x, len(x)
===================

Josef

PS: I am not a python programmer...
