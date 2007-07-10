From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP] Get rid of msys in favor of busybox port for windows
Date: Tue, 10 Jul 2007 12:12:47 -0400
Message-ID: <fcaeb9bf0707100912y69d1f406waf094e5f68e36ada@mail.gmail.com>
References: <fcaeb9bf0707100832j3c2ff076gab5c9bd4f9d3f4a0@mail.gmail.com>
	 <87eacd830707100856l3132bee2k45b8d59ac1875d89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Henning Rogge" <hrogge@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 18:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8IKb-0005cQ-QB
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 18:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651AbXGJQMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 12:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756943AbXGJQMt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 12:12:49 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:47507 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083AbXGJQMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 12:12:48 -0400
Received: by an-out-0708.google.com with SMTP id d31so272701and
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 09:12:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kGbGMpVrCnYjvmY3jCU2SvYhWRs9PH45EJcSP6K6NJ2ibFpAYNz2HEVg+BOmIxEtkdRUhtqVSpP9JM+dFqmE0bUL9XDIAyS3+saS8y7kZGyqk8DqT/YdE+sIUyVB5PqPj4YggD8Z3NYio7oUdKLYcJ45BmYsl1Y2UQU0twWD5h8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJ/6u48xOq7A12QMH/sAlN2gMHyIlvrNPe80MS4pIHRNUWzVBkmdsKYhPW5dntwm6rHmJC7YoHRGeQdreuRtJrNCX23sEhrQMOvE7mBRkm8jODJsavaspvgEROcDJWwc6WLV88sNLI7KcsLDyW0jdF2/5V29pgqGPZ5jgc5fkDc=
Received: by 10.100.190.8 with SMTP id n8mr2274942anf.1184083967694;
        Tue, 10 Jul 2007 09:12:47 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 10 Jul 2007 09:12:47 -0700 (PDT)
In-Reply-To: <87eacd830707100856l3132bee2k45b8d59ac1875d89@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52090>

On 7/10/07, Henning Rogge <hrogge@googlemail.com> wrote:
> On 7/10/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > I'm integrating some code from busybox to mingw tree so that mingw
> > port can work without msys. Posix utilities such as sed, awk, head,
> > tail... seem to work well. The main obstacle is ash, which is no where
> > near usable state (fork issues as always). Busybox ash is about 13000
> > lines of code, not too big.
> >
> > Anyone interested in?
> If I can use it without needing a "vi/vim" implementation I'm interested !

There is no vi/vim in the port :-) My goal is to make shell scripts
work with minimum effort. I don't even attempt to make ash
interactively usable (well, git add --interactive and friends have to
wait longer).
-- 
Duy
