From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] Introduce CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 11:50:31 -0500
Message-ID: <AANLkTike1Xf6+NNs0QJuzLibN8VyHVOTjQuX=zd_mqCe@mail.gmail.com>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-2-git-send-email-jaysoffian@gmail.com> <AANLkTim8m4uBjn_FJ-SWnARkv8rTiM1SrBTBFeg2R_hd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 17:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppkas-0006yn-JW
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab1BPQvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 11:51:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1BPQvD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 11:51:03 -0500
Received: by iwn9 with SMTP id 9so1510092iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xVkWLcPNDBkvBJdfHEoJ5mbAAkCcK9VvlrjVJCeLPSI=;
        b=uEe9UqHP9aoGhEc9w/dJI/f24TcltUoPpLZpUIfrTuIKqbxHkMvlEwwENGqO1AqN+y
         eUYSdLn1/cg/dbYmFaWqd8a0wARnpWC6SNQPCoqcQydjQhMMM/Yc6uW5TtKxj5B+MSvs
         +GRWTZpsxNnouXKDtmDOat/KQiCuoKUO87cA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=C7P8ciM1Fk8F80VH0z02ifwFkqVz4GFxpC2Jlg8BX+M9rekk0kwsNRB8OBJuITXhfS
         H7LtBXK2KL5i+GX0IYaXUfx1xZ2ftOl9B4QjCHpD6xNIBdV9yuqD1bsnJ3oBcet5x78e
         KOem4frza3g3jdF1IlzNMEmsWDgVW7gOnqpMQ=
Received: by 10.231.37.138 with SMTP id x10mr669714ibd.192.1297875061800; Wed,
 16 Feb 2011 08:51:01 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 08:50:31 -0800 (PST)
In-Reply-To: <AANLkTim8m4uBjn_FJ-SWnARkv8rTiM1SrBTBFeg2R_hd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166975>

On Wed, Feb 16, 2011 at 6:13 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Wed, Feb 16, 2011 at 5:08 PM, Jay Soffian <jaysoffian@gmail.com> w=
rote:
>> When a cherry-pick conflicts git advises to use:
>>
>> =C2=A0$ git commit -c <original commit id>
>>
>> to preserve the original commit message and authorship. Instead, let=
's
>> record the original commit id in CHERRY_PICK_HEAD and advise to use:
>>
>> =C2=A0$ git commit -c CHERRY_PICK_HEAD
>
> Wouldn't it be more convenient to do "git cherry-pick --continue"
> instead of "git commit -c CHERRY_PICK_HEAD"?

As mentioned in the part of the commit message you trimmed away: "In
the next commit, we teach git to handle the '-c CHERRY_PICK_HEAD'
part". Now, you may ask, why use "git commit" after resolving the
conflict (a la merge) instead of "git cherry-pick --continue" (a la
rebase).

I addressed this in the previous thread, see
http://article.gmane.org/gmane.comp.version-control.git/166884

j.
