From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git repository size / compression
Date: Fri, 9 Sep 2011 16:25:41 +0200
Message-ID: <CAGdFq_iZSRuvNP6Z+Gao+TSVwDaEAREjCKYgiPVAXeSWbzq2EA@mail.gmail.com>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
 <1315556595.2019.11.camel@bee.lab.cmartin.tk> <CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: neubyr <neubyr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:26:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R222E-0004zN-RY
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100Ab1IIO0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 10:26:22 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60227 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab1IIO0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 10:26:21 -0400
Received: by pzk37 with SMTP id 37so2699540pzk.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lZpFJs7b7JLG1P1KWv8hJkZ0jXuJzvxoN7DNbZ+yMPk=;
        b=cgMcZAxFQwfa4YZz5DVeNrvU0D+RvqmrDN9ECP8r4KjB2CoTWL2ziWJQs5yYZ9ItVb
         KtUWazxGRbMbY5qmsbXDb06MAl3U8X8/5DM0TCnXY3LLWIghFo+fQUKtlVauium4VH/8
         Q8rtQlgPjYkOn0hfQjGO3HUwGOVRneifN78CU=
Received: by 10.68.23.97 with SMTP id l1mr2994284pbf.232.1315578381060; Fri,
 09 Sep 2011 07:26:21 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Fri, 9 Sep 2011 07:25:41 -0700 (PDT)
In-Reply-To: <CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181071>

Heya,

On Fri, Sep 9, 2011 at 16:04, neubyr <neubyr@gmail.com> wrote:
> Does git store deltas for some files? I thought it uses snapshots
> (exact copy of staged files) only.

In packs, yes, it will try to delta objects as efficient as possible.

-- 
Cheers,

Sverre Rabbelier
