From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 00/10] ref-filter: use parsing functions
Date: Wed, 25 Nov 2015 17:37:23 +0530
Message-ID: <CAOLa=ZRW8F9yB7Uw=3r9cp+Vi-6Lv9C-C475y8yi5-fih3dGcA@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com> <20151124214842.GA4848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:15:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1YyW-0000mg-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbbKYMH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:07:56 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35996 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbbKYMHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:07:53 -0500
Received: by vkay187 with SMTP id y187so32821879vka.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 04:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=arj9xnwE1OSneg2/c9it9QNEhDduBL65xr11rTIJvEg=;
        b=HjTVGuRPKqEQBEjefCT+9COsRv3sa3urvltYXtST6TPfvSWPYyi6WtvqeATq2TZVx6
         XUmzt3GCsLgy1xQRR2czR26pmmSgXtzjiBPpCZ0LzCf0iT+C2m/PRg1Gwlx6cpc+QUKR
         nsCgawRTzEv2rMJ+1YVsun1T11iLpCJ/qBen/sx7h7oCV1+IV5JYz0q7lzx6XWdcusX+
         yZNPYFf4SN31ctUnFRm/dGz+HZbbbpyP4zsNtXl2WZ5B7+bpu0nDielz+dHIcHDjFIK7
         iP4BzA3xKbQNSnF/FzdftQZsYTTm2n+M5JaDYzKaiO8DRBOKnbQymPYTYxpnNZ0xg+Ok
         H4Rw==
X-Received: by 10.31.157.144 with SMTP id g138mr21957185vke.71.1448453272885;
 Wed, 25 Nov 2015 04:07:52 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Wed, 25 Nov 2015 04:07:23 -0800 (PST)
In-Reply-To: <20151124214842.GA4848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281705>

On Wed, Nov 25, 2015 at 3:18 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 12, 2015 at 01:14:26AM +0530, Karthik Nayak wrote:
>
>> Karthik Nayak (10):
>>   ref-filter: introduce a parsing function for each atom in valid_atom
>>   ref-filter: introduce struct used_atom
>>   ref-fitler: bump match_atom() name to the top
>>   ref-filter: skip deref specifier in match_atom_name()
>>   ref-filter: introduce color_atom_parser()
>>   strbuf: introduce strbuf_split_str_without_term()
>>   ref-filter: introduce align_atom_parser()
>>   ref-filter: introduce remote_ref_atom_parser()
>>   ref-filter: introduce contents_atom_parser()
>>   ref-filter: introduce objectname_atom_parser()
>
> Hmm, your patch 10 does not seem to have made it to the list (at least I
> did not ever get it, and gmane seems to be down, so I cannot check there).
>
> -Peff

That's weird, I'll reply to this mail with patch 10.

-- 
Regards,
Karthik Nayak
