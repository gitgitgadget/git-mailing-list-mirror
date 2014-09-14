From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Re: [PATCH] help: ensure that common-cmds.h is only included by
 help.c
Date: Sat, 13 Sep 2014 19:00:18 -0700
Message-ID: <5414f6b2.XwoOyI03zlXiZ3ds%perryh@pluto.rain.com>
References: <1410657073-3089-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 14 04:25:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSzVb-0006yn-Fx
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 04:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaINCZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 22:25:42 -0400
Received: from agora.rdrop.com ([199.26.172.34]:3671 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbaINCZm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 22:25:42 -0400
X-Greylist: delayed 758 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Sep 2014 22:25:41 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id s8E2Cl95072539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 13 Sep 2014 19:12:48 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id s8E2ClOK072538;
	Sat, 13 Sep 2014 19:12:47 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA28136; Sat, 13 Sep 14 19:00:13 PDT
In-Reply-To: <1410657073-3089-1-git-send-email-davvid@gmail.com>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256992>

David Aguilar <davvid@gmail.com> wrote:
> Add a #ifndef guard to ensure that common-cmds.h can only
> be included by help.c.

This strikes me as a very peculiar, and sub-optimal, way of
achieving the purpose.  If these definitions are intended to
be private to help.c, why not put them there and eliminate
common-cmds.h entirely?
