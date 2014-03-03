From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] cache_tree_find(): remove redundant check in while condition
Date: Mon, 03 Mar 2014 18:25:52 +0100
Message-ID: <8761nvkxcv.fsf@fencepost.gnu.org>
References: <1393862885-23271-1-git-send-email-mhagger@alum.mit.edu>
	<87a9d7kztm.fsf@fencepost.gnu.org> <5314B6E4.7030607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:26:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKWd4-0007um-KR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 18:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbaCCR0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 12:26:09 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56406 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaCCR0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 12:26:08 -0500
Received: from localhost ([127.0.0.1]:55448 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKWcx-0008TQ-I5; Mon, 03 Mar 2014 12:26:07 -0500
Received: by lola (Postfix, from userid 1000)
	id 91418E077A; Mon,  3 Mar 2014 18:25:52 +0100 (CET)
In-Reply-To: <5314B6E4.7030607@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 03 Mar 2014 18:07:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243237>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/03/2014 05:32 PM, David Kastrup wrote:
>> [...]
>> So perhaps all of that should just be
>> 
>> 		while (*slash == '/')
>> 			slash++;
>> 		if (!*slash)
>> 			return it;
>> 
>
> I just fixed a little thing that caught my eye.  You OWNED it.  You are
> absolutely right.
>
> Will you prepare a patch or would you like me to do it?

Feel free.  I really should be finishing some other patches instead...

-- 
David Kastrup
