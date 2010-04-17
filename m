From: Geert Bosch <bosch@adacore.com>
Subject: Re: GIT Performance question
Date: Sat, 17 Apr 2010 06:37:11 -0400
Message-ID: <2FFDF076-F06F-427E-92FE-51C2A6AA02BF@adacore.com>
References: <1271498149921-4917066.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: santos2010 <santos.claudia2009@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 12:46:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O35XG-0004DO-Vp
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 12:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314Ab0DQKp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 06:45:58 -0400
Received: from rock.gnat.com ([205.232.38.15]:48726 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287Ab0DQKp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Apr 2010 06:45:57 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Apr 2010 06:45:57 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 278362BAC3B;
	Sat, 17 Apr 2010 06:37:11 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7jbh9HoR8Fbo; Sat, 17 Apr 2010 06:37:11 -0400 (EDT)
Received: from [172.16.1.3] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id EB32A2BAB3C;
	Sat, 17 Apr 2010 06:37:10 -0400 (EDT)
In-Reply-To: <1271498149921-4917066.post@n2.nabble.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145132>


On Apr 17, 2010, at 05:55, santos2010 wrote:

> 
> Hello,
> 
> Our company is evaluating SCM solutions, one of our most important
> requirements is performance as we develop over 3 differents sites across the
> world.
> I read that GIT doesn't use deltas, it uses snapshots.
Git does use deltas between snapshots.

  -Geert