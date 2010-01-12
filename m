From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: -L should show empty files
Date: Tue, 12 Jan 2010 22:27:37 +0100
Message-ID: <fabb9a1e1001121327s392f7311t2a7f11081ed70ff8@mail.gmail.com>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com> 
	<alpine.LFD.2.00.1001040801290.3630@localhost.localdomain> 
	<7vvdf9402f.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain> 
	<alpine.LFD.2.00.1001110748560.13040@localhost.localdomain> 
	<7vtyusr4r7.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain> 
	<7v63774tfd.fsf@alter.siamese.dyndns.org> <7vvdf73eql.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 22:28:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUoHV-0001M7-Qb
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 22:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0ALV17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 16:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296Ab0ALV17
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 16:27:59 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:38960 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0ALV16 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 16:27:58 -0500
Received: by pxi4 with SMTP id 4so4933511pxi.33
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 13:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=inHBARdq9Lv6VorrgEi/RSibc8VqeVJdq+SguyDHA28=;
        b=vz76yA0VWOvcWCpeEQRARK5B37j6WksQcY4/SddAwkXXnrD3Eer4Ksda+XgAyhUHHh
         va0eQ8Sh7idHBvwYNZXWmz1AJYqn0MIcmjhHvNA7cGCbCWcvYoo+OOAVX5/eCIyQf/cz
         8tERtv9ByHB89g6YyX4SjuOtEX45teFsERe5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CKMzSOH+IDLrMuJP5bCjnXwLyPpfoXFSD+MhGM2idIjhPoBwCA/4WCHGsyFQezZUnc
         IbeAGQHTAvk6LRyI1nN0wtIqx473fLzt6ET0iBpOMKfF6Oe1P8mRPm1LKXQf7nU1P2z+
         J3uSKk4HbCz0462/3pkZHEi7m4prVvHnuGRKA=
Received: by 10.143.153.11 with SMTP id f11mr879108wfo.325.1263331677771; Tue, 
	12 Jan 2010 13:27:57 -0800 (PST)
In-Reply-To: <7vvdf73eql.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136759>

Heya,

On Tue, Jan 12, 2010 at 09:32, Junio C Hamano <gitster@pobox.com> wrote:
> This optimization doesn't matter too much in practice (a tracked empty
> file must be rare, or there is something wrong with your project);

How about python projects, where there's an __init__.py file
everywhere you turn your head? ;)

-- 
Cheers,

Sverre Rabbelier
