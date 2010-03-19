From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 06:16:27 -0600
Message-ID: <b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> 
	<b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> 
	<alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm> <20100319115445.GA12986@glandium.org> 
	<3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Hommey <mh@glandium.org>, david@lang.hm, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:17:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsb8X-0007iH-3g
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab0CSMQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:16:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:3294 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0CSMQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:16:49 -0400
Received: by fg-out-1718.google.com with SMTP id l26so168059fgb.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+RQ0wYkRwSDw9Fz3NQl+yh//wXafyKp8aMkircfGHU8=;
        b=RcV4xD6PuoX7XIrFT4TcH4xMdsj2C0gd6geD2uLsYMvcYjXboSMnZTzh1GsQAP9wr3
         hQMhbqzkjA9JXC5Jvn28MBznYg9y92KjwuBdaqmJ2M58zDmnlxlDa+gcxFyCzKM8tikk
         O4yjtJbY4mvkQZ2ytnU0b9phSZMZXItDZOjqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QcVXr06kjXe6oPpZXdggau4kiGmYzpVTBmNc42KL0DhxueqAaVGYIIkUHr18bIf0wa
         5G2zauUQSu3Hm23Gvze+51f9aFod1euTj7hpX0hqfrdBggIVIxMCZOJIybNLaJR7/zbi
         OT2kTdHXnL9bCflmxvF+95/it+ET9nv9FRGbg=
Received: by 10.239.190.65 with SMTP id w1mr1644449hbh.126.1269001007095; Fri, 
	19 Mar 2010 05:16:47 -0700 (PDT)
In-Reply-To: <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142581>

On Fri, Mar 19, 2010 at 06:09, Reece Dunn <msclrhd@googlemail.com> wrote:
> On 19 March 2010 11:54, Mike Hommey <mh@glandium.org> wrote:
>> On Fri, Mar 19, 2010 at 04:45:38AM -0700, david@lang.hm wrote:
>>> here is where you are missing the point.
>>>
>>> no, there is not 'much less chance' of it getting messed up.
>>>
>>> you seem to assume that people would never need to set the UUID on
>>> multiple machines.
>>>
>>> if they don't need to set it on multiple machines, then the
>>> e-mail/userid is going to be reliable anyway
>>>
>>> if they do need to set it on multiple machines and can't be bothered
>>> to keep their e-mail consistant, why would they bother keeping this
>>> additional thing considtant? Linus is pointing out that people don't
>>> care now about their e-mail and name, and will care even less about
>>> some abstract UUID
>>>
>>> people who care will already make their e-mail consistant.
>>
>> While I don't agree with the need for that uuid thing, I'd like to
>> pinpoint that people who care can't necessarily make their e-mail
>> consistant. For example, Linus used to use an @osdl.org address, and
>> he now uses an @linux-foundation.org address. It's still the same Linus,
>> but the (name, email) pair has legitimately changed.
>
> So create an aliases list that maps one (name,email) to another that
> is from the same person. There is no need for an additional item (a
> uuid) to solve this problem. It also means that searching on any
> (name,email) pair will find the others, so you only need to
> remember/find one of the identities for the person you are interested
> in finding the commits for.
>
> AFAICS, mailmap is about correcting mistakes (primarily in the
> reported name for a given email address). In this case, mailmap and
> this aliases-map will work in conjunction with each other to give what
> the original poster wanted. However, I haven't seen any of his replies
> that answer this (or sufficiently address why mailmap does not solve
> his problem).

See:

    http://marc.info/?l=git&m=126900051102958&w=2

The idea is to distribute the responsibility for maintaining a
consistent identity AND to make that responsibility EASY.

The extra uuid `field' can only suffer from typos, while the
name/email pair can suffer from typos, changing email accounts, and
changing real life names. If the uuid `field' does get bungled by a
typo or is not used, then we're no worse off than we were before.
