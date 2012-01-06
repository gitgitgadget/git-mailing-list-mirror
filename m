From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Fri, 6 Jan 2012 09:26:53 -0500
Message-ID: <CABURp0rFOFfX7eu-v6ZK07iTfXwhOne60d70GkCdOvx0k8BZkQ@mail.gmail.com>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 <7vsjk3vw67.fsf@alter.siamese.dyndns.org> <4F007492.8010909@web.de>
 <7vsjjwvdyl.fsf@alter.siamese.dyndns.org> <4F037CBF.9010005@web.de>
 <7vhb0csa6w.fsf@alter.siamese.dyndns.org> <4F0629C6.9010908@web.de> <7vlipllmfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Antony Male <antony.male@gmail.com>, git@vger.kernel.org,
	iveqy@iveqy.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 15:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjAlM-0002KF-V0
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab2AFO1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:27:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48194 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2AFO1P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:27:15 -0500
Received: by wgbdr13 with SMTP id dr13so1794211wgb.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QsEf95fw8Yo90mX/dzmS35SJQq215IZ0yOXcN4gE4Mo=;
        b=gs0MXy9cCYfEiIzc1EsocLwupGhoB8BXWNqSWFTEW2gRc9KknDgcDZ13zSLkTtYcHr
         X4KPMPXVMnpK7bgtG8a5M9qOeypIq/vUCZu82ts1jv2ScIlKWe3mscPGC11kE7wKxEiz
         xpVPVAYej2SLGXKWetNKRmihb2+IHdAwaOnL0=
Received: by 10.216.137.232 with SMTP id y82mr3334267wei.0.1325860034459; Fri,
 06 Jan 2012 06:27:14 -0800 (PST)
Received: by 10.216.19.82 with HTTP; Fri, 6 Jan 2012 06:26:53 -0800 (PST)
In-Reply-To: <7vlipllmfh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188028>

On Thu, Jan 5, 2012 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> If not I'm fine with just setting core.worktree to a relative path in
>> the git-submodule.sh script (like I did for the gitfile). And I'll look
>> into teaching "git mv" about submodules right after that.
>
> ... teaching "git mv" may be a good move, I would think. I do think keeping
> core.worktree pointing at the right directory is necessary, but I do not
> see much point in making it a relative path, though.

I do, in the case of submodules, as already discussed.

Do you see any _problem_ with making core.worktree a relative
directory in the specific case of git submodules?

Phil
