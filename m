From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Wed, 28 Jan 2015 17:53:43 +0700
Message-ID: <CACsJy8C1zBawTbeNcr+JtzTwHupb8jpivL-8Tvr=zjAAUhMLLw@mail.gmail.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
 <CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
 <xmqqegqlnelu.fsf@gitster.dls.corp.google.com> <CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
 <xmqqa916nq4p.fsf@gitster.dls.corp.google.com> <CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com>
 <xmqqtwzem776.fsf@gitster.dls.corp.google.com> <54C7CC6D.80906@web.de> <20150128105007.GA761@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Craig Silverstein <csilvers@khanacademy.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:00:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGfLX-0006dI-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 04:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763490AbbA2DAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 22:00:38 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38070 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbbA2DAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 22:00:35 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so28297654iec.8
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 19:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WDGE9PjDff4smZK2lDFS7xXqEZR4YeoE2d3El4br9lE=;
        b=V5hmz8CzMDG1uGqTz4TgbowoRYmZdUgAaI9uSe7KnUbNwmkoa4O3sHz/YV2cD/thKQ
         ZzzpE/ypSUbDF2zx9qb/1LX/kDwbDSgrOss5P7cUQX6/sMV4lTebocnn7kUix35vbRaZ
         Oj5re7fMaoHN6ROKVe3n5Th6r4IBJPCDoAznVWbjp4daZ/mOO0JCyMRXm+pDS42jOf6S
         R69HeFE13eWjVgxQiNwFiVXGcjIpaDhzvFcf1elI/++WcEejE/qBNXfklUY1XVBYJAv6
         GPXX/6y/qKX3hWIib8iEZnB6Ho4rc511kdOj4LWC2GXxIgZRFZYUPg+nDtPF+dEIo30Z
         rTOQ==
X-Received: by 10.107.10.214 with SMTP id 83mr3193418iok.16.1422442453998;
 Wed, 28 Jan 2015 02:54:13 -0800 (PST)
Received: by 10.107.131.34 with HTTP; Wed, 28 Jan 2015 02:53:43 -0800 (PST)
In-Reply-To: <20150128105007.GA761@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263135>

On Wed, Jan 28, 2015 at 5:50 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> For git-new-workdir.sh, perhaps we can teach include.path to make
> config.local path relative to where the config symlink is, not where
> the symlink target is.

Ignore this part. I originally wanted to use include.path to load
config.local, but there was an easier way. With this patch, I think
config.local is already per worktree that is created by
git-new-workdir.sh.
-- 
Duy
