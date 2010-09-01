From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH v3] builtin/merge_recursive.c: Add an usage string and
 make use of it.
Date: Tue, 31 Aug 2010 23:20:08 -0300
Message-ID: <AANLkTimRB5-kCfp9TRnRxQnNV6dapUXmSbRDCPBW93LC@mail.gmail.com>
References: <20100830024259.GC4010@burratino>
	<b58adc6cdfd6a5753fac1dde3371b3745b1f58b1.1283138840.git.tfransosi@gmail.com>
	<7vk4n8hc05.fsf@alter.siamese.dyndns.org>
	<20100831234226.GF6747@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 04:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqcwE-0002jD-A0
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 04:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab0IACUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 22:20:10 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37805 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0IACUJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 22:20:09 -0400
Received: by qyk36 with SMTP id 36so138648qyk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hC31hB1SA0UExZ56EBfP8HPVhE0XXNvgSkXAFMrmcA0=;
        b=oHTm8dwiuSOJnlln9gPWcF4ANAn9y45vb7BsjJVfIQMt3LJDNJlmsLZ8YMALYaBgs0
         qPSiJ1zoMiyURhf/17lPtlcz/AfAPs0NDhUCqKO3dLSQI7/hyPvD7yIqXUFK9zQA2s5H
         lBbgeeQBb/3odn/GdGVbp8KOYQ1uYn3Puhxkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OiCqT7wsh1qOuI98ZqIQXu8QuekN36JPy5kmcQzrEYkfWomW2PuP1H5DwogiK9Szru
         VczGcMMBVdx3s4ZxIMe4iJt6L8akz20zHoplnyEZcuIVSCksTkgeVTMcZBqFLzTEwpCs
         4U997xwY7b8O8J9043gA8fEXziYZNkoWyP3Zw=
Received: by 10.224.46.5 with SMTP id h5mr4588743qaf.201.1283307608137; Tue,
 31 Aug 2010 19:20:08 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Tue, 31 Aug 2010 19:20:08 -0700 (PDT)
In-Reply-To: <20100831234226.GF6747@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155002>

On Tue, Aug 31, 2010 at 8:42 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:
>
>> Hmm, why isn't this a single liner
>>
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usagef("%s <base>... -- =
<head> <remote> ...", argv[0]);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usagef("git %s <base>...=
 -- <head> <remote> ...", argv[0]);
>
> I can't speak for Thiago, but I assume it's for unity of style with
> more complicated commands like "git fetch" that include a usage
> message at the top of the file as:
>
> =C2=A0- a quick introduction for people who don't like to scroll
>
> =C2=A0- a variable that can be used from other functions when command=
-line
> =C2=A0 mistakes are noticed late.
>
Precise explanation :-)

Thanks Jonathan.
