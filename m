From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: Avoiding broken Gitweb links and deleted objects
Date: Wed, 22 May 2013 09:25:25 -0400
Message-ID: <CAJELnLEOg+D+baAddJvDiYM=ej8PKsgi2MWH25enOijXa+bO_Q@mail.gmail.com>
References: <CAJELnLFrfY=-gOFEe0cJHuyT4UNjbTm8hXMxAmzmQHVbz4iEbg@mail.gmail.com>
	<518C8EAC.6000106@viscovery.net>
	<7vzjw349y0.fsf@alter.siamese.dyndns.org>
	<CACsJy8CopioiTrEDfuZK=n1DfJ8_chxV9dEObqpVfHHmJvzyqQ@mail.gmail.com>
	<7vvc6r4855.fsf@alter.siamese.dyndns.org>
	<7vfvxu3ivc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 22 15:25:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf92s-0006Zp-EO
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 15:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab3EVNZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 09:25:27 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49594 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869Ab3EVNZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 09:25:26 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so1683925pdj.41
        for <git@vger.kernel.org>; Wed, 22 May 2013 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/4xvU3DUJOQZlGclF5DpMw5PAtg+hgW9CWEum24BX24=;
        b=Q3Q4bpCwpAVRMMivlgQf4GmGpI//oXSBADfmldqJ5CPTG/rNNGjwIkA8vEXjtx/XqQ
         /5cBwUxXeYemeJ7iYFD1uNjvXFLnmUoVsFT7s1wy0pU8DyMegdLM56PNNzQaWY46t787
         7qTQK06MlN4kaMDMsyqkjKCqImNdbZHj+jLBUU32l3P/8SdGGhVIy3mSB9CLtsOuO8SE
         mqa2grFT51oD4eeVtglSKTkSeUJOIUqSoYvSnQUJfHMHlLgdvid6CykSjLtWoguFecHA
         as1H99EgICV5STAc9rdZiSzENiInnr6iXPlj6NAYwz2Sx4fKiJ2JBK1969uBr8qRlNYS
         YjTg==
X-Received: by 10.68.130.167 with SMTP id of7mr7940387pbb.169.1369229125921;
 Wed, 22 May 2013 06:25:25 -0700 (PDT)
Received: by 10.68.15.98 with HTTP; Wed, 22 May 2013 06:25:25 -0700 (PDT)
In-Reply-To: <7vfvxu3ivc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225155>

On Fri, May 10, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think what I missed is that the same logic to ignore side branches
> whose history gets cauterised with such an "ours" merge may apply to
> an "ours" merge that people already make, but the latter may want to
> take both histories into account.
>
> So I guess it is not such a great idea.

The particular proposed implementation? Or the broader idea to save
loose commits more permanently? I'm still interested in a solution for
the latter.

-- 
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
