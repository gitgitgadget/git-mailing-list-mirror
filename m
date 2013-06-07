From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add deprecated __git_complete_file ()
Date: Fri, 7 Jun 2013 14:25:54 -0500
Message-ID: <CAMP44s0_YkZeC_Xrd1XUo=4=yJDy=8wQKYe34uybhXVqi9bd9Q@mail.gmail.com>
References: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2IS-0004CQ-On
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab3FGTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:25:56 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36722 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3FGTZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:25:56 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so3464436lbv.41
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2WuH1gfdLQHoV+I9NsYicdTMGIpbTOpc1P7LRO5GIbc=;
        b=tqeIxIombNTsA4EW159IltiEk+0Tg7plDqk5PsAcgkVzgeTcHwz6qtALVEo5WpXgTS
         2O5Ti8kRmC6JdAuVWFKDcyHLHFIsHEn+z34ri2e3YjQboMxZYxO7CrASEWYS62xAscnP
         RtWNc8sXAob/lEpGYf4sZ9T+E9tx6JZZMDeSbevBq+DZnsTJ+j92X76niGxQERvU4+Pd
         MIxM0FN7lZ+YSAvIb6Ic7BQMiSeT493XK46et3+14CVychlgTexHkeYAkgLh4/US61cb
         PUQ3fbrunJxQd8oGV5S9R5vUtWYZr5UenW8Ssbtuvx6OZ25CIgLnQFzfIeVri1MIrkSA
         SvKQ==
X-Received: by 10.112.140.231 with SMTP id rj7mr1905346lbb.16.1370633154716;
 Fri, 07 Jun 2013 12:25:54 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:25:54 -0700 (PDT)
In-Reply-To: <1370632168-25298-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226680>

On Fri, Jun 7, 2013 at 2:09 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> 77c130 (completion: clarify ls-tree, archive, show completion,
> 2013-06-02) removed __git_complete_file () because it had no callers
> left in the file.  However, to avoid breaking user scripts that may
> depend on this, add it back as a deprecated alias.

This is fine by me, but at some point we need to decide how we should
prefix the functions that are supposed to be used by external scripts.

Also, maybe we should start adding '# TODO remove in v2.0' so we
remember to do that in v2.0.

-- 
Felipe Contreras
