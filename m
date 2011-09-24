From: =?iso-8859-1?Q?Dieter_Sch=F6n?= <dieter@schoen.or.at>
Subject: Re: how to remove unreachable objects?
Date: Sun, 25 Sep 2011 00:11:06 +0200
Message-ID: <326CBCA0-9960-41B9-B5CD-F231A6880DFE@schoen.or.at>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at> <20110919195335.GA31930@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 00:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7adx-0005St-4t
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 00:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab1IXWYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 18:24:07 -0400
Received: from postrelay6.edis.at ([85.126.233.179]:53097 "EHLO
	postrelay6.edis.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab1IXWYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 18:24:06 -0400
X-Greylist: delayed 771 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Sep 2011 18:24:06 EDT
Received: from mailrelay.edis.at (postrelay6.edis.at [85.126.233.179])
	by postrelay6.edis.at (Postfix) with ESMTPS id 866B080CB16A
	for <git@vger.kernel.org>; Sun, 25 Sep 2011 00:11:13 +0200 (CEST)
Received: from [10.0.0.3] ([::ffff:178.190.202.120])
  (AUTH: CRAM-MD5 dieter@schoen.or.at, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by mailrelay.edis.at with esmtp; Sun, 25 Sep 2011 00:11:12 +0200
  id 00000000181D41DE.000000004E7E5581.00006420
In-Reply-To: <20110919195335.GA31930@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182048>


Am 19.09.2011 um 21:53 schrieb Jeff King:

> On Mon, Sep 19, 2011 at 11:08:31AM +0200, dieter@schoen.or.at wrote:
> 
>> this is my use case:
>> i create a repository and produce several commits on master.
>> then i go back to a certain tag and create a new branch, where i also
>> commit.
>> then i switch back to master and delete (-D) the other branch.
>> it should now be unreachable from within git (to prove its existence,
>> i remember a commit SHA1 on the dead branch).
> 
> It will still be referenced by the HEAD reflog, won't it?

thanks to all that answered!
it was very helpful and i gained a bit more insight.

kind regards,
dieter
