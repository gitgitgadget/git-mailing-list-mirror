From: Ananth <smilewithani@gmail.com>
Subject: Re: How to apply patches
Date: Wed, 17 Nov 2010 07:01:16 -0800 (PST)
Message-ID: <1290006076573-5748001.post@n2.nabble.com>
References: <1289988042359-5747036.post@n2.nabble.com> <AANLkTinR5Z60u5DYzgzuB0x7CmA8kVR04nLDJ4csDZJK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 16:01:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIjVj-000487-8I
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 16:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996Ab0KQPBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 10:01:17 -0500
Received: from kuber.nabble.com ([216.139.236.158]:44439 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739Ab0KQPBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 10:01:17 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <smilewithani@gmail.com>)
	id 1PIjVc-0005CQ-If
	for git@vger.kernel.org; Wed, 17 Nov 2010 07:01:16 -0800
In-Reply-To: <AANLkTinR5Z60u5DYzgzuB0x7CmA8kVR04nLDJ4csDZJK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161618>


Hi Tay Ray,
Thanks for the reply. the problem is now resolved. The problem was that the
patches created were in Unix format (only CR) while when I uploaded the
patches through FTP site, they were converted to Windows format (CRLF) which
was preventing from the patches from getting applied. I changed the files to
unix format again and the problem got resolved.
-- 
View this message in context: http://git.661346.n2.nabble.com/How-to-apply-patches-tp5747036p5748001.html
Sent from the git mailing list archive at Nabble.com.
