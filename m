Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7AD1FC96
	for <e@80x24.org>; Sun,  4 Dec 2016 07:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbcLDH6H (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 02:58:07 -0500
Received: from mout.web.de ([212.227.15.4]:61024 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbcLDH6H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 02:58:07 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQf77-1c7coh2TT3-00U6XT; Sun, 04
 Dec 2016 08:58:02 +0100
Date:   Sun, 4 Dec 2016 07:58:00 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] update-unicode.sh: automatically download newer
 definition files
Message-ID: <20161204075800.GA2415@tb-raspi>
References: <835c0328-e812-1cb7-c49e-714ff0e9ffb3@drbeat.li>
 <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:d0tWP5rE0J7PfsInwCQDrDNmxSpgzM+NvBg5XmOo4f0FKVNQ4AF
 NniWNtllgc3k6jhpWix2S071lMGGuhpRxpk1OMLSH2JU7Ag8Ft/iDJM7PJDKhsnpv82On/b
 e5atAFTsR6oE77tNB1LokH8kQ/K699DPvWpyVZ6+Vz/gZPgx6ah/uMVne6J9dZkqAUB9KGi
 cThFnpGuiTnWwKW2+9CXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GxbtFmywN4Q=:1bUVdVyhuF1q0sfw+72arv
 /HZ7/PwyhIKqyxlcWHegLWC1nofmfjNd0Du1d0Q+WS+sMr3EbPiOPe5etr8CpBsWeeeUBZ0if
 Xot44v/6iIiPnIRAooz9AWZOCSprfeV2Vr8GLoOcDoiCtFXSxB2ZJZdFIHnE3zMVO1cJ3XJOA
 3EJoVnkYaaYOevM76GQdUrDt79u2LLknE/i/CLuy+tNZBzuLaaek4LVo9C0zhBFHCs4+vkynP
 M3H/WoATUyCnP7DSO/difR6UiA9diIUn+k3yAj3iRyZlFuGHYnA1lEKL9lM3ZSMLSs626XnmP
 Dm3xXtbfXMkJrUFh0eB64QSjktNJlXBDzAJLgiNl2fA2WfZYSNAdjdfcgA33OKNhgEG5Gb3AZ
 lwPYoRplSfDs1RYCbavOuxIt0crwWGnlqXPl8ocT8rhJMenL+py6ByzoYVWy4Fj5BhwUszMOn
 2U1h+r7R3CpjAwedHhp9lz+TAZYxq1ZhIP2LEj3Vn9LXK4aXnc/C5HJf/LmTeZDGpTOJ9B3jG
 TLK1jWWdHe/tG9rltbfYauxTA5L7W2APfvGFipltoCzsI6IIqXP0eREvI8BNwdwjFOU6SHjUc
 uC+7Y1wZ3Tsfyo0yQFSGzghnb9wMbMC2x2nuf5ngrwEnySvgTloh2q2z1nJ+sPPGEFtYc6IJ8
 W/m9IvPbEtyft9+YzYt3qGeYxWUcHxf3y1OjOFjHv9gU2i3yuxs2quUt0PXd38G7Kh9/44dpA
 PaCGIykIiSZMwWQHELbK7ZTOy0LCc3YrrMEvbhdTo2Fx7SA9WqziAqws0E8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 10:00:47PM +0100, Beat Bolli wrote:
> Checking just for the unicode data files' existence is not sufficient;
> we should also download them if a newer version exists on the Unicode
> consortium's servers. Option -N of wget does this nicely for us.
> 
> Reviewed-by: Torsten Boegershausen <tboegi@web.de>

Minor remark (Not sure if this motivates v5, may be Junio can fix it locally?)
s/oe/ö/

Beside this: Thanks again (and I learned about the -N option of wget)
