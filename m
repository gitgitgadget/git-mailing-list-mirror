Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768191F453
	for <e@80x24.org>; Wed,  7 Nov 2018 11:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeKGUt0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:49:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:36969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKGUt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:49:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lb5nF-1feie22Qsz-00kj29; Wed, 07
 Nov 2018 12:19:23 +0100
Date:   Wed, 7 Nov 2018 12:19:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com> <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d1yx7u+OWspDAbkipGs4LTpq0Kfwhp9CM+6I65sECfX0Tr6sUr7
 8FU1lsrnukxgbmeykXzpUfcnR+tr+lUSMd5X2cKwn/s4nZvT723nc2ytJBKRIQ5bbIfM61n
 8pYvyZAbJZzONuAURgskfPYf7Ez4o1GuwQ+UiGHoOUbUlaAH57VxcYZEd0SZMXhnMznMCBh
 l9LBzphG+JXCs5TdWyDEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vT1RE0sB+8c=:ZVtwXWuJ0ef4Xs1s1DUrQC
 Y7WDQ6i6rC8lPrRJNMGzrxo2Rn9zpTOKzNfX5z/jauMdA76UdOj7/YOWWN4B8phJJL7m3hinE
 BBi5RcpuJcAViCAlV7EXoCbTrIDj7nSFfRvRNZUfIhrtJ6M4nh2C74g9dQWtqOgWoy+IFDEqx
 7j8dWTRsruBuBjpKhpUjXcjuDQw7LuUJmpMKW7Cs4GK3kems3W78r/AMOUkWxZULFQqWdzA4B
 F4elLCqeE9O4KNz5iLkeTpKI9p5/y8D6D9UAHCr0jUIpzQXyVp7hVf2IgN4yVYm7klFfJQm5A
 4xtWZydW4vtYHy+L76S7CqXSZhxuVnq0M7Q+7rfVBrcpnuKYFht8Y4KfkakNGPpf1KXuGr/u1
 tVgL3AMKuNgCa8DsXNYb6nkNPmpiwGid69rfDK5lJBsrNX2OT/iB2DjSCo4CZAGP7BVQyN4vk
 749R6gwU4RZEpV/OEeT6N8xeGuBOd+nrlZHrr3oukJ6wg0fYZ/00Wkb/Qq9mlk/Cg/S4volMy
 FKGWnpPM6fcl2uX8OTjwCP69SayShA80lORLPVhXoAl7Ohr/2g2GLGHITsMq7TTFKlCCVDxUT
 AvoHz3xPzatYIMCmRnwPP9e0kJ7sIib8fSnGt8Q3tcBgBZy0lbxYddqclFbEa5vwK3eXT3cOo
 V7unLlUpZYceoDJKMLR8p2B0x33jPuef3dLbIvVm7RyKNVzz2Pad077nXdbColoW8ZvwInfU3
 hntzNDJB8RBntQAmWxPUkJFGQh0q3avURIAZQrAmwBVK9N06MEaee+T9goYL7dx4+GQITVfkf
 TkB3rjDECyatg8mG7zTSY/PGA/qVgWJC9+Zc91u8emWx+N3dCM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 7 Nov 2018, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > On 06/11/2018 14:53, Johannes Schindelin via GitGitGadget wrote:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> 
> >> On Windows, an absolute POSIX path needs to be turned into a Windows
> >> one.
> >> 
> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> ---
> >>  path.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >> 
> >> diff --git a/path.c b/path.c
> >> index 34f0f98349..a72abf0e1f 100644
> >> --- a/path.c
> >> +++ b/path.c
> >> @@ -11,6 +11,7 @@
> >>  #include "path.h"
> >>  #include "packfile.h"
> >>  #include "object-store.h"
> >> +#include "exec-cmd.h"
> >>  
> >>  static int get_st_mode_bits(const char *path, int *mode)
> >>  {
> >> @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
> >>  
> >>  	if (path == NULL)
> >>  		goto return_null;
> >> +#ifdef __MINGW32__
> >> +	if (path[0] == '/')
> >> +		return system_path(path + 1);
> >> +#endif
> >
> > Hmm, this doesn't quite fit with the intended use of this
> > function! ;-) (even on windows!)
> >
> > I haven't looked very deeply, but doesn't this affect all
> > absolute paths in the config read by git_config_pathname(),
> > along with all 'included config' files?
> 
> I think so.  I have not thought things through to say if replacing a
> "full path in the current drive" with system_path() is a sensible
> thing to do in the first place, but I am getting the impression from
> review comments that it probably is not.
> 
> > I am pretty sure that I would not want the absolute paths
> > in my config file(s) magically 'moved' depending on whether
> > git has been compiled with 'runtime prefix' support or not!

The cute thing is: your absolute paths would not be moved because we are
talking about Windows. Therefore your absolute paths would not start with
a forward slash.

> In any case, the helper is about expanding ~/foo and ~who/foo to
> absolute paths, without touching other paths, so it is a wrong
> function to implement it in, even if the motivation were sensible.

It could be renamed. In any case, for this feature we would need to expand
a path that is not the final path, and this here location is the most
logical place to do so.

Ciao,
Dscho
