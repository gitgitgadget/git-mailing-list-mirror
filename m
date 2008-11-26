From: "Nazri Ramliy" <ayiehere@gmail.com>
Subject: Re: [PATCH (Eek!)] git diff does not honor --no-ext-diff
Date: Wed, 26 Nov 2008 18:01:27 +0800
Message-ID: <544dda350811260201t66a58c9av3f390d6f314ffa05@mail.gmail.com>
References: <544dda350811252312u7ef5533bwb20b37640d861487@mail.gmail.com>
	 <7vprkihqk6.fsf@gitster.siamese.dyndns.org>
	 <492D01D1.7020702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Nov 26 11:02:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5HEK-0006ri-UD
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 11:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYKZKB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 05:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYKZKB3
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 05:01:29 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:55410 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYKZKB2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2008 05:01:28 -0500
Received: by wf-out-1314.google.com with SMTP id 27so417174wfd.4
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 02:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3rbhDRCc7GkvbJDCEyS+pMUIygSsQy25oyzX3fnaECQ=;
        b=ZIK9JESVl69dG/dP68P19BEv393hpCCBQPpK8h3Wq/8WzxsI2Bm+KM+K0MFrZJw873
         kUQB4u/NE/zFmlEuN5NVNTtWdX/k6ZBsMCXV4T2SAhVnGMBJNO7QzmQpB1ruYzRgWmYC
         F5is6sP7jaOkuzvgAuu1R+Qe3OLE9l54sl3J0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XY1rFXPNr5UpItI17qJB98MkUdNJXGHAQCHV7RUWrMTCpj+S6tieQiiEzNbt8Tdy73
         ZUcKNdDwkECZ5h6Pi2o2F7IQVWQv5EG8kDTr/MYElzv53ekqjpDPVnXM9RrkjYcTH+W4
         q64vstv60suls/rulCR+vxWAB8pCgjEjRfKBI=
Received: by 10.142.107.1 with SMTP id f1mr2535012wfc.140.1227693687967;
        Wed, 26 Nov 2008 02:01:27 -0800 (PST)
Received: by 10.143.107.3 with HTTP; Wed, 26 Nov 2008 02:01:27 -0800 (PST)
In-Reply-To: <492D01D1.7020702@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101720>

On Wed, Nov 26, 2008 at 3:59 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Junio C Hamano schrieb:
>>
>> Wouldn't this be a better patch?
>
> Yes.  And feel free to squash in the following. :)
>

Good! So the Eek! part is not really necessary.

Now I can trigger the external diff whenever I say so via GIT_EXTERNAL_=
DIFF.

Thanks.

Nazri.
