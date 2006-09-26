From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] gitk: Fix nextfile() and more
Date: Wed, 27 Sep 2006 00:19:16 +0900
Message-ID: <877izq3bbf.fsf@duaron.myhome.or.jp>
References: <873bag12k3.fsf@duaron.myhome.or.jp>
	<7vpsdjryj2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Sep 26 17:27:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSElk-0002kM-I0
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 17:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWIZPWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 11:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWIZPWp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 11:22:45 -0400
Received: from mail.parknet.jp ([210.171.160.80]:53001 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932115AbWIZPWp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 11:22:45 -0400
X-AuthUser: hirofumi@parknet.jp
Received: from ibmpc.myhome.or.jp ([210.171.168.39]:2038)
	by parknet.jp with [XMail 1.21 ESMTP Server]
	id <SACAA> for <git@vger.kernel.org> from <hirofumi@mail.parknet.co.jp>;
	Wed, 27 Sep 2006 00:21:22 +0900
Received: from duaron.myhome.or.jp (duaron.myhome.or.jp [192.168.0.2])
	by ibmpc.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8QFKKIv004617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:20:21 +0900
Received: from duaron.myhome.or.jp (localhost [127.0.0.1])
	by duaron.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8QFKKxN004288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:20:20 +0900
Received: (from hirofumi@localhost)
	by duaron.myhome.or.jp (8.13.8/8.13.8/Submit) id k8QFJG4v004286;
	Wed, 27 Sep 2006 00:19:16 +0900
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsdjryj2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 25 Sep 2006 22\:24\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27796>

Junio C Hamano <junkio@cox.net> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
>
>> The current nextfile() jumps to last hunk, but I think this is not
>> intention, probably, it's forgetting to add "break;". Right?  And this
>> patch also adds prevfile(), it jumps to previous hunk.
>>
>> The following part is just my favorite the key-binds, it doesn't matter.
>>
>> +    bind . <Control-p> "$ctext yview scroll -1 units"
>> +    bind . <Control-n> "$ctext yview scroll 1 units"
>> +    bind . <Alt-v> "$ctext yview scroll -1 pages"
>> +    bind . <Control-v> "$ctext yview scroll 1 pages"
>> +    bindkey P prevfile
>> +    bindkey N nextfile
>>
>> What do you think of this?
>
> . As a patch e-mail, the initial Hi and trailing Thanks add
>   additional work for the person who applies patch.

Ok.

> . I do not have preference on the extra bindings.  I do not
>   speak for Paul, but I suspect he would have liked them in a
>   separate patch.

Ok. I'll send patches.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
