From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: textconv not used for diff
Date: Wed, 6 Oct 2010 23:10:17 +0200
Message-ID: <AANLkTik8XzRA5i3y265OdYC3_fBPxiT1KPb7K003JRDj@mail.gmail.com>
References: <AANLkTi=Y2U1DqnW4oA7_MD3gZMXYzFCFYHwKuuonsmA0@mail.gmail.com>
	<vpqr5g3f42b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 06 23:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3bFr-0006U5-HH
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 23:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268Ab0JFVKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 17:10:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53978 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab0JFVKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 17:10:20 -0400
Received: by bwz11 with SMTP id 11so18215bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LNja66p/ttXSD+YNXzIyH2UGVsiEknawPKHhhS3mVuM=;
        b=rU+oTiX2r0OPzpv80qTE9LqbLPZIFUvNlpsIfWhCzazH56glKKRwP4orxnN8xEVLZr
         +Cq9k1G4IuumBTEMYuoFFRMDogVUU+pYH7Uurb0T4jwUFORFC/jkPDYvhxL2ul7QhVBG
         4FjSsEoOUhOZZG4z3JyDYTeG+EIN/3dQN/4mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lofgzXpDdZTBU5SV5Owpil1KyizjOsklZy//qHyzHbAEZGYrCKhwmYzNpfxETSIkV6
         heAXzm/o7XuCJeOOgikJPI3zxB3NXfvgL9eXEqdbfN9282i4GZugN7SdP8PjPVULk4kP
         sgGReFp/qWAmtQzEh2didcf6TbvYz+8kSy504=
Received: by 10.204.73.13 with SMTP id o13mr10116147bkj.173.1286399417513;
 Wed, 06 Oct 2010 14:10:17 -0700 (PDT)
Received: by 10.204.46.211 with HTTP; Wed, 6 Oct 2010 14:10:17 -0700 (PDT)
In-Reply-To: <vpqr5g3f42b.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158308>

On Wed, Oct 6, 2010 at 10:40 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Victor Engmark <victor.engmark@gmail.com> writes:
>> After trying for a couple hours to get textconv to work according to
>> <https://git.wiki.kernel.org/index.php/Textconv> and other pages, I've
>> given up. I've tried changing .odt, .ott and .ods files, but git-diff
>> never outputs the text diff:
>>
>> $ git --version
>> git version 1.7.0.4
>> $ cat ~/.gitattributes
>
> .gitattributes file should be in the working tree, not in your $HOME.
>
> The development version of Git has a core.attributesfile variable that
> would allow you to have a user-wide ~/.gitattributes, but this isn't
> released yet.

Thank you very much! To the point and with bonus info for later. Works a charm.

-- 
Victor Engmark
