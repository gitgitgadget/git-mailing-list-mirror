From: Alexander Riesen <alexander.riesen@cetitec.com>
Subject: Re: [PATCH] Use the alternates of the source repository for dissociating
 clone
Date: Fri, 16 Oct 2015 09:00:57 +0200
Message-ID: <5620A0A9.5060007@cetitec.com>
References: <561F8DE9.4040703@cetitec.com> <xmqqbnbzhjym.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 09:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmz1J-0000kj-FT
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 09:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbbJPHBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 03:01:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49172 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbJPHBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 03:01:12 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue104) with ESMTPSA (Nemesis) id
 0LjbI0-1aOFdO0iWO-00bXWZ; Fri, 16 Oct 2015 09:01:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id E48F1B016C8;
	Fri, 16 Oct 2015 09:01:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SEs6i8r1Fl6Y; Fri, 16 Oct 2015 09:00:59 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.11.230])
	by pflsmail.localdomain (Postfix) with ESMTPS id 38F46B0167F;
	Fri, 16 Oct 2015 09:00:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqbnbzhjym.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:2UMCzQJUj/Q6/+JhEXjaSdQjtVi+T2NcZ2tqjoYZjdoStEizLmi
 m/bl9dpzV81O6yr9oTxmztjgVsGUTO0I/kCymG06H0qveJmkW9Gzh4F8jShFPbbue97ywJd
 ILvyDNUoEhQPMjT9xbzvAYs+2KXZ5YINUPquNduQA7f5ekJjaK5sDbiUqc5OlCExXTlT8Gq
 fbAdw3SDLxjGY3VqigbpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QhzjigDoDjU=:T/sc3q2vry+uTokbvz7qp8
 BNkMLh/OT7YWO88N2QU54q+VNR8YDT6J5WWekyUS/LE4AJs7tw7sWF1isv86fatxQh1hqC3Sm
 yGZxd1ihoRgfc5FHve1gagVtyBRWPffC6CExbdWsHbxumTqxX0lCfuRnE0QG1c0z+4YfHUGQu
 UQpp7raDw981iNixDzVSRYAZuLjMMEKd0o7nC7/14+iktlN2ZLXJpzaiOT6LLGZOoZilHMcsM
 jR92jIEiXZys8TY+QmTIC3M1fkihPedkJ6JagpFFOvkGcSXBrlhbr/lWYjEGxybPHF4jADqUk
 Q3jSzTXhcK0oKORC9QOOAVgUh8V1eOGcJ0xXi2WSvLPwbXvUrrbn0T9fWRt8bDy8h5sQPYLy/
 BU1DF3VNQ11859ZauipHMwevHs4H9mERH0ZvbnkY3aO4x/qojYMP0vM8YLJ7/JrRrwnGIJLy0
 2c+GhiX4h31eH0zyY+K6Y+okqtLudNJO3Og8wzVh/Dq4CT14MEexEJ5eK3fqhGhPU9/nlbr3k
 3oaXQdJ1rjzlbAh3X/ymSZMu8mTwSBpaPBQH4j93HQ+erDwwKri+TLeh0acNtthlMD1FUZKKC
 zRWI0RD77uwyQBM4/L+P2dzCEd1TkYT7WY4HK3GV3Hz5BTOHFm0Uyg5Cys9T8P9ZUaTADHTu8
 6afn1tyasDhCN6CK5qrhJx7FNpjeHaTEcjBUDj8jXYdGCPaXafMC1YAZ8JrOuNl3xGifOPfyN
 jsv+U5VcYlESisH4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279730>

Resend. The previous replies didn't make it to git-ml because of html part 
inserted by gmail.

On 10/15/2015 11:59 PM, Junio C Hamano wrote:
> Are you talking about making a clone of a repository that was
> created with "clone --reference", to borrow from the same
> third repository the original is borrowing from?
Yes. Or the alternates file was created manually in the source repository.
