From: Perry Smith <pedzsan@gmail.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Wed, 28 Jan 2009 09:03:23 -0600
Message-ID: <87325FCF-CD16-43CE-9CD0-CAC73904903A@gmail.com>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com> <20090126210027.GG27604@coredump.intra.peff.net> <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com> <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com> <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com> <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com> <20090128070114.GB19165@coredump.intra.peff.net> <7v4ozjx4ni.fsf@gitster.siamese.dyndns.org> <20090128074204.GA31951@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 16:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSByX-0004Lo-Md
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 16:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbZA1PD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 10:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbZA1PD2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 10:03:28 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:34589 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbZA1PD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 10:03:27 -0500
Received: by mail-qy0-f11.google.com with SMTP id 4so7961762qyk.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=WcP0rjf/W6YIt54/kmIs9TLfYNNudvzC1arncXL5SRM=;
        b=n7nJnJioAcrlOXzksV3XeofeJL5SGhVv0LLIvoASR6JoFhKntka4HWPzj/yDXNjFzs
         ruAfoT5bzEEUn97OiFLEoRzOVmI+2lze/TqgXMLWcVI5j2cRPtMVdNo6DFTTzZHIYPDa
         Ng3yNduEbg0SvAt796Z9oOXZLOI+r1RRj1ESs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=v9F6kVCzTk/M26d6V2jHqjkGO7zFRDSgAuhjuDDdjG4yEYDsbC0JwYw7fR5pKC6Mbd
         QJ+foqAMMWrZ1qPRbytnRBEdXdV28qgJlYsLVm3t9xbxCSvU/qiWK1nMplwzfyYS2FZk
         QaM8VpM0TSN8yqMx4crHoSiYl0qv4putbkZwo=
Received: by 10.214.81.3 with SMTP id e3mr6830123qab.66.1233155007239;
        Wed, 28 Jan 2009 07:03:27 -0800 (PST)
Received: from newtoy.easesoftware.com ([64.128.19.234])
        by mx.google.com with ESMTPS id 7sm3355221qwf.7.2009.01.28.07.03.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 07:03:26 -0800 (PST)
In-Reply-To: <20090128074204.GA31951@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107541>

On Jan 28, 2009, at 1:42 AM, Jeff King wrote:

> On Tue, Jan 27, 2009 at 11:37:21PM -0800, Junio C Hamano wrote:
>
>>>> Just to be sure we are on the same page.  My directory structure  
>>>> has a
>>>> top/src/git-1.6.1 and top/build/git.1.6.1.  The src/git-1.6.1 is  
>>>> the
>>>> tar ball.  The  build/git-1.6.1 starts out empty.  I cd into it and
>>>> then do: ../../src/git-1.6.1/configure <options>  After this
>>>> completes, you can do "make".
>>>
>>> I don't see how this would work without automake support, which  
>>> git does
>>> not have.
>>
>> ... nor want to have ;-).
>
> Heh. Yes, in case there was any confusion: I don't want my statement  
> in
> any way to be construed as a suggestion to support automake.
>
> I would not be opposed to it if it somehow enhanced some users'
> experience without bothering people who didn't want to touch it (like
> the way that autoconf support is implemented). But I don't see how  
> that
> would be possible.

Thats fine.  I didn't know if this was a "known" situation or not so I  
just mentioned it.

As I mentioned, most open source code supports this style of build.  I  
have no idea
what it would take to get it to work.
