Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDA41FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbcF2LpO (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:45:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:53992 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbcF2LpM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:45:12 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MPV69-1bDX6N17fF-004g7u; Wed, 29 Jun 2016 13:45:10
 +0200
Date:	Wed, 29 Jun 2016 13:45:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Andrei Faber <andrei.faber@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: git gui produces series of commits with exactly the same time
In-Reply-To: <37a71a23-ded6-9d48-a873-a05f33e802bd@gmail.com>
Message-ID: <alpine.DEB.2.20.1606291344400.12947@virtualbox>
References: <37a71a23-ded6-9d48-a873-a05f33e802bd@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4KJxoT2W5u5ETeuaOnRXWU+8eZB43iPc0hnp9zvyow82XmFnvh4
 wfxv8MnKu4iiFrowAHl6kjzU6v3MMc3QgIUxuZO3I1r8BLbMWEGA0keAOT2eDCbgfdXGYcS
 vSk2Kc7H8PIdiMtz8ckPQCAz62dEYB/7scze7XGunN8PYE0Nb90rNOT0fU7k/6APHLzfeN1
 pmLYI8cXt+PbyJ724GLBg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:e86I+q+kn9M=:zYQxANHd8Gj7C2h40/TvJ/
 um7Yej+UcflNIV1n6GfN7HoRTbp5omuA0wsYhoRXiGZniaEvkm+xGmvwpHeXeBNlE3qLkEakl
 wqDXtezCv5G2w2971dDUetuqx9LXgKhmzjQ4DsNucaz1k44NK8LTjkf1dTaN/HNWssBtQvME3
 u4J230UEnFAXhCv45g9R9qMkv3V0N1U91+jvVd5QFakkmcltLByi+eqYTZGpq0C1Z5u5Ymhio
 imI3S8Hnse/ztHLa72oGZywJhGBs41dwKQf0Wf0zFIeBFzVUSdDnw6ECqR7koWdkqW1upRxXV
 uPMjl+XHFEJJbqYCqTyRvgWP+EvEle5YlG1Di7xW41JtTSiIlnzwTGxEkZOoODkGNbfVDiO9r
 sdkXavn+B/xc+sl1dnuutLhB033lWIVJ6hop3ivyK1chEAbsC5lJxBqSyMQs3g759Nsr6M+kN
 GtNN2OyvMsYQ7pYN7bW2mVXjSkwP9VjFF5IURj7KI/y+J1Acyz+Mp0dayO+7CwM+aiKTv6kSC
 VlVgwTcwrKbBgx8ZCq/eD6QtPydFVRIMVPWyVgM0qbNlt85wYNX9dXjtdQJLY9c7V8/P1DghJ
 Cw7prNulk1ZOkvkkPEwmjdbSbaUFWNTBpYuvP9H/dQqfWGw5Z8yVlh2P3rXWcrusdDHH/1b4f
 v0GYLkrMnp1vvk2+Tc7qSwsOWNzekCPaEOjzcS3XOBhu63XLJeP4Z/8KXHJUmfTfH40sV8Ys+
 Ja4SlV3d/b8wXix+636TjvKGYzlKA7GMZDYZW7cGOwjIIGX+aR8t0ym2dHYta7JvkdJL2Lu8l
 6uCP1XN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Andrei,

On Wed, 29 Jun 2016, Andrei Faber wrote:

> I've noticed that git history contains series of commits with exactly
> the same time, despite the real commit time of these commits was
> different. All these commit were made using the git gui tool. I'm the
> only developer in this project.

Is it possible that you played games with your GIT_AUTHOR_DATE environment
variable?

Ciao,
Johannes
