From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Tue, 9 Apr 2013 23:33:59 +0530
Message-ID: <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net> <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org> <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcuU-0002db-1E
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760879Ab3DISEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:04:41 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51298 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab3DISEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:04:40 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so9042501ieb.29
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Hr8ZFDdCmkv5vNdmnsD5pWPZupH+fe7vXo3D5clhA1g=;
        b=D1JdHxdNgKkjQZzw/OQleh4tiwNX4SSukprgdAEfJeBZwj7Gf9Qt/2rb5WAlzH6oLU
         PhTvTdGsCrGen1ryX+r9GYV3lStTmJcUy7IV8IoZPoJztTF3GG74vo1J+pv1GBaliQFn
         q2JCgiGDQd7m7KGGlQyMhTLs+cR3A3M8w+M1dgLkJxtvzXNsrkjAJZ0DYeutI9fHaXNQ
         a628ELR0s6trJk5Lw2o/HBrBCQxjvMP5DI5SHnWfDXUBHJ6jxy7w/6+nV2SuiQ85Mlt+
         uZ06s3KvhdvEkw4dDB6xXFVTzV+lfe5Wr6RH4j0uOYcq0SnPlpDUFYIkjGvm2UNOxjGL
         Qgcw==
X-Received: by 10.50.50.71 with SMTP id a7mr10724317igo.14.1365530679955; Tue,
 09 Apr 2013 11:04:39 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 9 Apr 2013 11:03:59 -0700 (PDT)
In-Reply-To: <7vip3vsi19.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220605>

Junio C Hamano wrote:
> What is bad about saying "push origin ...the rest..."?

I don't know which remote to push to: all I know is that the remote to
push to is configured somewhere in the web of branch.remote,
remote.pushdefault, and branch.<name>.pushremote, and I don't want to
have to figure that out by hand.  Ever since we got triangular
workflows, I've been missing the implicit beauty when I have to
force-push some refs.
