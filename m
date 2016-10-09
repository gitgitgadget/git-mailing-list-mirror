Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D304520986
	for <e@80x24.org>; Sun,  9 Oct 2016 10:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbcJIK1N (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 06:27:13 -0400
Received: from mout.web.de ([212.227.17.11]:58679 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbcJIK1M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 06:27:12 -0400
Received: from [192.168.209.54] ([195.252.60.88]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LlWKh-1bKwpf2CpD-00bL4H; Sun, 09 Oct 2016 12:27:08
 +0200
Subject: Re: A head scratcher, clone results in modified files (tested linux
 and cygwin) - .gitattributes file?
To:     git@vger.kernel.org, jpyeron@pdinc.us
References: <7E06D61EACFB462AB96DD60720930968@black7>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <c9c90c24-3bf7-cd57-cad6-db28db16f323@web.de>
Date:   Sun, 9 Oct 2016 12:27:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <7E06D61EACFB462AB96DD60720930968@black7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8K7eijiZcnUqtWAZ5/TnFSf0iZ8l8X8khbfZdwHUWl+M+k0gRBU
 DsbOA9LHK7+8e45MjqhfgH9Yk/IcZk5xVCPsHXP5FnWvqNeeBWe/ju+TkfoxvGuGp55GJJM
 1NK0gOdNb3XUEXa4aJmE4sGbi6IUKejkKRFGInJPE7+vzRcGb8l8COv3p5Z6yhPk6UErkeM
 HlVZ91369/MDNHth2ydIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LD6TzQ85dV0=:ZcO4REHafm2vSDiNINw3je
 GuZffEgmmx4oVop/S6qbxmE/79PxpHFVeoCfZjbIPp36EZra197FW2pWW6eNWG3ATuylngtql
 6utdUF9MWLb/o3cAt6cQNitruA42Txx5Mu5OCGRL1ISSdFS2fl2upPLfLoCYYYPE6Xa2zZ4PJ
 XoMNtjdlf7bIq7HoTVKnwdQ0ragk9LJAsiDDz4lotO41lyvMke2h4oocjxcdx4mzogTYaUtgW
 osX7349vWgiQVlLFUFgRd85j5js1Y6UCy3DArWzRDVkXdOb3WXDDtTeE3iN4Oumxb9YA9ak2N
 GIrmXbYhwatR6zNc9LqebftKNxOF2fss8xrw0M0p3l3BhzX+QiuhbsEsJX09wQrtprLhLA0xN
 z62p+y+qG3uENk972jDdB7AXAEzS4p2rpHYMNxsxIpa7EQ80p0R/O8CsyEl/BdjzQyPb22zjQ
 lS3ZKe922939+Dc0PcwCoYffYJLIWpNOLd5HliTx7kqHgCwzH9YtA0AuBRKK3fsQ5ixhuRD+6
 GTAUewPvAcD2EzEE++x4Fkrr9MSccMGDP5pE556b2grX3og9qXnXSNKLSibaZ5Arq+8hmIuOZ
 sNcxCeNDiogN6UZYG878/uyTavYJN/Ki4l7jK7xu33Hj2HFpOg2h6n6b5uzArTD5S5Rp9kM3Y
 HLoa5tey/mHkHjrN+J6LmvwOa/g+XDR2z11XNmtNYEbPzSNL+cIw/prdqQVxB0mEXM6xlE8uE
 tiBrwk52cnCpcZw7mXD00nz0CitgSmxhVX7WznMkd4c7mdrpuAOVBw7Mh1R0MPEsQwh8olIHh
 EHoP6Qc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 09/10/16 08:48, Jason Pyeron wrote:


The whole .gitattributes needs to be adopted, I think

Git 2.10 or higher has "git ls-files --eol":

git ls-files --eol   | grep "i/crlf.*auto"
i/crlf  w/crlf  attr/text=auto src/site/xdoc/upgradeto2_3.xml
i/crlf  w/crlf  attr/text=auto 
src/test/resources/org/apache/commons/io/FileUtilsTestDataCRLF.dat
i/crlf  w/crlf  attr/text=auto src/test/resources/test-file-gbk.bin
i/crlf  w/crlf  attr/text=auto 
src/test/resources/test-file-iso8859-1-shortlines-win-linebr.bin
i/crlf  w/crlf  attr/text=auto src/test/resources/test-file-utf8-win-linebr.bin
i/crlf  w/crlf  attr/text=auto src/test/resources/test-file-windows-31j.bin
i/crlf  w/crlf  attr/text=auto src/test/resources/test-file-x-windows-949.bin
i/crlf  w/crlf  attr/text=auto src/test/resources/test-file-x-windows-950.bin
############
Problem:
xml file had been commited  with CRLF : either normalize it or declare "-text".

The same is valid for the other files as well.
They are identified by auto as text, and commited with CRLF.
My feeling is that they should be declared as "-text".
Or, to be more compatible, with "-crlf":

Solution:
Make up your mind about the xml file and the html files.
If they are text, they need to be normalized.


Question:
What happens, if you do this:
# Auto detect text files and perform LF normalization
*        crlf=auto

*.bin    -crlf
*.dat    -crlf
*.java   crlf diff=java
*.html   crlf diff=html
*.css    crlf
*.js     crlf
*.sql    crlf



