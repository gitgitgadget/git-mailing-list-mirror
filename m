From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] upload-pack timing issue on windows?
Date: Wed, 25 Aug 2010 22:57:33 +0200
Message-ID: <AANLkTimHmFQmgX5q5n=yj3VKpgPFzpnDd0v-RY6bgpfp@mail.gmail.com>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
 <201008242124.23890.j6t@kdbg.org> <AANLkTinboi+L3fvC___pULO0u_ZBNNOM6er+chxt7s07@mail.gmail.com>
 <201008252253.04516.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:58:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoN2m-0003Jh-FW
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0HYU5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 16:57:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34909 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab0HYU5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:57:54 -0400
Received: by vws3 with SMTP id 3so978297vws.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=T7slajW26VZNtGczH9NyxoI+ar/XSlYoRL7bw+FzmdE=;
        b=CNaNXgqp4QowIguWXSPWTinHNyVhf6TKzLiFmw+WAWGi2AexJWrCmVvZaMcF1oSKx5
         D0PYEwtz2EoXeU6pM8dpPN+M9hujtMtudTuZmKKJLquKr5A0GRdCiKwayPB1Vc2mFeKu
         C9PBQzMRVfn/APOixyjletH5ie5wUel2hoxNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=Hy5Tu1Cr8MF+3eKc2MTq9Wo02bru4O3lJHKXqxklEfYjsldd5H+rrieNlbBYEnqZOd
         63X1sLgbjAjC9yqLTEqZYH+5WnzvyzqiyNMRgs8ItL4o/Ggf1K7PW7N4/cBBGkhuC8nj
         zxn3kNDNlGgjvbJ6ssZk5Rhx0Ee3W103O2lME=
Received: by 10.220.61.6 with SMTP id r6mr5690444vch.146.1282769873214; Wed,
 25 Aug 2010 13:57:53 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Wed, 25 Aug 2010 13:57:33 -0700 (PDT)
In-Reply-To: <201008252253.04516.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154473>

On Wed, Aug 25, 2010 at 10:53 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 25. August 2010, Erik Faye-Lund wrote:
>> But I'm curious, what's the best way of import a couple of foreign
>> source files, while maintaining a couple of patches on top of them?
>> I'm thinking that perhaps a import-commit followed by the patches
>> would make it easier to merge in changes than to just import the
>> patched version, but I'm not entirely sure how to do such a merge
>> without merging a full subtree...
>
> This is about only two files. When a new version is available from upstream,
> just branch from the import-commit, apply the two new files, and merge the
> result.
>

Thanks, makes sense.
