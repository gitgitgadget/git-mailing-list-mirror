Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C85207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755534AbcJLQUe (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:20:34 -0400
Received: from box.datamaskinaggie.xyz ([45.55.255.105]:54969 "EHLO
        box.datamaskinaggie.xyz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbcJLQUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:20:30 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Oct 2016 12:20:30 EDT
Received: from authenticated-user (box.datamaskinaggie.xyz [45.55.255.105])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by box.datamaskinaggie.xyz (Postfix) with ESMTPSA id 06ECA1400D0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 12:05:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidwbrown.name;
        s=mail; t=1476288320;
        bh=Nxn0lTMXoKesqsw0FqwMmHuJXPmgcHir8l/cLZeabUQ=;
        h=Date:From:To:Subject:From;
        b=pHSUxN17E58ZIs8bVapy33n80iiaICMusgD1RPMKN6UvDIZnvRLpcaGMxzYwC/Ik0
         NvdNQqZM94FaTsVn00LfzWUjIzfSinYx+ZmWv0kdMEVIV/YZrpkwWxV9YB8KZj8/JJ
         jybBBCLh0Su+tQeLaVjlzerebAnur9pE/YHRZaL8HaVOeFgJG7K+r0PjOuCrKLSIfv
         sIi7+4Msv8fsovBaMW4nGa1vBz6jRi+9fd9BDJunk6AnexsHERc4ebP16r6UCVom4T
         Mx98iW4vR79M5VGyj0JndILyfbeMdMuuB0zmATo2ztBkCr4CxN0IsxgNcVMg3hrBkJ
         AK8OhdGvsw7xA==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Oct 2016 11:05:19 -0500
From:   David Brown <david@davidwbrown.name>
To:     git@vger.kernel.org
Subject: 2 directories same spelling one directory is camel cased
Message-ID: <e0a3eb0590552c98638d486db8ad4a12@davidwbrown.name>
X-Sender: david@davidwbrown.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Howdy git gurus,

I have the dubious distinction of working with a remote repo (master) 
that has a class loader run-time error when cloned, built and executed.

The reason for the runtime issue is a directory hierarchical path has to 
directories (folders) with the same name spelling but one of the 
directories is camel-cased. The package names are the same.

The compiler doesn't care but the run-time class loader has an issue 
with the 2 'same like named' classes.

How to remove the offending directories and files at the locally cloned 
repo but not push 'deleted' directories and files back to origin/master 
the remote repo?

Please advise.

Regards.
