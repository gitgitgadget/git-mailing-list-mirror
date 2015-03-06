From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Fri, 6 Mar 2015 15:40:48 -0800
Message-ID: <CAGZ79kbXH+UZy2KoGyNdz9SkdRyxLRAUTeUK+-KsJzM+ZHTvCw@mail.gmail.com>
References: <20150302092136.GA30278@lanh>
	<1425685087-21633-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 00:40:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU1rR-0005Wv-PE
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 00:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbbCFXku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 18:40:50 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40252 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbCFXkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 18:40:49 -0500
Received: by iecrp18 with SMTP id rp18so21814295iec.7
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kVhAvUwVrTVSiTPaUcGdAlJ5MUaumEQNTsgzg73IBY4=;
        b=h1QEb1S6YZDfPLmdm43JxqFLDCeE0Kl5+16El89qfs2DklTCbcgVSCYY2VIhTiAka2
         xVout4UHxzH5rcq1az9syAxleTfowKNcweODbQbnPJSZyA8+ACg9ualG5iNYF29mtBla
         HddusBEioMUg0j5kRFphkFqoJeZ1KF8Sejms+Mc3VEF1O7qIi8DQDKrh9Rynm0EXaq3t
         DjNzs5Ph2g33kTDn2Oa9bfhTh/CIFeFOw+JpnEyPlYsnIg5gIKzbXrXkyizYywAwSVZX
         81WQoDUXXkmPBkWtma2e01FLyA/46h2PxmEfnUWisB1b2MQ/MmfLuV9FY8wP0zeoV9PC
         0oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kVhAvUwVrTVSiTPaUcGdAlJ5MUaumEQNTsgzg73IBY4=;
        b=X8aZ+DbpQUpfvL81b3kMnQbJ9KZKhRJH4dntA/MET1bH0Vfp+aV/LsBPWwdFXs0ck2
         1liKNDg4vswjJzOjE3krjDe/hiNX6aw/c8dDu1nT2MwbD/3QSOkaD7Ik9lhD78eSNP8m
         qAav5YunRb4V5JCnlt147pMhpEprGDqtxXVekuN0e76r2LBphUFCTeSYDFPFeZhW9cjj
         qfGDTUI7IscYJd7nbB3yZwnEJthK0klWTUqPjm84Um5ef5X24TAWA6gP44SGcBv7nyDm
         9w62ATPtHTvFeyi8gaZBjJWDut2YcS6+hPGKPow+dbrtbU6Fc+deaxv019IQ/sCXe+qa
         GJiQ==
X-Gm-Message-State: ALoCoQmG9M8tRTstxArmt0qMpsVhlPFUUpJPjnUDKcDNzgBZvf0yHlHHbP+renxmDrqP6o6AZbLL
X-Received: by 10.42.92.16 with SMTP id r16mr13180445icm.95.1425685248556;
 Fri, 06 Mar 2015 15:40:48 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Fri, 6 Mar 2015 15:40:48 -0800 (PST)
In-Reply-To: <1425685087-21633-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264973>

On Fri, Mar 6, 2015 at 3:38 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Duy Nguyen <pclouds@gmail.com>

Oops. I edited the proposal from Duy heavily(?), such that it is
different from what he proposed 4 days ago.

In my impression this is what most of the participants would agree on.
