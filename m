From: Miles Bader <miles@gnu.org>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 06:27:55 +0000
Message-ID: <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 07:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PorvY-0004BW-PY
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 07:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab1BNG2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 01:28:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45284 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1BNG2i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 01:28:38 -0500
Received: by bwz15 with SMTP id 15so5168825bwz.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 22:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2jIOaa92X3GFzjRiw+iy9F6FaK+LuBZ1MB2R26iWczg=;
        b=xkZ0VmhJsV7BNeBkYquiBr8L/YC6g4tAphWwBmGndbbS1HMnPB+dL6G+VNPt80D7rt
         tQur9g0EysBkCRZeRlCebB0+OcUVDAApkVmBvB3fIDlQq78rBc2L0BfivVkSzBBu8OrY
         5ODJXh70KG68rGcopVe2vC1LZE8cPP2yvIApg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=o6ROTFo52Homyd0GEyzMSi+fg7ShTkXTVF5JQePbkjWR57CZE//anK1hNgaCqNqkpn
         z75ccq4jzJ74oO7baYbAeVGejPXtbOnYC6V5Nc69hehNPPWfKhFdF2m6uRMX3mFM9ZZd
         ui21HuIvEolMZoX1HCUB7LnaksRI479bj5xXA=
Received: by 10.204.79.135 with SMTP id p7mr6368067bkk.109.1297664916731; Sun,
 13 Feb 2011 22:28:36 -0800 (PST)
Received: by 10.204.119.130 with HTTP; Sun, 13 Feb 2011 22:27:55 -0800 (PST)
In-Reply-To: <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 8wTfyqjmewOrduQ9bQ5moHCcq3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166691>

On Mon, Feb 14, 2011 at 5:57 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Is there a reason a short version of --cached couldn't be added to
>> git-diff...? =A0E.g. "git diff -c"?
>
> I'd suspect that we would like to keep the door open for "diff -c" to=
 do
> what the users naturally expect, namely, to produce a patch in the co=
pied
> context format.

hmm

"git diff -s"  ? ... since --staged is an alias for --cached :)

-miles

--=20
Cat is power. =A0Cat is peace.
