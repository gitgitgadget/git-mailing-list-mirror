From: Ivo Anjo <ivo.anjo@ist.utl.pt>
Subject: Re: How to prevent empty git commit --amend
Date: Wed, 14 Jan 2015 12:15:16 +0000
Message-ID: <CA+iO_8nmrw7SiXWS22VcEHObQDJYDwKqRPariAmv5DzUvzAdsQ@mail.gmail.com>
References: <CA+iO_8mLsdsf1PepiB4M9jJh7pX8brqPdiwAvWGMdfYO0YKrCQ@mail.gmail.com>
	<vpqzj9lfzqg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBMr8-0002iW-QU
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbbANMPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:15:21 -0500
Received: from smtp1.ist.utl.pt ([193.136.128.21]:60263 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbbANMPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:15:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.ist.utl.pt (Postfix) with ESMTP id B75D2402FCA1
	for <git@vger.kernel.org>; Wed, 14 Jan 2015 12:15:18 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.7.1 (20120429) (Debian) at ist.utl.pt
Received: from smtp1.ist.utl.pt ([127.0.0.1])
	by localhost (smtp1.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id F_rKunSCeEYS for <git@vger.kernel.org>;
	Wed, 14 Jan 2015 12:15:18 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp1.ist.utl.pt (Postfix) with ESMTP id 87EFC402FA64
	for <git@vger.kernel.org>; Wed, 14 Jan 2015 12:15:18 +0000 (WET)
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com [209.85.216.178])
	(Authenticated sender: ist155460)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 11B5C2007727
	for <git@vger.kernel.org>; Wed, 14 Jan 2015 12:15:18 +0000 (WET)
Received: by mail-qc0-f178.google.com with SMTP id p6so6777185qcv.9
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 04:15:16 -0800 (PST)
X-Received: by 10.140.92.232 with SMTP id b95mr5641508qge.100.1421237716932;
 Wed, 14 Jan 2015 04:15:16 -0800 (PST)
Received: by 10.229.44.138 with HTTP; Wed, 14 Jan 2015 04:15:16 -0800 (PST)
In-Reply-To: <vpqzj9lfzqg.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262379>

Hello,

On Wed, Jan 14, 2015 at 10:00 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I don't know any way to let Git do the check for you, but
>
> git diff --staged --quiet || git commit --amend
>
> should do it. You can alias it like
>
> [alias]
>         amend = !git diff --staged --quiet || git commit --amend
>
> and then use "git amend".

Genius! This is exactly what I wanted, thanks!

Ivo Anjo
