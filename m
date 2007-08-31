From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb and remote branches
Date: Fri, 31 Aug 2007 04:15:40 +0200
Message-ID: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
References: <favitd$3ff$1@sea.gmane.org>
	 <7vbqco91fi.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0708301609s330f8d6fna3755bff346452ab@mail.gmail.com>
	 <200708310153.29625.jnareb@gmail.com>
	 <cb7bb73a0708301659q6ccc1211w2c7ce315051a605e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 04:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQw30-0000BF-Ve
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 04:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbXHaCPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 22:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXHaCPn
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 22:15:43 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:61213 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXHaCPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 22:15:43 -0400
Received: by py-out-1112.google.com with SMTP id u77so3204622pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 19:15:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IXu2wY4cBHf5UQIoUKDXvfFVBEsx4ure+EQH4yP5uAQQOFRhRNbChjFbYkhWiFv0jYM6+OCjgXHVZhCHjiSv6HlM2WY7MZiMNbjwd/TB1/4QWhRib2e5F4WTmK1swiTc1RK5/HR5PabHSc0gwmpCmjxkAkLqV+9QWWMJmi0QCiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dgm8dR6/Feb4uhY7YUnABpBnAa3yyTQyTMTZrx8kWmpmxZ9Em07JkN9AERlpZS6PnQV4btPE2+AQCtFeFNa7Res51suRN6N2hhVRRSyA66DawhYUWvUvFgG2GylSP49thmqf5fqG7aj8qsW+htffOfzNHexJh+miQuvcZjsg4X4=
Received: by 10.35.69.11 with SMTP id w11mr1328233pyk.1188526540379;
        Thu, 30 Aug 2007 19:15:40 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 19:15:40 -0700 (PDT)
In-Reply-To: <cb7bb73a0708301659q6ccc1211w2c7ce315051a605e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57105>

On 8/31/07, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> On 8/31/07, Jakub Narebski <jnareb@gmail.com> wrote:
> > On Fri, 31 August 2007, Giuseppe Bilotta wrote:
> > > If I understand correctly, a detached HEAD is simply a checkout in the
> > > middle of a branch, and thus not named. So what exactly are we looking
> > > for when we talk about supporting a detached HEAD? Would it be enough
> > > to display HEAD in the list of heads?
> >
> > I think we want display HEAD in the list of heads if it is detached,
> > and also use it as a ref marker, while only marking (with undeline or
> > bold style) current head as such if HEAD is not detached, i.e. is
> > symref or symlink.

Ok, implementation at

http://oblomov.dnsalias.org/git?p=git.git;a=summary

comments welcome. You can see it in action here

http://oblomov.dnsalias.org/git?p=gittest.git;a=summary

It may not be the smartest implementation, but it's what I could cook
up with my limited git knowledge. Plus, since it's WAY past my
bedtime, I'll have to dealy publishing my gitweb-allheads at least
until tomorrow.

Have fun,

-- 
Giuseppe "Oblomov" Bilotta
