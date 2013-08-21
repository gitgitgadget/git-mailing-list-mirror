From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 23/24] introduce GIT_INDEX_VERSION environment variable
Date: Wed, 21 Aug 2013 07:57:51 +0700
Message-ID: <CACsJy8A_gJXUm2WVPCXDZbWFCusvyoEUJaGJT_ROC9uzxc_A6w@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-24-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 02:58:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBwkk-00010d-34
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 02:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab3HUA6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 20:58:22 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:49593 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3HUA6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 20:58:21 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so1910746obc.24
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 17:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FRdvNks93osL9SvFTLEI/guMvimANP1ZTsFcjFLgw/I=;
        b=dr969mxxIX5iQw6rKu167Uvqndy1B6tJfCwMDiT/oYcSOM4amV6VfxgRz/vFVXTAdR
         j7UTzqrRj01oG605MTAP1FhwzLa/+ZqfW6UM9NXTxbG/nGvbv8TogBO/D2qVoI+N6F73
         K6EY8iDan7gYFzmoGXuccNLDllnSp1fU9WmjL8zokTgkDEKZpJ5PWUFpATnctb2NerWU
         EMkWQcKPrCJhnrAkXp1jC3Y4U4KMeqcHrA6kmwMy+vK4G6mSJ3jMJMjoMohGaMZ3rJru
         aVjHCu5dBbzKh/CypNekP/lIywTTByirXHbNda0HY1Y5dvJerYdCXrPwQXGOt8ugoWRw
         wtpg==
X-Received: by 10.60.52.244 with SMTP id w20mr4944168oeo.30.1377046701178;
 Tue, 20 Aug 2013 17:58:21 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 20 Aug 2013 17:57:51 -0700 (PDT)
In-Reply-To: <1376854933-31241-24-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232675>

On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Respect a GIT_INDEX_VERSION environment variable, when a new index is
> initialized.  Setting the environment variable will not cause existing
> index files to be converted to another format for additional safety.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

There should be a line or two about this variable in git.txt, section
"Environment variables". We could even have core.defaultIndexVersion
for people who don't want to set environment variables (and set this
key in ~/.gitconfig instead) but this is not important now.
-- 
Duy
