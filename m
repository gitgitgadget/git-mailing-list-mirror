From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Sat, 16 Apr 2016 07:08:32 +0700
Message-ID: <CACsJy8AqoRq3SRATvP6Ww3s9cnzkSKCvhEA8UbAVdhQF_=aYew@mail.gmail.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 <xmqqtwj2di3r.fsf@gitster.mtv.corp.google.com> <xmqqa8kudcnn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:09:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDnU-00083D-6T
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbcDPAJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 20:09:05 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36124 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbcDPAJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 20:09:04 -0400
Received: by mail-lf0-f42.google.com with SMTP id g184so162674978lfb.3
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vp6k36ILxLN1RnsDAofTUSnkyyLm5iTMuMwhBxe71So=;
        b=g91z/U4bHHauvfX1LYAh1k43Lj1nqZlAace+nE9pBdp2WeMgF44SGYBRPVahnrY1gx
         CPEQAGEZFDWjWUGiDSCFWih8YVm5xi/RE5LRU6dBA0ZOHQkIPgpDDJS3PjWDzKiCooCk
         zWjMHG9aefCkvaEX3lPnntKn88OFhBAF0gv7xCh4098PxNv9hXGeSRkD1oYpWgVBpfZX
         0MVpfbr7GGgC2EftPr3Smeu8kRGlDY2JKQNw0zFiBHXhSIRXZgrr77j+JhBxz/dlZ2Wf
         zXrADI1Qhoa7fYPWRX4bB4ukA9altAHWJETGLCKAdBx4OZhqAnR8f8gpLFmiTYvmRdP1
         gkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vp6k36ILxLN1RnsDAofTUSnkyyLm5iTMuMwhBxe71So=;
        b=hC2yinrcDDuuIroESNqJqpyOpEE9gD2boWlfyduUzAXAoU4wgiz3qk6TSh1RA1IFjS
         FGkoj/7ZOkXMWwz8ETYurHlhMcQSyohFtV95c42rEd0q8r52M7WbfIYLXlws1UXTvCqS
         dDU+cIOfhQxIwjjNFP3rRDI3W6u67ybG+pd9SrtdBd6ejuOYJhaQQmN5Epf7YJhIF4hg
         6NcYH9W4Q0AdjDnyHEpodjq1Pame9B9tYKbnYxJYmggKgbKiDmjAQlX058EfYSXnLD3g
         j2TpM+d5bakdUkceayB+2wBI/cc3idJcezM/OzrL28KnVGhfB8Ych/pYc5V0mG99jSPD
         eJUw==
X-Gm-Message-State: AOPr4FW5DoLYTcKPN9kv5Y6NRa3xjGhro9JJLlYc8mWLEery0vR9YC6ydkJZWQXFAUL79pPiTLZbhdpimro/yA==
X-Received: by 10.25.147.202 with SMTP id v193mr10377571lfd.162.1460765341757;
 Fri, 15 Apr 2016 17:09:01 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 15 Apr 2016 17:08:32 -0700 (PDT)
In-Reply-To: <xmqqa8kudcnn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291702>

On Sat, Apr 16, 2016 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> This keeps top dir a bit less crowded. And because these programs a=
re
>>> for testing purposes, it makes sense that they stay somewhere in t/
>>
>> But leaves many *.o files after "make clean".  Even "distclean" does
>> not clean them.
>
> Perhaps something like this as a preparatory patch, to protect us
> from future breakages similar to this change.

Yes. Much better than adding t/helper/*.o there. Thanks.

>
> -- >8 --
> Subject: Makefile: clean *.o files we create
>
> The part that removes object files in the 'clean' target predates
> various Makefile macros that list object files we create, and
> instead removes the objects with shell glob, perpetually requiring
> updates whenever a new location that builds object files is added.
>
> Simplify the target by removing $(OBJECTS), which is supposed to
> have all the objects we create during the build.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index fe0bf7d..69d32bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2456,8 +2456,8 @@ profile-clean:
>         $(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(objec=
t_dirs)))
>
>  clean: profile-clean coverage-clean
> -       $(RM) *.o *.res refs/*.o block-sha1/*.o ppc/*.o compat/*.o co=
mpat/*/*.o
> -       $(RM) xdiff/*.o vcs-svn/*.o ewah/*.o builtin/*.o
> +       $(RM) *.res
> +       $(RM) $(OBJECTS)
>         $(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
>         $(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
>         $(RM) $(TEST_PROGRAMS) $(NO_INSTALL)



--=20
Duy
