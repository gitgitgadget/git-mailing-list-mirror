From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] gitweb: Uniquify usage of subroutine prototypes
Date: Tue, 25 Mar 2008 23:06:12 +0100
Message-ID: <b77c1dce0803251506y443aab5uf0134a47e9cf28de@mail.gmail.com>
References: <1206447114-29349-1-git-send-email-jnareb@gmail.com>
	 <7vlk46lh61.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 23:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeHII-0005Fz-8E
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 23:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbYCYWGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 18:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbYCYWGQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 18:06:16 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:43490 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYCYWGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 18:06:15 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1883863rvb.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TeXo2DKd6iNaW/WXkWWunQwq2lgXWnOegP2cSOs/rlw=;
        b=rSyHS2rSUip4nlNgHE1xYGrUJlxJIZ9zliYs6+uKK3TEvyzhlH0OISOZNWNUd9mKnqDCaQaibAGySovuwEI390UfCiLODm72tZbJJYRo8QGf7IJ90bHzz/njLEru6q9mLgJ7EDlS1KjivZdia4KEL8exTHr31I15bFp2lu2iKZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYQ4oYR2KvjPWfsPN1tCMhGjt3yhDZbteHFu/zd79RS6hrX7NMBzTKm8x+J0kdaxhDm9CXJOIvCZtAEOKL9D/AXhJBn6V+dyNvYXyXeHYB1bNFXNvw0OmrIL4DVqvU5aLTQliP+xFzTQg+SpcRLMY+8boCOeKBtnVxW0DXe1B2g=
Received: by 10.140.248.17 with SMTP id v17mr3827574rvh.9.1206482772531;
        Tue, 25 Mar 2008 15:06:12 -0700 (PDT)
Received: by 10.141.37.21 with HTTP; Tue, 25 Mar 2008 15:06:12 -0700 (PDT)
In-Reply-To: <7vlk46lh61.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78224>

On 25/03/2008, Junio C Hamano <junio@pobox.com> wrote:
>  I am not saying that Perl prototypes is a bad thing.  The point of the
>  prototype is to change the syntax and semantics so that you can write a
>  function to which arguments are _not_ passed as a flattend list, and
>  without them you cannot write something that emulates "push @a, $b, $c".

I would agree with what Junio says here. The primary motivation of
prototypes was to emulate the syntax of perl built-ins, and their
extension (with the _ character) in Perl 5.10 has followed this
general principle. As a general rule, I tend to avoid using prototypes
for 'normal' functions. That's mostly an application of the least
surprise principle.
