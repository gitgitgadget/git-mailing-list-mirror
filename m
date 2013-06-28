From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] completion: add completer for status
Date: Fri, 28 Jun 2013 19:33:21 +0530
Message-ID: <CALkWK0=RZbZxSzCFNAPqzcpnnC_Tak+isESmFiEyLMgcu3vV1Q@mail.gmail.com>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
 <20130628102936.GA16562@goldbirke> <20130628105601.GB16562@goldbirke>
 <20130628112631.GC16562@goldbirke> <CALkWK0=pyzcx-rB9gjRecoD1MFkHrSdYwLurD8y805O3FwT4Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZHa-0003A5-9N
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab3F1OEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 10:04:09 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50576 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab3F1OEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:04:08 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so4200299iea.11
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KXu0DfvxnjTTW4OhUYKegDLxoimcnV5hP+TN+O/Hgik=;
        b=AYFqfiZ837CU+RdCLAu5bm8XTZcAcyBZWEWMAT4qQVu1iwjQXUVgfJ/dHR/035GVA/
         2OoM6MbvSu84xU27PXLjGM9qSfTgQbdDN2mNNMnN1+mVdqjNktNbuOl8BybtASCOh9aV
         HWpCq4+6L30rfkviibtOvaO36FFeBkRk3neWs2sCs4YEwMmvOQB+8o17iKM+Bjx+Mu2P
         8/Hz4qabFGzJXq6/t14AQ22nAlwGsLyenimVDvMsWdhImLPuIGdfeC/k9q53jFKFfLO4
         IZuCkbnWxVZ9DOdlLYBtleoFPOmivLey05yiw4DjYubtvjewFU/1EE4T2RrBdiVzymxS
         xzyQ==
X-Received: by 10.50.87.71 with SMTP id v7mr4018012igz.29.1372428242046; Fri,
 28 Jun 2013 07:04:02 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 28 Jun 2013 07:03:21 -0700 (PDT)
In-Reply-To: <CALkWK0=pyzcx-rB9gjRecoD1MFkHrSdYwLurD8y805O3FwT4Cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229199>

Ramkumar Ramachandra wrote:
>> +       __git_complete_index_file "--with-tree=HEAD --cached --deleted"
>
> Might as well go all the way with  "--cached --deleted --unmerged
> --others" no?  What is the point of --with-tree=HEAD?

Ugh, --deleted doesn't work as advertised (terrible documentation).
The minimally correct combination we need seems to be
"--with-tree=HEAD --cached --others".
