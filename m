Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147BA1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 21:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfBLVnS (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 16:43:18 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:57394 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727762AbfBLVnR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 16:43:17 -0500
Received: from DESKTOP-E4U7JCE ([158.148.89.66])
        by smtp-36.iol.local with ESMTPA
        id tfphgNFbbfi5YtfphgGdh0; Tue, 12 Feb 2019 22:43:14 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1550007794; bh=enuQksNp3+a8Ngya/4zLV0Qj+8YY0TfcUMOUt6D8Ass=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ex4thGRZIQfR8VMp+sErixWh5nmzk4cEQeK2F46iC4eHYtq0x78XXfa44vWR9HCKr
         N8aW5KdcywBsccgvL+jenWdhChgJqnhMatM+UQQG7SNZxDvx1wehzzUnhwCmImjE9m
         QMB9dQj3dgmqa4WZMF1PderFJg197F0ReIsQ/9J1jK5S6UdDqShfAHpstJ2evc7ucO
         Yqe7laSjV+NssMGO06eKIjjeielB0WL9enzoKEclKpsxVgfObofWtz8/T1HRgiSV5Y
         A1GrmIu+d495/C0VYkAIqXFQBBOKiTHhDVCAIki67YkRUStMDm0rbMsJndAFUFB4/m
         NGa5UO/CMiwAA==
X-CNFS-Analysis: v=2.3 cv=R+jS5uZX c=1 sm=1 tr=0
 a=z0TJ0MiZAR6WNZLDJPbulQ==:117 a=z0TJ0MiZAR6WNZLDJPbulQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=E5r6RD504_JoPpGtvtsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <1550007793.1750.1.camel@libero.it>
Subject: Re: Am a newby and I cannot compile git
From:   Fabio Aiuto <polinice83@libero.it>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Date:   Tue, 12 Feb 2019 22:43:13 +0100
In-Reply-To: <1549912081.1754.1.camel@libero.it>
References: <1549835814.5977.11.camel@libero.it>
         <20190210224812.wtn2qqm7lmsiarrh@LykOS.localdomain>
         <1549912081.1754.1.camel@libero.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNTaNae2Weh4TF0Pxoxl8SkFhy63o3SbXoGPe8jpPjWsFh6OWkB1jRRk70AbXrrNiB8zdCJ6fjJRjl1DT/9IoS2Ml5rSYRVdE8uMqw400NEcXWX4dmxp
 1nUd3JogCSJfSp4tOdaBhkiU0byMDGeUql7cFx7PYvZlP415eZNlSfpRsVhA3BXszXzeZkD/6LYZMEM+jTH0JXYHZfDc02Nq/qg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok I typed make install from the terminal, then I attached the the
project to the executable generated in the local bin directory. So I
can happily trace in the code. Thank you, hope I will be able to fix
things in git very soon!!!
Fabio.
Il giorno lun, 11/02/2019 alle 20.08 +0100, Fabio Aiuto ha scritto:
> Hello Santiago,
> I'm running debian Stretch on my machine, and using Eclipse. I'm new
> in
> linux world so I don't know how could I let you know all packages
> I've
> installed in a single screenshot.
> However I got the git sources with the following command:
> 
> $ git clone git://git.kernel.org/pub/scm/git/git.git
> 
> then I've opened the project inside Eclipse by importing a makefile
> project from existing code. I tried to build several time beacuse of
> some compilation errors that I fixed by installing the following
> packages:
> 
> $ sudo apt-get install zlib1g-dev
> $ sudo apt-get install libcurl-dev
> $ sudo apt-get install libcurl4-openssl-dev
> $ sudo apt-get install libexpat1-dev
> 
> At last no building errors detected but when I try to run adebug
> session, the IDE says tat 'Program file does not exist'. And there
> are
> more errors spread over the project wich are not detected.When i do
> the
> rebuild by clicking the 'hammer' icon, the message in the console
> window says:
> 20:04:07 **** Incremental Build of configuration Default for project
> git ****
> make all 
>     SUBDIR git-gui
>     SUBDIR gitk-git
>     SUBDIR templates
> 
> 20:04:08 Build Finished (took 866ms)
> 
> Please ask me for more informations!!!!
> Thank you
> Il giorno dom, 10/02/2019 alle 17.48 -0500, Santiago Torres ha
> scritto:
> > It'd be difficult to debug without more context:
> > 
> > Do you mind sharing your build log and more informationa about your
> > setup? (e.g., what OS are you running, what packages are installed,
> > how
> > did you get the git sources, etc.)
> > 
> > Thanks,
> > -Santiago.
> > 
> > On Sun, Feb 10, 2019 at 10:56:54PM +0100, Fabio Aiuto wrote:
> > > Hello again my problem is that I cannot compile git.
> > > The error message says:
> > > 
> > > 	Type'z_stream' could not be resolved
> > > 
> > > I don't know why, because I installed the package zlib1g-dev and
> > > in
> > > the
> > > header file zlib.h this structure is declared. Help me!!!
> > > Fabio.
