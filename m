From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Sat, 15 May 2010 22:14:48 -0400
Message-ID: <C21B68F7-E430-4BCA-A1D1-80446B0B76DE@adacore.com>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com> <1273598423-3156-1-git-send-email-rctay89@gmail.com> <7veihh8y8b.fsf@alter.siamese.dyndns.org> <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 04:15:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODTNz-0004Ow-2C
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 04:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab0EPCPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 22:15:04 -0400
Received: from rock.gnat.com ([205.232.38.15]:41917 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab0EPCPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 22:15:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id C073E2BAB94;
	Sat, 15 May 2010 22:15:00 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z53Vzt0sNenN; Sat, 15 May 2010 22:15:00 -0400 (EDT)
Received: from [172.16.1.3] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id D5DCC2BAB8D;
	Sat, 15 May 2010 22:14:56 -0400 (EDT)
In-Reply-To: <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147174>


On May 13, 2010, at 23:07, Tay Ray Chuan wrote:

>> When an end user does not know which remote ls-remote would be talking to
>> by default, what else does he *not* know?  Probably which remote "pull"
>> would be fetching from and what branch it would be merging with?  Doesn't
>> he have a better command to use to learn that information to reorient
>> himself when he is lost that way?
> 
> I'm not sure if there's a command to determine the remote - I'd be
> interested to know it, if there's one.

What git seems to be missing is a "git info" command, which
would print out essentially something like what "svn info" does:
name of remote repo that we're tracking, name of current branch,
date/author/subject of last commit.

Regards,
  -Geert
