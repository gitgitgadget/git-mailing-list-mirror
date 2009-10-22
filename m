From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ks/precompute-completion (was Re: What's cooking in git.git (Oct 
	2009, #04; Wed, 21))
Date: Thu, 22 Oct 2009 12:11:27 -0500
Message-ID: <fabb9a1e0910221011r957246dx3162cd675ff16800@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <4AE0190E.8020803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 19:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N11Ce-0006Cm-N2
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbZJVRLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Oct 2009 13:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbZJVRLn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 13:11:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:44249 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZJVRLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 13:11:43 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1738283eyd.19
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PHNQ++A+JNUbwWJsaVNOianayeMOyElbRome6+R65Q4=;
        b=TY+wA+4DepNs29dILW+x0HuyuLHreqnlrvYbOI3JSQvGXOV6jTX4AAppqd9LJh+GFz
         oSVqaaLzmhPLaxTcRdBUJj0E47a9pXfVbS67wBhyHmvgtXmLSdKMDd7a6O0X8b/FAR6T
         uPaZnDrN3AyUJVF4p+uhbaiGAgwcEuW1jHVgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bWHN4ZfGhzStQkBe+hoIHJgh6sQhQShgPqM/mgBJ5oVZ0C4WcLGkrtfrHcSx15bU3K
         lpfb973MSrEj+piZQSOq3MIS8ZmjTHc8JcpRmVR0XsLiJQTUaaXl79IYHCadlnIsXENC
         UxmFtyNflakkBhAFO6/+KQdn3BFdHH8XWdwwo=
Received: by 10.216.88.18 with SMTP id z18mr3515525wee.78.1256231507163; Thu, 
	22 Oct 2009 10:11:47 -0700 (PDT)
In-Reply-To: <4AE0190E.8020803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131033>

Heya,

On Thu, Oct 22, 2009 at 03:34, Stephen Boyd <bebarino@gmail.com> wrote:
> Junio C Hamano wrote:
>> * ks/precompute-completion (2009-10-05) 1 commit.
>> =A0 (merged to 'next' on 2009-10-14 at adf722a)
>> =A0+ Speedup bash completion loading
>>
>> Are people happy with this?
>
> No. I now have rebase.sh, am.sh, etc. in my completion

I would really like it if running 'make && make install' in git.git
would also build the completion script, I don't want to have to
remember to run 'cd contrib/completion && make' every time we get new
completion options :P.

--=20
Cheers,

Sverre Rabbelier
