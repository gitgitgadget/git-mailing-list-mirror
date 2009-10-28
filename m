From: Geert Bosch <bosch@adacore.com>
Subject: Re: how to split a hunk
Date: Tue, 27 Oct 2009 23:11:07 -0400
Message-ID: <21963906-785A-4D98-8AD8-A89ED914920C@adacore.com>
References: <20091028022105.GE3938@debian.b2j>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 04:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ywS-0004xh-4P
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 04:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbZJ1DLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbZJ1DLI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 23:11:08 -0400
Received: from rock.gnat.com ([205.232.38.15]:46334 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514AbZJ1DLH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 23:11:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id F01C62BAC7B;
	Tue, 27 Oct 2009 23:11:11 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lL0c10Nw6QAg; Tue, 27 Oct 2009 23:11:11 -0400 (EDT)
Received: from [172.16.1.5] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id BC3302BAC78;
	Tue, 27 Oct 2009 23:11:11 -0400 (EDT)
In-Reply-To: <20091028022105.GE3938@debian.b2j>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131402>


On Oct 27, 2009, at 22:21, bill lam wrote:

> There are occasions where diff of a file is
>
> - aaaa
> + bbbb
> + cccc
>
> I want to add lines bbbb and cccc as separated commits, but git-add -p
> seem cannot further split this hunk.  Do I have no choice but to edit
> it by hand and commit the bbbb and then edit the file to add back the
> cccc?
>
I like to use "git gui" for this. This allows you to pick individual
lines to commit. I really like the "git gui" interface for staging/ 
unstaging
changes and making a series of commits.

   -Geert
