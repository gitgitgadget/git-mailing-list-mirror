From: Dickson Wong <dicksonwong@gmail.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 11 Feb 2016 11:24:07 -0800
Message-ID: <CAB8-syo8dCjDfCH3gAFvC1cnuB-wm9hxtmVb1OhZ7NT0Pw+EbQ@mail.gmail.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
	<56BB4BDF.3010407@drmicha.warpmail.net>
	<xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
	<56BCAC69.8030909@drmicha.warpmail.net>
	<xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 20:24:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTwqb-0002WT-V0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 20:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbcBKTYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 14:24:09 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36486 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcBKTYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 14:24:08 -0500
Received: by mail-ob0-f173.google.com with SMTP id ba1so88367665obb.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 11:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=yB18AFCsbVQOd469fYTzxeh2xyv6EbdlXtlHiLPV+tU=;
        b=Y/5kT68q1B1v6khwzyksBRbDeTj/PnwGqQPMdwJI0Sd3+VHliQGYHJlhlkx5n9dxES
         mQ1glIczcXmiRkdzpN6+pZ7wC/deMrI4+mczfAkn2/tzCkcV8lwVoTcqQMOae+GDE5ap
         Ph9G/FU2rxGwsRxUtNFAIi6G3eHZO56JjlP2OhdDbPI8wNvxfXjwRhSBaFJMROP1dkiO
         IoAYpAx8TCpHh99TI4gGhx1Tjiw5k3+jiTTUpmReIhXt17YiYolUiCFhTcmmp+7JASn0
         wvCOQ3UhCK4zFI2ooxn2VDawlJIzEkRvg7KNuE3U4ywAMv8KIh1gcSTew1KEPRG/PPqN
         ludA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=yB18AFCsbVQOd469fYTzxeh2xyv6EbdlXtlHiLPV+tU=;
        b=JfvGszp1Mug+h/JJEloVoicdIWErEku0BvzyJ7M/xr9LQHU4i0rvbOMoMGTyLgRzPg
         kbXQ9wWSsKVcBwfdW+ePBjsOF5LlJ5xF4PCx/V882ta7WMuHLGBk/ZzDP7Xbu3gu6oEp
         6kR5rv8UKX5hLA2QlC4JNW89osxYsUbB6NrkAyeQwjJs3mRKucShYtbClzYg7epjf3Pi
         Ncl01BGt8gSAPlMv6F+6qeUGkLqtYqZdHSoICYAneRLY92XgElWqb5s5Q/jY7DcyH5zq
         7kGueCTiv4Y6YP9Grr/tzs1EFGn4TbT0V3M3qaJfG8e1scE1FkfOFz3lCC8VStfnx+Ea
         Bokg==
X-Gm-Message-State: AG10YORIDQ0ZmswgSa3JPjXoqykildM3N/HsKjD4jzHvsa4ys4siQ1G+MauKIG4VC/hjjx1BGChbp2lxMksUMg==
X-Received: by 10.182.117.225 with SMTP id kh1mr51058035obb.29.1455218647636;
 Thu, 11 Feb 2016 11:24:07 -0800 (PST)
Received: by 10.157.34.134 with HTTP; Thu, 11 Feb 2016 11:24:07 -0800 (PST)
In-Reply-To: <xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285990>

Thanks for looking into the patch.

> Thanks. I, being a non-user of vim, was wondering if people who had
> their own user-defined commands (macros? and possibly short-cut keys
> to invoke them) built around the old (and odd) numbering need to
> adjust--in which case we may need to forewarn.
>

Vim buffers are not reorderable and windows are always numbered from
top-left to bottom-right. However, I can see someone who is familiar with
the old behavior issue a "CTRL-W_K" command to move the merged window from
the bottom to the top, making the merged window the first window and
consistent with buffer indexes. If they use this command after the patch,
the indexes would no longer be consistent. The command would most likely be
issued manually and not through a vim startup script.
