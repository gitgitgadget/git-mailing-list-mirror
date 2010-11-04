From: "Philip Boulton" <philipb@ssimicro.com>
Subject: 'Unable to find remote helper'
Date: Thu, 4 Nov 2010 15:59:13 -0600
Message-ID: <F815EC90C848458886E418CB6DE1DA8B@ssipboulton>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 23:32:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8MW-00010U-0F
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0KDWco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:32:44 -0400
Received: from mail.ssimicro.com ([64.247.129.10]:55243 "EHLO
	mail.ssimicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0KDWcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:32:43 -0400
X-Greylist: delayed 2046 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2010 18:32:43 EDT
Received: from ssipboulton (philipb.ssimicro.com [64.247.130.118])
	by mail.ssimicro.com (8.14.4/8.14.4) with ESMTP id oA4LuaBL059399
	for <git@vger.kernel.org>; Thu, 4 Nov 2010 15:56:36 -0600 (MDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.96.1 at mail.ssimicro.com
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Act8a4RAhxHLk/q9TuOwI92JcXehrQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160786>

Been beating my head against this for a while:

Here's the problem I have:

$ git submodule init
$ git submodule update
Cloning into contrib/express...
fatal: Unable to find remote helper for 'http'
Clone of 'http://github.com/visionmedia/express.git' into submodule path
'contrib/express' failed


I have git version 1.7.3.1, built from source on FreeBSD 6.4
Prior to building I have curl and expat lib installed.

My git build commands are:
./configure
gmake clean && gmake all
gmake install

I've also tried the configure as follows:
./configure --with-curl=/usr/local --with-expat=/usr/local

in case it was looking elsewhere.  The behaviour I see in this case is
identical.

Philip B.
