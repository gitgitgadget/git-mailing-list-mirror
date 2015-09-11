From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Fri, 11 Sep 2015 13:30:07 -0400
Message-ID: <CAPig+cTmnOz899k_xySb1Q-SeFctOrs6fnJJN=qc731nXmXwkw@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3m6nrf9.fsf@scolette.imag.fr>
	<CAOLa=ZQppSg0-kc5nCfRYfHMoD5ehTTOigKz48G01vn1Mn=FTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 19:30:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaS9Q-0002Aa-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 19:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbbIKRaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 13:30:10 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35815 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbbIKRaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 13:30:08 -0400
Received: by ykdu9 with SMTP id u9so98947560ykd.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XuaL1ET/oKMtx0h0EmP+XwjOpdP0GraIaqZ1+9zNkQM=;
        b=fyvqKjuzgeU1vuzWtgafA3BdgUgNt+LNge4qiQ/17QvJOhxjOOgWODZCRxWxU0h8SU
         /a2dM5vivp7WFadpcdy5tzkkbJEe1dozTMvKEkrahXfEcWRx24XYRu5Xa399SAEV38GN
         97lPfuykWwji5KYVm/VRdpOOBaxJns0TUz/4t1g/yMcAMlhVDxMuGEr/3XRncVtGDcZ3
         /z1dNpkeDd3MRB1X8+zwQZwS9vOPSFeIZfueF8zPOZoEpzWDDjvgJvPaiGxkj74+utf1
         m34D6+B7Tgn5CtNoo8t663ZujjQPd55Swgqu8hwUXvdfJGCXc5/UUhV6qp69ERQuwQdI
         Q1NQ==
X-Received: by 10.129.155.147 with SMTP id s141mr56811236ywg.17.1441992607574;
 Fri, 11 Sep 2015 10:30:07 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Fri, 11 Sep 2015 10:30:07 -0700 (PDT)
In-Reply-To: <CAOLa=ZQppSg0-kc5nCfRYfHMoD5ehTTOigKz48G01vn1Mn=FTw@mail.gmail.com>
X-Google-Sender-Auth: OfwPm9a9P_23Han16B6l98zG3BU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277684>

On Fri, Sep 11, 2015 at 11:08 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Thu, Sep 10, 2015 at 10:27 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>> Changes in this version:
>>> * The arguments of the %(align) atom are interchangeable.
>>> * Small grammatical changes.
>>> * Small changes in the tests to reflect changes in the align
>>> atom code.
>>
>> Clearly, we're almost there. I did a few minor remarks. I suggest
>> (admitedly, Eric suggested of-list to suggest ;-) ) that you reply to
>> them by re-sending only individual patches that changed (replying to the
>> original patch) so that we can check the new patches individually. I
>> think we can do the finishing touches for each patch in a subthread of
>> this patch.
>
> I replied with suggested changes by you and Junio.
> Let me know if any other changes to be made :)

Hmm, but what actually changed in the re-sent patches? Without a link
to the discussion leading up to the re-send of changed-only patches,
and without an interdiff, the re-send is opaque and less accessible to
the reviewer; which is at odds with Matthieu's suggestion which was
intended to make review easier and more streamlined.

In addition to a link to the previous round and an interdiff, it would
be helpful to reviewers for you to annotate each patch (in the
commentary are below the "---" line after your sign-off) with a
description of the changes in that patch since the previous round in
order to focus the reviewer's attention (where it needs to be) on the
latest changes.
