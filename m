From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Fri, 28 Jan 2011 03:30:54 -0500
Message-ID: <AANLkTikLse9+CTwHo6W49=EHj6O4xLSWmNj70RFTpzzb@mail.gmail.com>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
 <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com> <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 09:31:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pijk9-0003Nd-Su
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 09:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab1A1Ib1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 03:31:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59938 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab1A1IbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 03:31:25 -0500
Received: by iyj18 with SMTP id 18so2317466iyj.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Bko+WPgiiTBoGE96bPU2O6fxaK/m6hyScelQYu4kr3w=;
        b=Vw3boKhc8lfWEs0cHJUYEPJF22Qo9UJiZePg2pNslgWTsNA3Ka5AurYzD8q4SQuNEU
         tnmMgqDTvwyMir61/bz0NnXKNiTCnqlpabl7fBcxG9ZZRShBwQfAcqeoZG71L0sSVSqn
         orS4Ns6k99/65NN6IErlW9fEh4g9JmQ+0lEYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LXoDjq+Jmughiv4we9pXqhrrsmFmb9bUM07F2B7DYMmzjTZSjyQIR9U8UyE8VpcLKU
         N+Kve5eca7z0SKwOwtj7cEzSDVsWbncdAkzeFk2MXr3h4oZYfSFqV74KycyDcr4J30Ve
         P6LQCU1boI6LpL+66oB1qDLtWM5MNra805mzY=
Received: by 10.231.85.137 with SMTP id o9mr2273008ibl.27.1296203484331; Fri,
 28 Jan 2011 00:31:24 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Fri, 28 Jan 2011 00:30:54 -0800 (PST)
In-Reply-To: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165602>

On Thu, Jan 27, 2011 at 6:22 PM, Thomas Hauk <tom@shaggyfrog.com> wrote:
> Git just doesn't seem to scale when it comes to componentized projects.

With git the canonical approach, such that it is, is for each
component to be its own repo. You then tie the repos together into a
project using submodules:

- http://progit.org/book/ch6-6.html
- http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html

However, submodules can be a challenge to work with, and so there have
been other attempts at tying multiple repos together such as:

- http://source.android.com/source/git-repo.html
- https://github.com/apenwarr/git-subtree

j.
