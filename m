From: Jakub Narebski <jnareb@gmail.com>
Subject: News reader woes (was: Re: [3/4] What's not in 1.5.2 (new topics))
Date: Fri, 25 May 2007 11:55:35 +0200
Message-ID: <200705251155.36835.jnareb@gmail.com>
References: <200705170539.11402.andyparkins@gmail.com> <7vsl9u55tv.fsf@assigned-by-dhcp.cox.net> <20070520001610.GD4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 25 11:51:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWSC-0000aE-2o
	for gcvg-git@gmane.org; Fri, 25 May 2007 11:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761242AbXEYJup (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 05:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761251AbXEYJup
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 05:50:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:44522 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761242AbXEYJun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 05:50:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1081945ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 02:50:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i7WAW7Jj0f9xgX7/061tly1I9TUVK/xcWkxg7OcDQjF9lMh+inpP0sjI5bU/HFtJm0fkFMeF6EQT7/I72CPbl3eSuYMJQbjjMSSSrAJ/YwX/KNTMrcEwP+1h9S1ddDZSWEcNsxDFcbIlKS8EfXywYlaszn1UC3gPJWPOxTnMkQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PzcLpR7IRUYGqaBXo+dnJYozRXMbQSn/XURRYnW9BPtkdvRe827qCXOQ1JWTqf2NgvVT14tdsudKl/f9qBm0v+7NkwOgzB7Wxfx2I58gAUSngqwHUlKi6FfXjpDpklyf8hu3Sq8tLH2g/JA/pFYtZCi1UNG0JROYSvg2Uz+OdBE=
Received: by 10.67.32.19 with SMTP id k19mr2812726ugj.1180086641870;
        Fri, 25 May 2007 02:50:41 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w40sm556311ugc.2007.05.25.02.50.38;
        Fri, 25 May 2007 02:50:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070520001610.GD4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48350>

On Sun, 20 May 2007, Petr Baudis <pasky@suse.cz> wrote:
> On Fri, May 18, 2007 at 08:45:16PM CEST, Junio C Hamano wrote:
>> Julian Phillips <julian@quantumfyre.co.uk> writes:
>>> On Fri, 18 May 2007, Junio C Hamano wrote:
>>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>>
>>>>> [Cc: Petr Baudis <pasky@suse.cz>, Josef Weidendorfer
>>>>> <Josef.Weidendorfer@gmx.de>, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
>>>>> Junio C Hamano <junkio@cox.net>, Andy Parkins <andyparkins@gmail.com>,
>>>>> Nicolas Pitre <nico@cam.org>, git@vger.kernel.org]
>>>>
>>>> Offtopic.  Why do you do this, and what benefit are you or
>>>> anybody in the above list, which is in body part of the message,
>>>> getting?
>>>
>>> It looks like he is posting through gmane using a news reader ... so
>>> the list post comes from gmane while the CCs go out directly (I
>>> assume).
>> 
>> Ah, I see.  The names listed on that in-body CC: do appear on
>> the To: in the copy of the message that came via e-mail.  If
>> that is how gmane operates then there is nothing Jakub to do to
>> improve it, I guess...
>> 
>> Thanks for the clarification.
> 
> Actually, Jakub, if it can be turned off, could you, please?
> 
> Not getting cc'd on replies is slightly annoying. But this is highly
> confusing - suddenly I must take care _not_ to reply to the private
> copies, and we actually do have a parallel subthread of replies to your
> mail not cc'd to the mailing list. :-(

The problem, and mentioned above trying to overcome it, lies in
complicated interaction between the GMane news to email gateway,
vger mail filtering (spam protection rules) and the _news_ reader
I use, namely KNode 0.10.2 from KDE 3.5.3.

I read git mailing list via GMane NNTP (Usenet, news) interface:
  nntp://gmane.comp.version-control.git
as I respond only rarely. I start new threads using email, and
if I get reply via email I try to reply also from mail client, not
via news. However, when replying to message which I read only via
NNTP interface, replying in news client, I have option of sending
reply only to gmane.comp.version-control.git which means sending
email only to git mailing list and breaking Cc: list. 

Another option is to copy Cc: list manually to To: field (no Cc:
in this version of KNode), and have gmane.comp.version-control.git
in the Group: field.  The fact that there is no Cc: to set is the
problem of KNode.  The problem with GMane and vger interaction lies
in the fact that I _cannot_ put git@vger.kernel.org in the To: list,
as somehow vger rejects mails sent via GMane (it does not rejects
news messages send via GMane).

I could also copy whole message to mail client, but this would break
In-Reply-To: and references: headers, thus breaking threading.


Do I understand correctly that you prefer 1st option, namely replying
only to newsgroup / git mailing list?


Note that changing news client is as hard as changing email client:
you would like to migrate configuration, news state (read/unread
articles) and sent/drafts folders to new news client. Not that easy.

-- 
Jakub Narebski
Poland
