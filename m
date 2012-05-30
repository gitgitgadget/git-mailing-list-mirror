From: "Manuela Hutter" <manuelah@opera.com>
Subject: calling git rebase with invalid onto-ref exits with wrong error
 message
Date: Wed, 30 May 2012 11:02:05 +0200
Organization: Opera Software ASA
Message-ID: <op.we351rjtt21y7h@id-c1003.oslo.osa>
Reply-To: manuelah@opera.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 11:09:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZeuY-0007zf-Js
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 11:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab2E3JJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 05:09:43 -0400
Received: from smtp.opera.com ([213.236.208.81]:52261 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381Ab2E3JJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 05:09:42 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 May 2012 05:09:42 EDT
Received: from id-c1003.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q4U924Di031457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 30 May 2012 09:02:05 GMT
User-Agent: Opera Mail/11.64 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198787>

Just noticed a small bug (in git version 1.7.10.msysgit.1):

calling
   git rebase --onto <onto-ref> <base-ref> <branch-ref>

with an unknown <onto-ref> reports:
   fatal: Needed a single revision
   Does not point to a valid commit: <branch-ref>

Expected:
   fatal: Needed a single revision
   Does not point to a valid commit: <onto-ref>

Cheers,
Manuela
