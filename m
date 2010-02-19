From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: How to create patches for a merge?
Date: Fri, 19 Feb 2010 02:25:14 -0800
Message-ID: <83d7aaa41002190225o3255248re1581a86e1346f28@mail.gmail.com>
References: <83d7aaa41002180340p2f9b7241h9c220b84ec5dd1d@mail.gmail.com>
	 <20100218203738.GB8110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 11:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiQ33-00060C-PO
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 11:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab0BSKZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 05:25:16 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40827 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0BSKZP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 05:25:15 -0500
Received: by pwj8 with SMTP id 8so1965610pwj.19
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 02:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xl4FZE1T/kXkEqz9CsuL9a6zArpe1rOJGemqbfX1snM=;
        b=f/BDRegw8a8JqXIO8mYpIvQPzvd0AkeQV4twR4MhWAjBdeugeXVUHPy7m/9++sgBg5
         AyqhEwv1r7ab/DO+5wuKFjPOVv0KRr9oeSJ9H4k4Sb1QjYBuv8k9zwVbRdoJppXi2ffs
         dUR4KX6CUSBEwnFT8C6GVjrzO3y/Jp4IXm3/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aZXP7lUkrt81vOeQNaX2l5PtJMyogQfZ7CrNRIChDZhY/tP6CoDnDP6lSgab19ZY7C
         Km7O6eKg8dMLqMymGzT5UdBZHivsJNsszqnG7i1d9nvHWIQat6MgU/WDgpi7CuLs/YiI
         ttRVFdysNmiE8wYmqAT0sJzObgXDXeyQhlEb8=
Received: by 10.142.1.35 with SMTP id 35mr7348499wfa.344.1266575114706; Fri, 
	19 Feb 2010 02:25:14 -0800 (PST)
In-Reply-To: <20100218203738.GB8110@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140439>

On Thu, Feb 18, 2010 at 12:37 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 18, 2010 at 03:40:07AM -0800, Geoffrey Lee wrote:
>
>> When I use=C2=A0"git format-patch", it doesn't seem to include merge=
s. How
>> can I perform a merge and then e-mail it to someone as a set of
>> patches?
>
> Is it important that it be patches, or simply that it go over email? =
In
> the latter case, you can use "git bundle" to create a set of commits,
> including merges, and send them to the remote.

I was not aware of "git bundle". That does exactly what I need. Thanks!

-Geoffrey Lee
