From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 12:09:26 +0000
Message-ID: <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4BA338C1.7030803@alum.mit.edu>
	 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
	 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
	 <20100319115445.GA12986@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: david@lang.hm, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:09:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsb1E-0004Vt-4j
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab0CSMJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:09:29 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39757 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0CSMJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:09:28 -0400
Received: by wwe15 with SMTP id 15so1748504wwe.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=gsdghaqTVkDOxLcJvAOZHI8fu5smi9iPys7Q8DKkFy4=;
        b=NfOqjftBQNok2o6kAUH5y3kDlFNORFhcFkXLmzsUZVaDlviCbd+GWkPrtAZrQmFXhz
         MG5CpCvWztFUwAfnvOWhjX/7jZGKYJIcLrjftnmWrAhigRmfGkfr90mPdg8ninZ/4mRU
         w2+Hv4YviVye/S1tTld9L8wqqjA+MRKTkSHUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZT9jMs7tHoaQiiaeBdBeCX9l+dDWWIUUSUb3Ch3Va9lRoGV4XTTPMQT8d8o85cUraA
         GB6mog/S+hQV2ihWeMsoFieWIJ8xBOIJMpjWgXEQC8y96XDZs6NDEZnCLIYn/cUkiYYo
         oOS9sEiGPLIMzZGLd49llZT/o266uKqafOMtg=
Received: by 10.216.93.68 with SMTP id k46mr786147wef.104.1269000566970; Fri, 
	19 Mar 2010 05:09:26 -0700 (PDT)
In-Reply-To: <20100319115445.GA12986@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142579>

On 19 March 2010 11:54, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Mar 19, 2010 at 04:45:38AM -0700, david@lang.hm wrote:
>> here is where you are missing the point.
>>
>> no, there is not 'much less chance' of it getting messed up.
>>
>> you seem to assume that people would never need to set the UUID on
>> multiple machines.
>>
>> if they don't need to set it on multiple machines, then the
>> e-mail/userid is going to be reliable anyway
>>
>> if they do need to set it on multiple machines and can't be bothered
>> to keep their e-mail consistant, why would they bother keeping this
>> additional thing considtant? Linus is pointing out that people don't
>> care now about their e-mail and name, and will care even less about
>> some abstract UUID
>>
>> people who care will already make their e-mail consistant.
>
> While I don't agree with the need for that uuid thing, I'd like to
> pinpoint that people who care can't necessarily make their e-mail
> consistant. For example, Linus used to use an @osdl.org address, and
> he now uses an @linux-foundation.org address. It's still the same Linus,
> but the (name, email) pair has legitimately changed.

So create an aliases list that maps one (name,email) to another that
is from the same person. There is no need for an additional item (a
uuid) to solve this problem. It also means that searching on any
(name,email) pair will find the others, so you only need to
remember/find one of the identities for the person you are interested
in finding the commits for.

AFAICS, mailmap is about correcting mistakes (primarily in the
reported name for a given email address). In this case, mailmap and
this aliases-map will work in conjunction with each other to give what
the original poster wanted. However, I haven't seen any of his replies
that answer this (or sufficiently address why mailmap does not solve
his problem).

- Reece
