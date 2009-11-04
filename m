From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Accessing the reflog remotely
Date: Wed, 4 Nov 2009 18:55:57 +0100
Message-ID: <fabb9a1e0911040955n6202fdbbpfbcf34cc33c45e73@mail.gmail.com>
References: <vpqljimpr95.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 04 18:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5k5r-0001gt-Ka
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 18:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbZKDR4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 12:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbZKDR4N
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 12:56:13 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:34450 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbZKDR4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 12:56:13 -0500
Received: by ewy3 with SMTP id 3so3363170ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FkewvNBQDNo7ohjkT/SUsgYbea85znSfIUj4O8KDRn8=;
        b=uatzdKkJRwutuRCinYld9mA1I9AodcGWrD6PvCd5oYIlaJjW+AdK0CZOsG1ts3m4zh
         5dfYRRRlxQSNWzOWueiZZsBWEYjM3ZLUB1XuW8zLo+J9uZ8vEDiarPH41svXkMWIrwAb
         f2+g02O/ZukpS8U5KWiq60c5IfkYZzH1cctoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kodix1pweH1xZaij+leAJnXG1QOjduLAktPlvS9LbslX7/AsixEBNxwXMK5G8fOdRJ
         os4rGeN9QNqAABBu16YXre9fqwniJhmS5cT+yx22m0nKv6829jlVUlnBETshEKpnSAQ1
         LNDTDXziTxkG1PGfXQUyUZ03+SwKqORD9Sr38=
Received: by 10.216.91.82 with SMTP id g60mr535326wef.98.1257357377364; Wed, 
	04 Nov 2009 09:56:17 -0800 (PST)
In-Reply-To: <vpqljimpr95.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132100>

Heya,

On Wed, Nov 4, 2009 at 10:35, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> My use-case is the following: I want to checkout "the last revision
> pushed in master on ssh://host/repo/ on day D at midnight" (to fetch
> the project of my students ;-) ). If it were locally, I'd do

I think your best bet here would be to either run a cronjob at the
target time that tags all submissions, or to deny pushes after the
target time with a pre-push hook.

-- 
Cheers,

Sverre Rabbelier
