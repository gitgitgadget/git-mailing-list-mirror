From: Kevin Ballard <kevin@sb.org>
Subject: git push refspec to specify tracking branch
Date: Tue, 30 Mar 2010 18:06:45 -0700
Message-ID: <13A69FD9-234A-4E2A-B83F-096DE304FA16@sb.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 03:06:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwmOT-0002SK-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 03:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923Ab0CaBGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 21:06:48 -0400
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:35119 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757665Ab0CaBGr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 21:06:47 -0400
Received: from [192.168.1.17] (173-13-153-133-sfba.hfc.comcastbusiness.net [173.13.153.133])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 9584E109E84
	for <git@vger.kernel.org>; Tue, 30 Mar 2010 18:06:46 -0700 (PDT)
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143631>

Is there any way in a refspec to specify the tracking branch corresponding to a local branch? Specifically, I want to be able to write some variant of `git push origin +foo` and have it push foo to its tracking branch. I can't find any way to do that according to the current documentation.

-Kevin Ballard