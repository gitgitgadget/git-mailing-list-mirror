Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6676420899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbdHWTnT (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:43:19 -0400
Received: from mout.web.de ([212.227.15.3]:60794 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932407AbdHWTnS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:43:18 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAvFE-1dsLKa0BGO-00A2Gu; Wed, 23
 Aug 2017 21:43:16 +0200
Date:   Wed, 23 Aug 2017 21:43:15 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cannot checkout after setting the eol attribute
Message-ID: <20170823194315.GA29237@tor.lan>
References: <20170822174918.GA1005@megas.kitware.com>
 <20170822191318.GA22118@tor.lan>
 <20170822194441.GA25093@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170822194441.GA25093@megas.kitware.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:GilPnscy1vmbSNwQC+QwIDYAK4VgbmyzDMqH1dr56mZBuTi1oKL
 bg3qdniiW5liPtuLgCpYjyY8Gp8MChcTyjkiGfUWbSbC4B6167GT8IiwmUsoIT+Q694bACA
 Y4c775BovNLMmoIQaFdW0uXQi/RV4JXSyMFId0e1ZVJcz0b51fxo6rwrZVQQzkOj3igp4tE
 9DgpgHhUBljvZs3vjad6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EwHyqhYJNLs=:kzKhfZ3EcISiTJDmIeMcT6
 gBUjRbq4bFXbZsb2sBZTa9j4VdXUzmHEbTJEa8gUBOmZR1Iaie3TnG2MuvTtBOU0EsCCwjFE2
 PReHixhl6Q3/z34dG5PW2hS5A8BWhExm7Xyot1sg26a/QWook0XCqBBdPC290wCHjNRWi42Vg
 DpLNaLR5q8w7tCJdgOLG39Zsv3bPjNHhcc5UhmqI1DsK3d6/TZaRsglCyHjJ5+MdERhTdNBat
 xirjLHshQHFvCfKtRrybCL1iIV1LBeEir2XLTKKznu9FqCnhPBRXKNRxGPT56+iiPuj5SqRSm
 TmImidCXD0ZMnc73XNfosPn5ew+DSnEMvoKWjvWtVo/O8KN89DZminCtF7GgFPek669RP10nP
 XYbOTBML4El+zrsSBC5p0OauHx32d1rmXsOHvpgYZmdHzb84LlpYi4Wol4QVFRh/WsBlbvga2
 5MZn0gBvThVvypJdjZPb8zuEvhb+GbftrlOGiX/LfnYmlrQk7mFXeWXbspPg7SBsj8fDKM6X6
 o2jhGRouAS/ptCKfzaj4mNM3aJyvyn2S5iJDEr1e/PZznTr+xGd/YNoP/OY1bkg+KFYTBOvdq
 5y+UfGsgHP2FYWVmxKr7itJdYM4K3IvDV+RPbhwT3arBW9xNn1K3fwJB+kxiR9TyrUSwgnlN0
 /5AvNmOLCMjbEtlz303kReZXcBh1HDdi+EUK7LEPNHEgwtEVHevWDl4L2d/s319/L7xl+uS5o
 BxCIYrQkgpW7+viga/S6Gg9LoDBGKscdfL7wfZw8i7hvDzS12MxJPOZuNUQXFBT3dAIXt0yxT
 6Cdz3R+aorvpgW334Kr/SzYOEU9Tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 03:44:41PM -0400, Ben Boeckel wrote:
> On Tue, Aug 22, 2017 at 21:13:18 +0200, Torsten Bögershausen wrote:
> > When you set the text attribute (in your case "eol=crlf" implies text)
> > then the file(s) -must- be nomalized and commited so that they have LF
> > in the repo (technically speaking the index)
> 
> This seems like a special case that Git could detect and message about
> somehow.
> 
> > This is what is written about the "eol=crlf" attribute:
> > 	This setting forces Git to normalize line endings for this
> > 	file on checkin and convert them to CRLF when the file is
> > 	checked out.
> > And this is what is implemented in Git.
> 
> Yeah, I read the docs, but the oddities of reset not doing its job
> wasn't clear from this sentence :) .

git reset does it's job - please see below.

The problem is that we need a "git commit" here.
After applying .gitattributes, it may be neccessary to "normalize" the
files. If there is something in the documentation, that can be
improved, please let us know.

> 
> > Long story short:
> > 
> > The following would solve your problem:
> >    git init
> >    echo $'dos\r' > dos
> >    git add dos
> >    git commit -m "dos newlines"
> >    echo "dos -crlf" > .gitattributes
> >    git add .gitattributes
> >    git commit -m "add attributes"
> >    echo "dos eol=crlf" > .gitattributes
> >    git read-tree --empty   # Clean index, force re-scan of working directory
> 
> The fact that plumbing is necessary to dig yourself out of a hole of the
> `eol` attribute changes points to something needing to be changed, even
> if it's only documentation. Could Git detect this and message about it
> somehow when `git reset` cannot fix the working tree?

The thing is, that the working tree is "in a good state":
We want "dos" with CRLF, and that is what we have.
There is nothing that can be improved in the working tree.
What needs to be fixed, is the index. And that needs to be done with
"git add" "git commit."
As Junio pointed out, the read-tree is not ideal
(to fix a single file in a possible dirty working tree)

In your case it looks like this:

    echo "dos eol=crlf" > .gitattributes
    git add .gitattributes &&
    git rm --cached dos && git add dos &&
    git commit


> Or maybe it could at least exit with failure instead of success?

I don't know.
It -may- be possible to add a warning in "git reset".
I can have a look at that...

