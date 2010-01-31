From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Stepping through a single file's history
Date: Sun, 31 Jan 2010 00:26:07 -0800
Message-ID: <4B653E9F.2080109@pcharlan.com>
References: <5699F80A-4B27-4BAB-BEE8-5C48938A970B@flownet.com> <43d8ce651001281758x79965b5fn8760b69d4fe82a36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ron Garret <ron@flownet.com>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 09:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbV8K-0007jj-Oa
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 09:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab0AaI0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 03:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907Ab0AaI0L
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 03:26:11 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:35134 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751786Ab0AaI0K (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jan 2010 03:26:10 -0500
Received: from [192.168.0.119] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id B2C378F340;
	Sun, 31 Jan 2010 00:26:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <43d8ce651001281758x79965b5fn8760b69d4fe82a36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138535>

On 01/28/2010 05:58 PM, John Tapsell wrote:
> 2010/1/29 Ron Garret <ron@flownet.com>:
>> Hello,
>> 
>> Is there an easy way to step through the history of a single file?
>> To be more specific:
> ...
>> (The use case here is remembering that back in the day there was
>> some useful code in this file that I want to retrieve, but not
>> remembering exactly when it was deleted.  So I want to step back
>> through this file's history and do diffs against HEAD.)
> 
> How about simply doing:
> 
> git log -p filename
> 
> and then you can search by pressing "/"  and then typing whatever you
> remember.
> 
> John

Have you tried "git log -Sfoo filename", which finds commits that
changed the number of occurrances of string "foo" in filename?  I've
found that quite useful in digging up deleted code.

It's not as thorough as grepping "git log -p filename", but in practice
I've found it very effective.

--Pete
