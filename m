Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9461F453
	for <e@80x24.org>; Mon, 11 Feb 2019 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfBKTIF (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 14:08:05 -0500
Received: from smtp-35.italiaonline.it ([213.209.10.35]:44841 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387552AbfBKTIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 14:08:05 -0500
Received: from DESKTOP-E4U7JCE ([158.148.65.95])
        by smtp-35.iol.local with ESMTPA
        id tGvxgGzLNYe7jtGvxg7xqO; Mon, 11 Feb 2019 20:08:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1549912082; bh=OIo/6GRNWDNVd2pUC0iyyXEoXhB2ZjW7jjTzsXgPpc8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=q5gxpWpO8TfWoSPdFUU5qHa1YcoFdjDaBSfOrklIVN5+gA67HEskSARGZfbEO22S7
         YisUsLBBc9+q+R8dFk6HQ2LCDmYNsgnTojGaNN3D+dkRG9L0UbWL8dF/CA7FpeZFsm
         SEDI9xrywNzRCI00WV5U06kN1BOelC84/t9eoJIvTiSGniwYPhCvHZ/r6FvbulyXUD
         +6TAeTcj5CI3RwY5Gc6vqNbGmgqujUMxRZsluM00jGDIeJnPQva1FgZW0697N69PQW
         dcHB4oediGWQpEhcpQE5LE4DHa40jtY6WOsSMNywhv01vRBEkfFcGYa7lEKZyDYD/C
         QIc3NYd+HzlTw==
X-CNFS-Analysis: v=2.3 cv=ea/sgIMH c=1 sm=1 tr=0
 a=mYoHSx74mx067AUk1qnVOw==:117 a=mYoHSx74mx067AUk1qnVOw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=CYsI3UzIqvDnqZrUaXsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <1549912081.1754.1.camel@libero.it>
Subject: Re: Am a newby and I cannot compile git
From:   Fabio Aiuto <polinice83@libero.it>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Date:   Mon, 11 Feb 2019 20:08:01 +0100
In-Reply-To: <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
References: <1549835814.5977.11.camel@libero.it>
         <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPDL6RhyHiOd/B1sd3jKPpJGP3DUIwfIXQ/Y8NFQli35GBTM2jX1gmwvoGecVGgeayOA19QkeLVOjDaRcOD5Xwf+c5kc0nT+rApouhEk1HbII6jqXEx4
 nlKpekJ73LsOVBJJY7gI30/yH0YpnhOmyjNFsz3egasUDQBlMeLdV8NDV0KeyEVXKLuolcz8Q8TUc+2mNsnoHCuKRfBuTyt2Sq0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Santiago,
I'm running debian Stretch on my machine, and using Eclipse. I'm new in
linux world so I don't know how could I let you know all packages I've
installed in a single screenshot.
However I got the git sources with the following command:

$ git clone git://git.kernel.org/pub/scm/git/git.git

then I've opened the project inside Eclipse by importing a makefile
project from existing code. I tried to build several time beacuse of
some compilation errors that I fixed by installing the following
packages:

$ sudo apt-get install zlib1g-dev
$ sudo apt-get install libcurl-dev
$ sudo apt-get install libcurl4-openssl-dev
$ sudo apt-get install libexpat1-dev

At last no building errors detected but when I try to run adebug
session, the IDE says tat 'Program file does not exist'. And there are
more errors spread over the project wich are not detected.When i do the
rebuild by clicking the 'hammer' icon, the message in the console
window says:
20:04:07 **** Incremental Build of configuration Default for project
git ****
make all 
    SUBDIR git-gui
    SUBDIR gitk-git
    SUBDIR templates

20:04:08 Build Finished (took 866ms)

Please ask me for more informations!!!!
Thank you
Il giorno dom, 10/02/2019 alle 17.48 -0500, Santiago Torres ha scritto:
> It'd be difficult to debug without more context:
> 
> Do you mind sharing your build log and more informationa about your
> setup? (e.g., what OS are you running, what packages are installed,
> how
> did you get the git sources, etc.)
> 
> Thanks,
> -Santiago.
> 
> On Sun, Feb 10, 2019 at 10:56:54PM +0100, Fabio Aiuto wrote:
> > Hello again my problem is that I cannot compile git.
> > The error message says:
> > 
> > 	Type'z_stream' could not be resolved
> > 
> > I don't know why, because I installed the package zlib1g-dev and in
> > the
> > header file zlib.h this structure is declared. Help me!!!
> > Fabio.
