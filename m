From: Geert Bosch <bosch@adacore.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 1 Nov 2007 17:17:17 -0400
Message-ID: <DB2DC59C-8580-4AFE-860F-6E7C4A47499E@adacore.com>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:17:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhQ3-0005kX-AO
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbXKAVRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbXKAVRW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:17:22 -0400
Received: from rock.gnat.com ([205.232.38.15]:34344 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbXKAVRV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:17:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 6036C2AB391;
	Thu,  1 Nov 2007 17:17:18 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p3NJji2eJ1Od; Thu,  1 Nov 2007 17:17:18 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.124])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 3ED1F2AB204;
	Thu,  1 Nov 2007 17:17:18 -0400 (EDT)
In-Reply-To: <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63003>


On Nov 1, 2007, at 16:27, Junio C Hamano wrote:
> Geert Bosch <bosch@adacore.com> writes:
>> I often type "make clean" as well many "git xyz" commands
>> during development, and so it happens that at times, I type
>> "git clean" by accident.
>
> Happened to me once.  I hate that command.
>
>> So, I propose *not* converting git clean to a C builtin,
>> but instead adding --untracked and --ignored options to
>> git-rm.
>
> I think what you are trying to do is to deprecate or remove "git
> clean".

Yes, and in the meantime I'd like to discourage people
from spending time and effort to upgrade it to first
class built-in status.

   -Geert
