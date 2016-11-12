Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4721F40E
	for <e@80x24.org>; Sat, 12 Nov 2016 10:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937878AbcKLKJK (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 05:09:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:52415 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934848AbcKLKJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 05:09:09 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nt7-1d1smX1Buf-00z1uI; Sat, 12
 Nov 2016 11:09:00 +0100
Date:   Sat, 12 Nov 2016 11:08:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
In-Reply-To: <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1611121106110.3746@virtualbox>
References: <20161111201958.2175-1-dennis@kaarsemaker.net> <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com> <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:69s7xVPh+iS/CRJ4Yw2H+W5W7zwXCzFbxYMazajnqAPpHJ6N2bd
 KoezKeSLidZSuH+5czi6YMDJR8yjyjZXXm5laALE3FyghV2zZQepnMemJg5aekuzZL7K21u
 ka/D3ise6J4VELZtELSb89AEsOwqNxmoD+hzvPVl5gO7ldpFZEuc3O9RUsxINpiicfu7Utv
 +epmaGswTADb33ZONQa7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+jmKNIfDZiU=:wrRqfGxw6rexCCzAWiGxLs
 U4M6o9kHASC+rmJXzgo0DjKrHuZ7c7e9MYrbEjoHubN0VapaKIN8n7nAmy+4MNHvU4vP11oDF
 ri6IN7bG0bZMjNbpeaZUvpJqxFs/PW/86Ld7F9JxCO0wVQFssbSxmaShSGwI53iE+ggznnLew
 lXNI5TOMT+rOSvVziZP87hKuhuMbmcq/UsHPOwsRxb6SiuIhnmxrjdLMMgerSVJS2Annf567j
 eq9L+SgjStW6zR1I1B7AAbnspIcojlcwcQSswYyHI+bawswEaW74bhJiFA4aCMd4SVXTM8wfh
 Jzkx+0oEkbGyWFC7lw72BBeRvO9c2+ajIDxFZ91dlbXeVXzo08YxP6cOV+xk5mdF9ZMPnDLlh
 yczeIsCadRTBQPRqwOc4XMZA9ggknne/6w3V56I4rIW1ccDKqi44F8EUt6GhKMLYR4vUTPRe5
 HPg6zpLUgbn3C7aYTh9Kby+UMSCSPtnlL3HW+IpST0HXs6gk9g1G7OZeor/8Xw6vcgX8f2g6/
 K9PooMw8Rryl4bb+mkdTngHV3MsZIp9vNPPjT3dmyqLKrT47xx786GqFgIHh9ux44WWbF7dQ5
 Ig+tAAEh0qjenn7+l8wWMHch4PTi11GOHXuA848ES6OpsSwn2FMpN5FAQ/2H6XBZNKfCk+uX5
 tUwbZ9AoDTwV/8+t72LTcdekEL0BIo9703f8yM1nXneXS++AZVfovKoYHvX+ewJj04QDA26wr
 WycA/OtwKOO6S4pzdmN/eg8VPtfjLFZMadDYwBRZkwszPKI09i5QO9YfkoBntOEMA0YfEVFJo
 bp0ygLD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 11 Nov 2016, Jacob Keller wrote:

> On Fri, Nov 11, 2016 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> >
> >> No tests or documentation updates yet, and I'm not sure whether
> >> --follow-symlinks in other modes than --no-index should be supported, ignored
> >> (as it is now) or cause an error, but I'm leaning towards the third option.
> >
> > My knee-jerk reaction is:
> >
> >  * The --no-index mode should default to your --follow-symlinks
> >    behaviour, without any option to turn it on or off.
> >
> 
> I agree. We shouldn't have to specify this for no-index.

Ummm. *My* idea of --no-index was for it to behave as similar to the
--index version as possible. For example when comparing directories
containing symlinks. You seem intent on breaking this scenario.

Ciao,
Johannes
