From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] resolve_gitlink_packed_ref(): fix mismerge
Date: Mon, 17 Oct 2011 18:12:35 -0400
Message-ID: <4E9CA853.10107@gmail.com>
References: <4E9B1E32.7030101@gmail.com> <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com> <4E9BA39B.709@alum.mit.edu> <4E9BFE66.5070906@gmail.com> <4E9C2F3C.7080405@alum.mit.edu> <7v4nz7o7mg.fsf@alter.siamese.dyndns.org> <7vbotfmpbh.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:12:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvQK-0002eE-6m
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab1JQWMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:12:39 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34073 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab1JQWMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 18:12:38 -0400
Received: by qabj40 with SMTP id j40so941436qab.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1JaQ7MGMDcdswX3sZbjs+f4KtzlfOa9N0kbJASR+yfw=;
        b=ZURSgiKmjYzcBc1yuBbj21KbhsBPUuUJmbuKH3lxq3Uo3Slza8csunYok/Z1wviddM
         WNXMtMavETfrfCWPPP07BFyxcSAsfhp5Z66YkQ+2lUU683nkOmNZqvwivRW8Uk2Gf5p7
         QgjW+4eh/jLQyFG33ZJ7Q+0//RbRLL++bgCvQ=
Received: by 10.224.32.5 with SMTP id a5mr17415601qad.69.1318889557445;
        Mon, 17 Oct 2011 15:12:37 -0700 (PDT)
Received: from mark-laptop.lan (pool-173-73-114-154.washdc.fios.verizon.net. [173.73.114.154])
        by mx.google.com with ESMTPS id v6sm25688293qaz.7.2011.10.17.15.12.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 15:12:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7vbotfmpbh.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183830>

On 10/17/2011 02:43 PM, Junio C Hamano wrote:
> 2c5c66b (Merge branch 'jp/get-ref-dir-unsorted', 2011-10-10) merged a
> topic that forked from the mainline before a new helper function
> get_packed_refs() refactored code to read packed-refs file. The merge made
> the call to the helper function with an incorrect argument. The parameter
> to the function has to be a path to the submodule.
>
> Fix the mismerge.
>
> Helped-by: Mark Levedahl<mlevedahl@gmail.com>
> Helped-by: Michael Haggerty<mhagger@alum.mit.edu>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>
Thank you, this fixes the problem for me.

Mark
