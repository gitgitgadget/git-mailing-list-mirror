From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] Added --exit-code option to git-status
Date: Sat, 5 Mar 2011 17:32:18 +0100
Message-ID: <AANLkTimeE0yscLFTkJ-824wi55eQQme8X+qobx80NVby@mail.gmail.com>
References: <4D7254CB.5040704@gmail.com>
	<7v4o7h5z1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 17:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvuP3-0000qv-6T
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 17:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab1CEQcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 11:32:20 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44178 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1CEQcT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 11:32:19 -0500
Received: by vws12 with SMTP id 12so2775311vws.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zzQker14DWzY9zDL40Z70qjhkcuEI69Nhcg85CjdnT0=;
        b=dGYQYFWZSnwVvnuLcv/qmkESWivDpOT1pzQve0Y4URYdzeoHWVEpzafPmmiswLcHOt
         aAzQBCuFWlY119PpFZPl3wCgfDt1hBJB2O/ONFnMcBOIhqYeyjpDmy7UFOoee2HGgsWD
         9y3JYeyR4PSCZFSYOIPnq4pUiHNozt+tQA2so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TzJrUjgViWxqT1HjLo4zKczD893x1HYgmVLP9jZtUuUYpg4sb8qtC0cpV83smKVXdU
         k2vv5zRTLQc4HMdAZ1uaAM9jJo86KLEs6x+bBKFQV3cH0DuuNhIp6ILdck7eFp4r3ohz
         umFiyOG2hpUw1ZepQdVPkbKxSwGi2F8upwJ/w=
Received: by 10.52.98.97 with SMTP id eh1mr377551vdb.148.1299342738725; Sat,
 05 Mar 2011 08:32:18 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Sat, 5 Mar 2011 08:32:18 -0800 (PST)
In-Reply-To: <7v4o7h5z1i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168502>

On Sat, Mar 5, 2011 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> When this option is specified git-status returns non-zero
>> exit code when there are untracked, modifed or staged files.
>> ...
>> Comments?
>
> Knowing the history of "commit --dry-run" vs "status", my gut reaction was
> that adding anything to "status" is going totally backwards.

What's the history?


-- 
Piotrek
