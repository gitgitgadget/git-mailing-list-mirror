Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DE51F858
	for <e@80x24.org>; Wed,  3 Aug 2016 22:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbcHCWIl (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:08:41 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:45034 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757621AbcHCWIh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:08:37 -0400
X-AuditID: 12074411-a1bff70000000932-00-57a26b514181
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DE.C4.02354.15B62A75; Wed,  3 Aug 2016 18:08:17 -0400 (EDT)
Received: from [192.168.69.130] (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M8FfF024079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:08:16 -0400
Subject: Re: [PATCH 0/8] Better heuristics make prettier diffs
To:	git@vger.kernel.org
References: <cover.1470259583.git.mhagger@alum.mit.edu>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <25a06384-e6ac-f774-5bff-65a993345370@alum.mit.edu>
Date:	Thu, 4 Aug 2016 00:08:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1A3MXhRu8OSOukXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4Mp4M/cHY8Ekloop19vYGhiXMXcxcnJICJhIHDj4irGLkYtDSGAro8TVwxegnHNM
	Ei/6D7F0MXJwCAvYSfSeiwVpEBEQl3h7fCY7iC0kYC7xtmMXK0g9s8BdRokt39ezgiTYBHQl
	FvU0M4HYvAL2Eg9vXWcBsVkEVCS23H3GCGKLCoRIbLvZwAZRIyhxcuYTsBpOAQuJq5Nmg/Uy
	C+hJ7Lj+ixXClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzU
	Il1TvdzMEr3UlNJNjJCQFtzBOOOk3CFGAQ5GJR7eDZKLwoVYE8uKK3MPMUpyMCmJ8uakAoX4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8E7JBMrxpiRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGan
	phakFsFkZTg4lCR4t2YBNQoWpaanVqRl5pQgpJk4OEGG8wANPwNSw1tckJhbnJkOkT/FqMux
	4MfttUxCLHn5ealS4rxhIEUCIEUZpXlwc2Cp6BWjONBbwrw2IFU8wDQGN+kV0BImoCUnDBaA
	LClJREhJNTDuXB3palS948ED/QTXJylLPQ3Orlt6e7/gJLPN9xqVp3ltU9+zrn62FGuDucHM
	yAUat8N1ug/3KW9WqbWTCig6vTC/u/mgiWAxy0HJZfOO2+vuTOE5tVnyy1nH2Vc25re+vbxc
	sn+L+e+U0+FBjs1HhJnfftX63/Rb88MFrfjzD+WZp2YZ7J+qxFKckWioxVxUnAgAEnqeHCAD
	AAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 12:00 AM, Michael Haggerty wrote:
> I've talked about this quite a bit on the list already. The idea is to
> improve ugly diffs

I forgot to note that this patch series is also available from my GitHub
account [1] as branch "diff-indent-heuristics".

Also, I will be away from my computer for the next five days, so don't
be insulted if I don't respond promptly to your emails. (Well, actually
I'm never that prompt so people might not even notice :-/ ).

Michael

[1] https://github.com/mhagger/git

