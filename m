From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Survey] Signed push
Date: Wed, 14 Sep 2011 16:05:12 -0500
Message-ID: <20110914210512.GA20294@elie>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dwu2U-7eEZU-VYmcrA7JwtvUkJS5SywXjZWoE1twchhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 23:05:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3weD-0001S3-0O
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333Ab1INVF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 17:05:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41284 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933201Ab1INVF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 17:05:27 -0400
Received: by iaqq3 with SMTP id q3so447771iaq.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jc08Uyghtpn+NGDZRwQOKQRAxdRcsscKnKxQD1Om2Ko=;
        b=b/GvNbHuC+NGMVk2E02qMJBhSQ8W0YlL04FpApkLLCVzYhi+jaXxxbiNbuob2MGE2/
         o9PbTtaHWelUebCIUBD/+UHC6L/NaLF7nPEjks/z5D9OofMBzgb8Bo/VtJxD8RzgeCJS
         8mMsBaWD6XeyWfdfpe79roFG0hf+dP9DAw4/g=
Received: by 10.231.8.100 with SMTP id g36mr451802ibg.55.1316034326400;
        Wed, 14 Sep 2011 14:05:26 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id r2sm1597662ibq.7.2011.09.14.14.05.24
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 14:05:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Dwu2U-7eEZU-VYmcrA7JwtvUkJS5SywXjZWoE1twchhQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181401>

Nguyen Thai Ngoc Duy wrote:
> On Wed, Sep 14, 2011 at 2:45 AM, Junio C Hamano <gitster@pobox.com> w=
rote:

>> An alternative that I am considering is to let the requester say thi=
s
>> instead:
>>
>> =C2=A0 =C2=A0are available in the git repository at:
>> =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/flobar.git/ 5738c9c21e5=
3356ab5020912116e7f82fd2d428f
[...]
> Stupid question, if we agree to go with signed push, can we also sign
> pull requests and verify them when we pull? I suppose most of the
> time, pulling can be done automatically by extracting pull url from
> the request. This would make pull/push both signed.
>
> BTW, there's a third way (rsync is obsolete) to carry changes away in
> human-unreadable way: bundles. Should we also sign the bundles too (I
> guess we could just do the same as in signed push).

If I understand you correctly, then ordinary PGP email signing[1]
should work for that already.  In your first example, the receiver can
make sure whatever process grabs a pull request verifies it, and in
the second example, the receiver checks the signature on her email
before saving a bundle and passing it to "git fetch".

[1] http://www.phildev.net/pgp/gpgmua.html
