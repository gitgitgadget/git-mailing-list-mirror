From: David Kastrup <dak@gnu.org>
Subject: Re: Is there any efficient way to track history of a piece of code?
Date: Thu, 08 May 2014 09:06:43 +0200
Message-ID: <87bnv8rbp8.fsf@fencepost.gnu.org>
References: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jianyu Zhan <nasa4836@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 09:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiIQ0-0004HY-SC
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 09:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbaEHHG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 03:06:57 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:52202 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbaEHHG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 03:06:56 -0400
Received: from localhost ([127.0.0.1]:51242 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WiIPv-0000ah-SX; Thu, 08 May 2014 03:06:56 -0400
Received: by lola (Postfix, from userid 1000)
	id F07D0E05E8; Thu,  8 May 2014 09:06:43 +0200 (CEST)
In-Reply-To: <CAHz2CGW4rRWzGMPxM1XsoYvrwrrddrxAr+AKAi5SdMx+3rBjNg@mail.gmail.com>
	(Jianyu Zhan's message of "Thu, 8 May 2014 14:54:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248410>

Jianyu Zhan <nasa4836@gmail.com> writes:

> Usually, a trivial change(like coding style fix) may bury a
> original change of the code, and thus git blame is of less
> help. And to address this situation, I have to do like this:
>
>    git blame -s REF^ <file-in-question> > temp
>
> to dig into the history recursively by hand, to find out
> the original change.
>
> Here, REF is commit-id that git blame reports.
>
> git log -L is a good alternative option, but sometimes it seems
> too cubersome, as I care only one line of code.
>
> Is there any current solution or suggestion?

git blame -w

might help with a number of "coding style fixes".

-- 
David Kastrup
