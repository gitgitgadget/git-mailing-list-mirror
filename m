From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: recipe to use git for deployment
Date: Sat, 5 May 2012 10:25:55 +0200
Message-ID: <CACBZZX50LAu+XNWzHJjQB1kgK3W418FVW--DdsYchDvg8bEztw@mail.gmail.com>
References: <jo283q$kna$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 10:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQaJt-0004Mv-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 10:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab2EEI0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 04:26:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59337 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab2EEI0R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 04:26:17 -0400
Received: by eaaq12 with SMTP id q12so1006319eaa.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k0UNHFIJ2pAVEqpQOjee7LRhhGGl3kBjkGLeRE8jdxQ=;
        b=NMGRl1rCRvekTxEEPGieT7zw7Aujk2jvXDg17u6wKqzyo5clCQQpBjSsnVxeXBbLRL
         XFKESzizoQhIietDSMlJ7CfcexHMgpfzBurFeMohURlN627waSKfzsmkB1ZvyCl/PV1E
         fZjL876rvD3ybcgBl3CIaJsbO/1WlSWIh/9WBxIBd4fZfgA9VgKRm9Rq2WOC2lLuZkJ1
         YLsv0f6Zi8uXaeFzV+reTTjZFClsDkss+kc/VEagJUh4lGf/guK3tGaWphUDmJTnXztf
         1r03/n0K58Wuw6sCjjH7PlHu3v8Lk0mKJBjs9x8NONCMpUEVO1myIaYyffNxDSNwFliM
         IMuQ==
Received: by 10.14.94.131 with SMTP id n3mr1602451eef.76.1336206376093; Sat,
 05 May 2012 01:26:16 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Sat, 5 May 2012 01:25:55 -0700 (PDT)
In-Reply-To: <jo283q$kna$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197099>

On Sat, May 5, 2012 at 5:51 AM, Neal Kreitzinger <nkreitzinger@gmail.co=
m> wrote:
> I'm trying to cook up automated mass deployment using git as the main
> ingredient. =C2=A0Here's a recipe idea:

At work we use and have open sourced
https://github.com/git-deploy/git-deploy which we use for our
deployments.

It doesn't actually do the work of syncing out anything, we
effectively do that with distributed rsync.
