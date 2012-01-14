From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] git-gui: fix applying line/ranges when the selection
 ends at the begin of a line
Date: Sat, 14 Jan 2012 12:23:34 +0100
Message-ID: <CAKPyHN0Mj-cus5WWDpHG_mtWJhe6_4hxEzSn6pk0a88hytgVVg@mail.gmail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
	<37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
	<CAKPyHN0tqQKuPONj_F9MXbgoHxeoZ7pFVSLPNWHddnA8340MGA@mail.gmail.com>
	<7vaa5qydj7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 12:24:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm1iK-0000gH-Nl
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 12:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab2ANLXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 06:23:37 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47395 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab2ANLXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 06:23:36 -0500
Received: by wibhm14 with SMTP id hm14so968653wib.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xyCeJadgks+LBU942O+Ufl1Dr0m5VyZ/9Bgoh4Wr0M0=;
        b=UGnCVoJbYED+IE1gsqnK25Jvr4eQWFc4DIgajeNabT67HW6IW28K/Lf2UaRv/uFW6W
         CpqWDPqlqvLTc7WEt6FaSOmztDwuCjOXegvi0XkK1reFuv15OR8dpz86VwzNzp2RbaUW
         t3wXt5vWkMRUgFaFDtwuKFiTl06Le4akgh3bw=
Received: by 10.180.75.7 with SMTP id y7mr7965531wiv.2.1326540214913; Sat, 14
 Jan 2012 03:23:34 -0800 (PST)
Received: by 10.223.118.10 with HTTP; Sat, 14 Jan 2012 03:23:34 -0800 (PST)
In-Reply-To: <7vaa5qydj7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188559>

On Sat, Jan 14, 2012 at 08:00, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> On Mon, Jan 9, 2012 at 14:43, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>>> Selecting also the trailing newline of a line for staging/unstaging would
>>> have resulted in also staging/unstaging of the next line.
>>
>> same here, could you please consider pushing this into the 1.7.9
>> release. I see no point in waiting for the next release.
>
> I do not use git-gui myself, so I wasn't paying much attention to these
> two patches.
>
> If these two fixes are for a new feature that was not present in v1.7.8
> but has already been merged before v1.7.8-rc1, then do please make sure to
> push them forward.
>
> On the other hand, if they are fixes for an old feature that was already
> in v1.7.8, then it is a bit too late for the next release.
>

Thanks, considering this, than these two patches have to wait for the
next release.

Bert

> Thanks.
