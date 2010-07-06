From: demerphq <demerphq@gmail.com>
Subject: Re: global hooks - once again
Date: Tue, 6 Jul 2010 16:34:27 +0200
Message-ID: <AANLkTilP1tyHxdirhW08FZ-bzSxSCO-rH26uPBqIV2l2@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 16:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW9EO-000865-CZ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab0GFOea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 10:34:30 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63310 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0GFOe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 10:34:29 -0400
Received: by gye5 with SMTP id 5so1786091gye.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eDO41ZXlfS5I+BdPndSu99AwRkcNVEc4+KDeOs9238Q=;
        b=Q7MYybGT/+IMnNvI8RzafGrC6/Cjs0EUv2pvqG7kY6g6WD157JFV97UarAbH+JliuQ
         pRJqYoHGn30jvKByWtagkgIV8WX0QzqMOT+1cpx3+9j+l5gprfGWkILPSEwOsDESF/RG
         KYQVD73RLX1DkxYMV6VT+4HfPzZCnii+CQuP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d8ZsPlmwCM6AwAuUMGAPDz7aU8B2UlF30kTWcYt4ickQKal5yhVnWFcR+QO4CG72xN
         k0OT3rAdveJR1oCAbt1QpYB3a62ycDgFpI7sM6X0j4A9Jz5P7ZPVW+k/JWGGDahQb0T2
         4HvfwcptwezxgubCWxFGqSLL4SPP8HRQ5EIJI=
Received: by 10.239.154.198 with SMTP id f6mr416261hbc.12.1278426867574; Tue, 
	06 Jul 2010 07:34:27 -0700 (PDT)
Received: by 10.239.183.201 with HTTP; Tue, 6 Jul 2010 07:34:27 -0700 (PDT)
In-Reply-To: <AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150355>

On 2 July 2010 21:47, Eugene Sajine <euguess@gmail.com> wrote:
> On Fri, Jul 2, 2010 at 3:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> For example, so i could say
>>> $ git config --global hooks.dir ~/git/hooks
>>
>> I don't think "global" hooks are useful for people who work on more than
>> one project, or people who interact in more than one ways to projects.
>> Different projects typically have different needs out of the hooks
>> (e.g. pre-commit policy), and different workflows typically call for
>> different needs out of the hooks (e.g. I would want to be able to rebase
>> in my private working repository but not in the repository I use for
>> integration of other people's branches).
>>
>> So I am fairly negative on your particular example above.
>
>
> Well, you forgot about another half of users that are working with
> many projects but using one policy for example in one company,

$work is like this. Any repo on our version control host will share a
common set of hooks.

yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
