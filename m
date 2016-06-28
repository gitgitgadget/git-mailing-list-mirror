Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B451FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbcF1IEY (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:04:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53930 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbcF1IEV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 04:04:21 -0400
Received: from pflsmail.localdomain ([37.123.123.67]) by
 mrelayeu.kundenserver.de (mreue104) with ESMTPSA (Nemesis) id
 0Mddka-1azBBW1aSC-00PNuj; Tue, 28 Jun 2016 10:04:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by pflsmail.localdomain (Postfix) with ESMTP id 182CAB0172E;
	Tue, 28 Jun 2016 10:04:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pflsmail.corp.cetitec.com
Received: from pflsmail.localdomain ([127.0.0.1])
	by localhost (pflsmail.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKkYY-kObAOK; Tue, 28 Jun 2016 10:03:59 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
	by pflsmail.localdomain (Postfix) with ESMTPS id CFFB2B016DF;
	Tue, 28 Jun 2016 10:03:58 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.11.230) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.847.32; Tue, 28 Jun 2016 10:03:40 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)	id
 19DCD804B0; Tue, 28 Jun 2016 10:03:40 +0200 (CEST)
Date:	Tue, 28 Jun 2016 10:03:40 +0200
From:	Alex Riesen <alexander.riesen@cetitec.com>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
CC:	<git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Ensure the file in the diff pane is always in the
 list of selected files
Message-ID: <20160628080340.GA3710@pflmari>
Reply-To: Alex Riesen <alexander.riesen@cetitec.com>
References: <20160627132137.GC4194@pflmari>
 <20160627132308.GD4194@pflmari>
 <57716329.8000809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <57716329.8000809@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.10.11.230]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-Antivirus: avast! (VPS 160627-1, 27.06.2016), Outbound message
X-Antivirus-Status: Clean
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:PeEIsZtVbiCnT0RfN6/d9dZov435BmeynF1Mm0DExA4hdl8qTen
 aYgPaRlHiDkmHwbKRpmT+keLMMMkMKD5nfPNOBIeiegpuah/QXPfPPxU7ID3ZVYCi8UtQod
 TrStyCq8hOfaHkICkaI+1kXm1NmHCRu3igMTYjJwLZMLLI3HFTRsuMFlCZDq+Phau4WOXm2
 7uGqiyFeudJjuy5huqj+w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:yNG8lc9d5jQ=:AtbPpM7qHGc4gmK+YUlO9U
 Pd8oWHHCIQUeL5I3JBYHSeghdY+SMcPeFWvjMdhiZcOQ+dF1OHZE+QkVh1hrNcib2jAVPF+na
 IVbGN0rS7F3wA4pR75ju/GZj312O5Rg0ZQMHzJka0lwOpTVX0VhNAYozgJlDZVNvnJzkKxsRx
 0Es2tu7i/soDjjdkWHCjxYeoRY7Vvfz5kW5gMJT+7qIzFd+d0M1UwysdslQVyarLEys3t6Dyz
 XE4CEt8XZ0w+CWr+Nyv/PTccM9heaBoQTkKp7a3gTuOSKMAK4scCsNpBJKujoPUfUpLAiMqWn
 AbMk87W34p4uv48lnlRnyKVi6OC6iKnP6gWl5tZW8cetup8az9SPeihxF7rmt6q3lWPMUiBKX
 CyHsgdiHHjZVu+URtZPu8t0uzBNq+Cy9Hi1nH4OgTzCGK1HgBaRlPYFrSnbHP9zH0w5wSLy8x
 +Fm2j8OpwRvlpVc6mdWgmgNNsIR8yDYp9iMB22DKByc7ajHNNkbO81Y11H6VE1kB3XXATDRi+
 DCE5cjqM6xGlJOZSJqCKtrUD4CmlpaTlwkLeK4ZDyoBsNGe8f9I7O12GHvlm19VYbSFVko8Q6
 b/S/q2410y8il8mWM0xO+Flev/cfws08m5DgR7wrOfgkR2jx18YALuNYooG4NIWLyRJC+RT6n
 hrQp3rnxLhIm5J9i4DX+UepP0sgAuHSEdYdr9Sko70DZrIt48IVE8uSQxpYVEbDJXB/g=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski, Mon, Jun 27, 2016 19:32:25 +0200:
> W dniu 2016-06-27 o 15:23, Alex Riesen pisze:
> > It is very confusing that the file, diff of which is displayed and which is
> > marked as selected in the file list, is not, in fact, selected. I.e. the array
> > of selected files does not contain an entry for it.
> > 
> > Fixing this also improves the use of $FILENAMES in custom defined tools: one
> > does not have to click the file in the list to make it selected.
> 
> Could you improve the readability of the commit message, please? Perhaps
> something like the following:
> 
>   It is very confusing that the file which diff is displayed is marked as
>   selected, but it is not in fact selected (that means the array of selected
>   files does not include the file in question).
> 
>   ...
> 
> This patch lacks sign-off.
> 

Done. Also the prefix.


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

