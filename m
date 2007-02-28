From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [RFC] proposal for command "publish"
Date: Wed, 28 Feb 2007 14:48:01 +0100
Message-ID: <45E58811.9020005@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 14:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMPAK-0002lK-Su
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 14:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbXB1NsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 08:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbXB1NsH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 08:48:07 -0500
Received: from server.usilu.net ([195.176.178.200]:41165 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932370AbXB1NsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 08:48:06 -0500
X-Greylist: delayed 87223 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Feb 2007 08:48:06 EST
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 28 Feb 2007 14:48:01 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
X-OriginalArrivalTime: 28 Feb 2007 13:48:01.0077 (UTC) FILETIME=[0FE03E50:01C75B3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40922>

I'm proposing a command "publish", where

   git publish URL

would do

   git repack
   git clone --bare . URL
   git remote add origin URL

The idea is that this would be the step from preparing a repository 
(either from scratch, or importing from other SCM) to publishing it 
remotely.  Is this sensible?

Options from clone that would make sense for publish are -l, -q, 
--template, --upload-pack.

Paolo
