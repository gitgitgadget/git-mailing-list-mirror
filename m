From: Sam Vilain <sam@vilain.net>
Subject: Re: post-update script to update wc - version 2
Date: Thu, 28 Jun 2007 11:53:39 +1200
Message-ID: <4682F883.4030609@vilain.net>
References: <E1I3MuE-0005eO-00@www.watts.utsl.gen.nz> <468217B4.3030708@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <samv@utsl.gen.nz>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 01:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3hKY-0004I9-RY
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 01:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763158AbXF0Xxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 19:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763111AbXF0Xxs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 19:53:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:49164 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761415AbXF0Xxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 19:53:47 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 77FEE13A3E1; Thu, 28 Jun 2007 11:53:45 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id BC3F013A303;
	Thu, 28 Jun 2007 11:53:41 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <468217B4.3030708@midwinter.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51067>

Steven Grimm wrote:
> Sam Vilain wrote:
>> # An example hook script to prepare a packed repository for use over
>> # dumb transports.
>>   
> Maybe this comment isn't quite accurate any more?

Ok that should read something like

# This hook does two things:
#
#  1. update the "info" files that allow the list of references to be
#     queries over dumb transports such as http
#
#  2. if this repository looks like it is a non-bare repository, and
#     the checked-out branch is pushed to, then update the working copy.
#     This makes "push" and "pull" symmetric operations as in darcs and
#     bzr.

Sam.
