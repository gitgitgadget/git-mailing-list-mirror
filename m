From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/37] t6020: Modernize style a bit
Date: Tue, 21 Sep 2010 22:41:17 -0600
Message-ID: <AANLkTintJNQKq9Tg0D9g0_Qz9u62mWWR+Pz5OS2f_p2+@mail.gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
	<1284971350-30590-10-git-send-email-newren@gmail.com>
	<4C972839.9050303@viscovery.net>
	<AANLkTin3wXKUJoRtdk4e1KT5Gwo1H1+9H07LU313Ubo1@mail.gmail.com>
	<7v7hietuvf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 06:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyH94-0003KM-Nl
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 06:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811Ab0IVElU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 00:41:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0IVElT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 00:41:19 -0400
Received: by fxm3 with SMTP id 3so88403fxm.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Aztz10Jd7feqT7HiFoPQ5FiRff9ZhUZTECQ0K4WcQFQ=;
        b=ZRQVCUS1IzxteugWhqYT8DJO0Ch4zaEqWH0mOyaZFmz2ZBdfj/49FIfnZ+zm06Jm7n
         ea5JLk38bdqiKuOg5VAGs5jQgMvMdHPqI1+BOBVIyRFJcvx/5ri75tO+Rf9RdPZr/8uF
         n1DHt47A42YdlqSaFL56SNyhopJRNQAo9T9IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cSm7GZ8AZOrWaqoE0ELT7rrwcZHKg3rCwsXvgK46g6dMqSTSSVnoFBYWOIB9e+9+mD
         pZVz308+ZUmfIAFmX+2l2+7W1pXLMuxvP/8uTsQckN8zUEga5vJQhyIZPneAAS+3Ap1e
         zv4EJz8yAPH/LMZlQO1eZqfGvZ1tjjJ9h/438=
Received: by 10.223.125.148 with SMTP id y20mr3741305far.94.1285130477420;
 Tue, 21 Sep 2010 21:41:17 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Tue, 21 Sep 2010 21:41:17 -0700 (PDT)
In-Reply-To: <7v7hietuvf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156781>

On Tue, Sep 21, 2010 at 7:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>
>>> The old version requested a particular kind of failure. Are you say=
ing
>>> that with modern 'git merge' all non-zero exit codes mean the same =
kind of
>>> failure?
>>
>> No, I'm saying that I don't think the test meant to try to distingui=
sh
>> between exit codes.
>
> The check for status 1 comes from 72d1216 (New test case: merge with
> directory/file conflicts, 2005-12-03), and if you read git-merge.sh f=
rom
> that era, you would notice that at least we do not want to see status=
 2
> (merge wrapper failed in a bad way) from this test. =C2=A0git-merge w=
as
> designed to exit with status 1 when (and only when) the merge request=
 was
> reasonable, it did its best effort and left conflict to be resolved i=
n the
> working tree.

Indeed; looks like I didn't check closely enough.
