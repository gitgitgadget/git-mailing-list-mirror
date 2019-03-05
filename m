Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8598F20248
	for <e@80x24.org>; Tue,  5 Mar 2019 22:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfCEWzm (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 17:55:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:37595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfCEWzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 17:55:42 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTF6-1hX3Lm34lo-00cdTf; Tue, 05
 Mar 2019 23:55:18 +0100
Date:   Tue, 5 Mar 2019 23:55:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] curl: anonymize URLs in error messages and
 warnings
In-Reply-To: <20190305051126.GL19800@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903051709330.41@tvgsbejvaqbjf.bet>
References: <pull.156.git.gitgitgadget@gmail.com> <ab6f4032cb8cbbe77dbfad4660c30acd7ba688bb.1551713624.git.gitgitgadget@gmail.com> <20190305051126.GL19800@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n9t+DhWzXVs/A0OMBwtkECXOFCLR/tjvVIR0zTjq/D2rKWbOV1/
 Rv2QW1kOUqBsVhlj9KRvlYzTrsSJqIdZVQ0D1S/eEUqFKQ53E50bhHylvLsjdF4n1vLXcQP
 RNzIrvng3702zOT+dAOAOpulvD0DJ6eMOi/YSVG+KDJI4Dffdt7QjYKYz2TIpW0Dx9AOs0O
 Gx6L8w6RuObcDkfslDvhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vSccu8pPlwY=:wY5GYdivw82Qq2xtAPdA3Q
 xLTa6TDlaX3Y7K0/KVICmURCoF04qLKH7uv5+/KAqJ5lzm+2eC4DLVPj8BwXWAw8Xa7udsUqC
 QMYAOktBsSxFMyv2NTUkxLGBbo66gBd3R8VoY5C9T1MC9ON+QJsU1ATEP00Gt/RfXwzw10zij
 PuUJPNa7gypOFWeYEbev3JlmONAuRAx6qCA3IZPHdZpQKmpNhDCS7Lp1reO8Yf22QMSN9YzdF
 4Jt7FIhebwmw3wqmCXjc+IO6sxWKjkQvEzUfajbWdt7Yk8rtDEC6UT5xEidZYsfQLT6XQO4FL
 jOkw1ph4P4Vo80R/ZrmA0A1g+LayhtKE8OQQ5m9lN116DcYqqJODJ0fynX9d1hs5o2fbmd32m
 wkcHLqRCWDuIIF4R410++m3+l/GMJ3ce8ts6MVHpQwp80WbkCHMdjiKadpfDxXgkA/WW4Tk92
 dmyQ/AfP+6yXAC83be9V3czw6aV0ujDNOks7KW1enUIKVM9RfOp+Gf02WyP+G9frD9WIdOnPQ
 rtXHHeLcl75JYqAOoDqs0a3wqd5fBkpwjgGDqzn+HwRum/LiSrboMTLimKP/bQM9aEID8sm91
 m7JfSraefi+lPdz+Y885FiD+svqZqC4bUT7K8qP2/yzVpaCjjnVc8hVVp95XkRFcbkueOKeV8
 UOgtKGLBjXI0W3IvXXQ1ENCqkA4t7IorsIXkm4ZWcRggUKoq1/TmYwDSPaeS4RO7b0fmn4uav
 l9wCXNEu+km48jN0PkHSdQIrpYgMPsqiUo+pxvZRJVA3YASatd0JHIuGH5vidVwTpWg/iwpd9
 o5K49y3q/gykfJTDLE6rRoYu9LdiQ9fenrcDlNA6BiXDjdjhXef99USEpIUYQSyT+IDCM3vE3
 MiuFtyVVISM5IkP0WuwFyd9Mac0RYZ74NFedWbVtPo4sdTQbtvx5nCkA9zUuhH/0/kb68x3IX
 REUtdaCjSuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 5 Mar 2019, Jeff King wrote:

> On Mon, Mar 04, 2019 at 07:33:46AM -0800, Johannes Schindelin via GitGitGadget wrote:
> 
> > @@ -442,17 +443,23 @@ static struct discovery *discover_refs(const char *service, int for_push)
> >  		break;
> >  	case HTTP_MISSING_TARGET:
> >  		show_http_message(&type, &charset, &buffer);
> > -		die("repository '%s' not found", url.buf);
> > +		die("repository '%s' not found",
> > +		    transport_anonymize_url(url.buf));
> 
> Sort of orthogonal to your patch, but these could probably stand to be
> marked for translation (I'm happy for that to come on top later,
> though).

Good idea!

Ciao,
Dscho
