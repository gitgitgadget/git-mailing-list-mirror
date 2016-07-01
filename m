Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD7F2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcGANl2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:41:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:61805 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbcGANl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:41:27 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MbOoG-1b0DOI1phM-00Ii5S; Fri, 01 Jul 2016 15:41:22
 +0200
Date:	Fri, 1 Jul 2016 15:41:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ioannis Kappas <ioannis.kappas@rbs.com>
cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
In-Reply-To: <loom.20160701T120539-937@post.gmane.org>
Message-ID: <alpine.DEB.2.20.1607011540470.12947@virtualbox>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox> <loom.20160628T175016-898@post.gmane.org> <alpine.DEB.2.20.1606281825190.12947@virtualbox>
 <alpine.DEB.2.20.1606290911040.12947@virtualbox> <loom.20160629T104814-936@post.gmane.org> <alpine.DEB.2.20.1606291341530.12947@virtualbox> <loom.20160701T120539-937@post.gmane.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Uy4Mbq/4VMPtktr2mxlnALJ5iYpP5k0TiCuLUIGRqixm8MTlfjy
 zTTAO1WHRA5v70F83sGJiiPFS47r0GS0QQ8Qinl/M2n5bpaMcC2uby6Rnr+F7ozB235RrpM
 QpEBiPbvRLr2F/+nIxVVK3YT5rB/ylVAU2NVnhAD3v6zAymYe0R6Rz4LpRC0zywhpZ5GbJl
 UsDn4z2OfS56M8g+Aabnw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Q1LhT5OuS5E=:KxygGyZEQfZ1PacBJ7P5xz
 4N0PL/y7rXhUPWL3kRCGNbd1uBgVK0ZHgXxMc+G1/aYjAONLWOyKZ+ng1qO7lOiVNGiViT7Jz
 aDA5oGwCIbV2XkZUJ32Ii9TNeleaqr0tI8i9y2c/iNzZfvKB9lB0FnydO08CLkJEF8l51s89c
 VwobZze6x+du0wHHuUmtMDXZigEQrKAj5cckAotact1b4Lyr7mFpEmsoS4ZDJ91HFfTXLUyXS
 Uwglw7NTVdzXJ1o1+sOwnwkjXvMp0OusqXdlEeZUzN2DG+qfZycGB/xLb4UcD/85AISarHB3X
 d9kOFPffLXq9q/STKcL9bo9rULmMAW1KdKebQCOE8+2+HxxC1Nv8RDFdSveAEo8nE90D3AnZS
 fz+d7AJWZ7sU7vDpH7/2ktTJPoyhzzVqoXTumWHAzo0ne26Nn1BxM3Vg8S40vDEHPzOtSfGZ/
 /5KEv65FLvQLGMcHJZ5tNP2PRvhylQC3KO93jr/1iiORhPOuQ2+PNWoICD6Lv0OHPxDOJm+XT
 W00K+Fo2DQvkei9ZLnIXGfFwFXYgG3o9eKVxaZFznJWRb486eTECVIGU3VXb8IKQvj1cfqmB3
 jFOR/YT0nRGDIxrciyL4gS2KXwdhJuGlJ5/er/cIBDDJxiLO0QqoT7/s2bgtBfKUuxE+scUOJ
 Eh5adLmjIHZW9F1C69I+8yb1paRYbxQxCW/zz7lZ5HNyA0Axx3sujr3v2XdxoYnxvpIdfttHU
 Ntj+WdnqGoCEmlKvJfuToReAwCUyNQm0IwYa+f9js/VQpJHq+G7fMyZZoBm2ATit/nWpibLY1
 HAHpkJs
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Yannis,

On Fri, 1 Jul 2016, Ioannis Kappas wrote:

> Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> 
> > [...]
> > 
> > My more immediate concern is MSYS2 (the POSIX-emulating basis of Git
> > for Windows), and I opened a Pull Request there:
> > 
> > 	https://github.com/Alexpux/MSYS2-packages/pull/647
> > 
> > If this Pull Request is not picked up in time for the next Git for
> > Windows version, I plan to use the packages that you tested.
> 
> The patch has also been accepted for inclusion in the forthcoming 
> subversion 1.9.5 release ("barring unexpectancies"):
> 
> http://thread.gmane.org/gmane.comp.version-
> control.subversion.user/120144/focus=120146

Perfect. Thanks for being diligent and keeping us informed!

Ciao,
Dscho
