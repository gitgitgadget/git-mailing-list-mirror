Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737A6203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 15:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbcGUP0b (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 11:26:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:63232 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbcGUP0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 11:26:30 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lz3rc-1bCpe43eE4-014Bpy; Thu, 21 Jul 2016 17:26:25
 +0200
Date:	Thu, 21 Jul 2016 17:25:41 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	David Aguilar <davvid@gmail.com>
cc:	Brett Cundal <brett.cundal@iugome.com>, git@vger.kernel.org,
	Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH] git-subtree.sh: Use --allow-unrelated-histories when
 splitting with --rejoin
In-Reply-To: <20160721052625.GA31423@gmail.com>
Message-ID: <alpine.DEB.2.20.1607211724430.14111@virtualbox>
References: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com> <20160721052625.GA31423@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jsEZ5FKHS336/vz+aWfA2OPzsgRT8KwhAoub9R/s/gY5bwnhXF8
 0s2R0MtUgAsjMyr4vEuQeLimYvliMfpmbTalzodWV9ITQSjcU1lZJVmLKvWHtN3vQbmKM+c
 3CH04XV+JcMz4rouCniYX5OpcScSHbSWWmsJinmaVZZ+w7c/1wF53aZVn4kmLh42rq3jZ/J
 9u1HDSAm91//1p4r45xJA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ia5ICF1cLHY=:q/zGCVs9VD/AAterOilywa
 ttZDS83krtxyzBxREI5O4mBdShAehuF6+cNii/ksa0SKsryjddBcVJq0/9g8xIjwqM38vidGN
 Di4ZCTLQR3nbGwOywMRgC6015e0A8Fiw4jJ2XZT1IG3jg3aNb3PY5PQFSsNgJuzcKpl+/vDCh
 LAKWRgB4aCpNBkWpPCYrFfn5XT2RYOxwmALuRxFGLba61Uh1Q2Gs6z1TI3kRccP08exZmo23t
 lYfnb8UhU2b9iYRYaUmvH/7KU+HFrWjPWfUIYSbW7vWUSr0k5H6KR0VNwooneW5giGvDoXQ58
 EEPKHro9ADsy2fZ5ZmFZtP2A0l2Svr9BlUmpLwdNEg4r6AHXnehnUOeVrSr1jq51nAEK+TFOK
 SrcxNWOMAlk/hwQFgBcrLoXXkQ1VRjNj7kEZSN/ElR9lDxpYBzrU7Z0gWiBQl7jTEShAsD2rZ
 ybzC29zE84xV6GTkpLtun0CQr6YFHL0T0VAVdPhyOQ0kGJ46wa2u+6oEVWQ/O6c/bwsTQom3F
 uosLUyEvtn3g/OnZfhWYuVPb6ctoXUD6Jn94J5OcC3CtAzRdP2SCEkuqRIK9jEHdPywrt7k8b
 2YTM03shtOAPskkbZpl794TLWU4+qYuNadKVdsc0SXjS0KStPVjtH7o/rrSVU5Ql0JAhQMCtl
 bVE/YVywNMSMZD5ufDU3U4NMfodmtz6r+bd2vWbeLfb/YQrlEzYKzx1AfSPWDcug7Up4fatKl
 7fmR9fO7iaxfzxl+B03wYuwJD7m/xG1DUnm403Or+MrJiC+Lsvudqi2dpgJlbWSTn93kjnqDq
 zUHyxI2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi David,

On Wed, 20 Jul 2016, David Aguilar wrote:

> As-is, the commit itself should probably be amended to contain
> that information [the better explanation].

Definitely. Keep in mind: if this gets merged or cherry-picked elsewhere,
the Pull Request's message is just as lost.

Ciao,
Johannes
