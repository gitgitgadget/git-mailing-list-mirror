From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: 1e633418479926bc85ed21a4f91c845a3dd3ad66 breaks on OSX
Date: Tue, 5 Oct 2010 21:05:45 +0000
Message-ID: <AANLkTinq7haFRs6h8W+ycDy5MzFgjty6LaD8syL+KnHX@mail.gmail.com>
References: <86r5g42wo8.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 23:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Ehy-0004YO-MO
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 23:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab0JEVFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 17:05:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45223 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab0JEVFq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 17:05:46 -0400
Received: by fxm4 with SMTP id 4so768005fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nL0QNhRMkOper1EU0eRmkN85Yp3OmTy7gmTzxTNd2Lc=;
        b=DhjYIiIu46gB/fPApaq/YeS5vO9K57bXVu+ATkFGcHhI23LuueWy9i6cVLEvR5U0yw
         L/Sl9hIXCJueOcZLgM2fAz+xA+tjHNfi4G2T/6iF7nCHMyY/BBfconWNxadlB5sFQGxF
         6mzFVmvxGuGE9mgUx5fZf9aaCfgaqCoFDmCAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fz2KvhtNnUjQbNoKpahiy1Lq5tLvBaqpGvc/cxGYICxks4S/gQKUpyF9IT49l+2N8n
         18FT2HXTrBa95xQHKSchb5QQjJSzHDrx9RD/hJ0iBklLEhtuAsgFoIxuX5Ly1WD7CGPt
         y0V2I3SbOFROoKGKOA33eYALkDa+qGpbPh7fM=
Received: by 10.223.118.18 with SMTP id t18mr5552730faq.31.1286312745404; Tue,
 05 Oct 2010 14:05:45 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Tue, 5 Oct 2010 14:05:45 -0700 (PDT)
In-Reply-To: <86r5g42wo8.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158247>

On Tue, Oct 5, 2010 at 20:48, Randal L. Schwartz <merlyn@stonehenge.com=
> wrote:
> =C2=A0 =C2=A0SUBDIR perl
> make[1]: `perl.mak' is up to date.
> =C2=A0 =C2=A0GEN git-add--interactive
> Writing perl.mak for Git
> make[2]: *** [perl.mak] Error 1
> make[1]: *** [instlibdir] Error 2
> make: *** [git-add--interactive] Error 2

1e63341 is a merge commit, and none of the merged things (in the
commit message) seem to have anything to do with the Perl makefile
process.

Can you run:

    make -j 1 V=3D1

And report what output you get?
