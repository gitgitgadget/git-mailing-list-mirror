Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B3C2021E
	for <e@80x24.org>; Sat,  5 Nov 2016 09:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbcKEJvC (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 05:51:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:53650 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbcKEJvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 05:51:01 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M8NWM-1cpqzL3kDC-00vy6X; Sat, 05 Nov 2016 10:50:57
 +0100
Date:   Sat, 5 Nov 2016 10:50:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
Message-ID: <alpine.DEB.2.20.1611051025030.3108@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LaO/82FOW2HyqRcMTYt0gvqXvvYntt1XOvRtcSi+i+RSmsFzBKV
 6wXrKXI3iE35w3EaXYp7LVmZHHwEkA+CNiAFA8RBI2k4+gwIZlmRv6w3EHfRgn4528wWHf0
 JqQ1P1O+4bh+5S7pFW43MDKULVwogD9hCSd+1XomlqlTVta5hk3pmnJinRUd8WwAFCKAaF+
 KjSd8vvA9tasuR6k7HEuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UcvTFv9y4cE=:WCoUjhrSt4hmaDvEccArW3
 ZWIHWdH1A1xeIhPQHiT24tF5l1EVLVaAtZbZzRMJ2ajQsYARWvfS+0NC2Kh59BEpTjEPVRHYa
 2u3aWG11z6zv0OiFuKeVqIc48UoIhFQrnU4gSN/LP8vb7VeCuQqGLlFcJg2LGcwkniGJTiJnt
 ztVmST1bOGbZ1NFNHinIFxM+W2w1WslnXLfKIJGShWKuWoh3MZT9Tch+HGK+LLEXten95MnlC
 bAI09nd//CfwUDp8HWe2ijARZysiTnfSjRbaIAp8+Ce6v4KHdE4TYC9wkrDaWaKl8CcTufkhn
 RdKxdieRzHzhmzBHAFNEdEdGFom3EbNo0COSBXhKye+COJO+XOg0HEgz2ozhS7MBLJi4IcT95
 MFrDTIXLbDur6luoeR24/2zztLLF0vtN6AT1uxwLkD/tms/l/JH62sgndQhF5mAfO+txAfNgB
 5dUZCmGgVtPSyZ+gWLsbinObQsV8aO+8SJj1dO4eb/1XuYQgNJ/o7NmZezHsmhVzKmjJKaFab
 QABMk2wiJ8+s23+d7E21LlE+Do4d8V4awgWB1xgbHx222XDFKcOfqWDAr12UC0/hEZ23pQhDJ
 GqkKa/SE9zvfnR+q0AJb9iJpwjsgMNYkbrDFiQ93r2Xeu5bobqGRDzadrk9lW59HHEZGvdVRp
 1LPDCTQjzLcbHT8smIx88nwQQyO1UBE2axncmvkiIukdVsRw79ri9kDDR2d3snNTfJfz0Rd44
 R4TQ7WF+EDsH+u1kqnTVVvF2XdGmSZRRQnX/cdRdzTyAznP+2p4F1AoKnaZo0x/uM22pT19jb
 C6lWo6P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I finally got around to rebase the Windows-specific patches (which seem to
not make it upstream as fast as we get new ones) on top of upstream Git
v2.11.0-rc0, and to bundle installers, portable Git and MinGit [*1*]:

https://github.com/git-for-windows/git/releases/tag/v2.11.0-rc0.windows.1

It would be really nice if those of you who have access to Windows [*2*]
could try it out and report bugs before v2.11.0 final.

Thanks,
Johannes

Footnote *1*: https://github.com/git-for-windows/git/wiki/MinGit

Footnote *2*: You can get free (time-limited) VMs running Windows here:
http://dev.modern.ie/tools/vms/windows/
