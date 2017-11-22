Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67C320954
	for <e@80x24.org>; Wed, 22 Nov 2017 14:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdKVO4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 09:56:40 -0500
Received: from mout.web.de ([212.227.17.11]:63846 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdKVO4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 09:56:39 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LmcnP-1eqrT80ILb-00aFAC; Wed, 22
 Nov 2017 15:56:33 +0100
Date:   Wed, 22 Nov 2017 15:56:32 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vladimir Nikishkin <lockywolf@gmail.com>, git@vger.kernel.org
Subject: Re: core.safecrlf warning is confusing[improvement suggestion?]
Message-ID: <20171122145632.GA22931@tor.lan>
References: <CA+A2iZaLZCMvyb3nbcn=ofVGAPeW2_wRhjOeRRu5q01LuV++Gw@mail.gmail.com>
 <20171121161824.GA13548@tor.lan>
 <xmqqine3xea5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqine3xea5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:Az7eWfi4D4zO9uOwYXY0VcmrbMo1Y29aY9oH/J6qnOAiQWCUl5P
 RVykdYETQQ0zThKVkXIjY+ozUK1ZiKTB6ZqZoVpfCLv029vSeQT1yL4zVsMz4GCJZBlHHCO
 Qi310G+bVq5V203c0N6eRub6FtHXkLl68GSmVtarAwfuWDv217J23rNt2nCkqia6ldV2B0W
 PX+4Vn/2l43wW7HrJ9M/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YJ3kumSeeec=:E9XJbaZAl+3Md68Ei9+bzt
 Ko6WarkOxfdqOXvb9UWhKGVlgqZecXJNfOufPdGEYPZgAWJesJur1ImovqC+mHr1qKzcW3qzT
 wHQbYlBX/E4qQeh+jdMQwFKBC3vbEr268WOL1fD/WNeedV+JUBbeOMPMhBXcS+dn2jnPfhjhR
 HsPfXrQ2H029isX53uBsbDUKYWUfAwgCuBsHmztaoZTwc9sB7ePyPLtz12PqVyU/VAM8y4YIA
 q+nAJVXytXeA7RM3x7w+HbIxT13hzVHN7FMJWU8y8krzobt2Zl7Klr1n1U6JdyH5Eh5uN+BdQ
 qIftUl471ok58Zo0apg6iX/k+GVZlKLCBtGjsCQSR1kvLwWpfKOqT4uAP+8mcMd367RVBx4br
 39BZrdOcz2iXBzrgoeWbp8oTIQ35RL3B2WHemUa503okq8gOdeRfa8v3XYNrwOG5yLOlQGvgr
 2xaFTiA3sIt5rt10IyfQ3BQ7NPXxpOf8VgdrHJHeXdSyOOin21fzcG7SJiO86PYaqMaHglmGT
 uVAf8nDQOXaZzNafts8IeDbJXA1wcpAtqkQVDM/w4d0WHTxVSdvrkMqGyvuhv1R77sifBXQnj
 0Jmg/cF5XiCmNNSoJFWwbR0sBgvenH50Q25GZFfks21tmywV2kTk7levvFIT+xDAFt9zygdPl
 CS8uJyRzfWPnvqDHZAetJKTM4Pzausga0qwyzs6OfSKQciNdx1kJP/2DUl6K9KxK6x9o0rnoj
 6dxH94GMMOFyfAt12nMUOEckIvW3dpzNOYHuepKtA0YO5KwOURLhtSMl6XLtFTEVxlQoKYvZH
 s9ZfVy9Q84OlxI+HjfqKjCypighXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 11:01:22AM +0900, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> >> I want to have LF line endings in the repository and CRLF endings in
> >> the working copy. (Because I use windows-exclusive tools to develop.)
> >
> > Side note: If you ever want to push your repository somewhere,
> > it would be good practice to have a .gitattributes file:
> > ...
> 
> Now we got your attention ;-)
> 
> What would be the BCP we would give if somebody has just a tarball
> without .git that has LF endings?
> 
>     $ git init a-project
>     $ cd a-project
>     $ tar xf ../a-project.tar
>     $ git add .
>     $ git commit -m 'Initial import'

There is room for small improvements:
     $ cd /tmp
     $ git init a-project
     $ cd a-project
     $ tar xf ../a-project.tar
     $ git -c core.autocrlf=false add .
     $ git commit -m 'Initial import'
     # Make up your mind: is it truly cross-platform ?
       $ echo "* text=auto" >.gitattributes
       # E.g. if you have shell scripts:
       $ echo "*.sh text eol=lf" >>.gitattributes
       # E.g. if you are a git developer:
       $ echo "/GIT-VERSION-GEN eol=lf" >>.gitattributes   
      # Or, is it e.g. a project where a tool needs some line endings
      # visual studio is one example, there are many others:
       $ echo "* -text" >.gitattributes
      # in any case, we need to commit: 
      $ git add .gitattributes && git commit -m "Add .gitattributes"

# Now we have the repo. I we don't want the hammer, simply clone it:
     $ cd $HOME
     $ git clone /tmp/a-project

That should work for project small enough not to fill the disk.
And other adjustments may be needed to the .gitattributes file.
A final check with
$ git ls-files --eol
may give inspiration.

> 
> would achieve one half of the original wish (i.e. "I want to end up
> with repository data in LF eol"); disabling the "safe crlf" before
> running that "git add ." step may also not be a bad idea, because it
> reduces the number of things that can get in the way by one.
> 
> But the above also leaves the "working tree" files in LF eol
> (i.e. it goes against "I want to work with CRLF in my working
> tree").  What would be our recommendation?
> 
> One big-hammer way I can think of is
> 
>     $ git rm -f .
>     $ git reset --hard
> 
> and that actually may be a good enough solution, given that you'd be
> doing this just once at the beginning of "your" project that starts
> from an inherited code drop.
