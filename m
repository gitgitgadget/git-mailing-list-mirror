From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add 'prune' option
Date: Thu, 23 Feb 2012 01:06:41 +0200
Message-ID: <CAMP44s0DnVfd_Ged5rnhM4BF1jEtm4jzyq9sJAoEtQ-0CM5_aA@mail.gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
	<1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
	<7vobsxqebz.fsf@alter.siamese.dyndns.org>
	<CAMP44s3+XCM1E_AtW1yGifmGoGSkFSpSTaFbbMffz+hmUzWahw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 00:06:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0LGr-0004mb-35
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 00:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab2BVXGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 18:06:43 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48448 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751472Ab2BVXGm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 18:06:42 -0500
Received: by lagu2 with SMTP id u2so682675lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 15:06:41 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.25.8 as permitted sender) client-ip=10.112.25.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.25.8 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.112.25.8])
        by 10.112.25.8 with SMTP id y8mr12588283lbf.15.1329952001508 (num_hops = 1);
        Wed, 22 Feb 2012 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0NP2yfY+oJ5pWg4c+HWBrQedGMQpqe2O7epjP8+jASo=;
        b=i9tfhfFTxACjKA/F76F+J79W1uMYnG3Z20s4OFvzbqz/aj+zM52r5Z7VghkIIHMv36
         7yVF+AmiB6HnBTWUZhpxLwc58cEJ5pfW0/zW34U+/6qyL0kaQtwPtmMBEwLSR8BFut8q
         mhWqkWu4zSZz9QxeKtnkvdOf9r7fL6lbARHsg=
Received: by 10.112.25.8 with SMTP id y8mr10577778lbf.15.1329952001422; Wed,
 22 Feb 2012 15:06:41 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Wed, 22 Feb 2012 15:06:41 -0800 (PST)
In-Reply-To: <CAMP44s3+XCM1E_AtW1yGifmGoGSkFSpSTaFbbMffz+hmUzWahw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191309>

On Wed, Feb 22, 2012 at 10:43 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Feb 18, 2012 at 12:34 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Does it make sense to specify --prune when --mirror is in effect? =C2=
=A0If so,
>> how would it behave differently from a vanilla --mirror? =C2=A0If no=
t, should
>> it be detected as an error?
>
> Probably doesn't make sense, should be an error.

Actually, after writing the patch for the documentation I realized
this would be difficult to describe: you can use --all --prune, but
not --mirror --prune, and the documentation currently has '[--all |
--mirror | --tags]'. So I decided to make it orthogonal, you can use
--prune with --all, --tags, *and* --mirror. Of course, using --prune
--mirror is the same as --mirror.

Cheers.

--=20
=46elipe Contreras
