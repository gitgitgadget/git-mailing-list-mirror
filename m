Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345B91FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdJ0PSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:18:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:63929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbdJ0PSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:18:49 -0400
Received: from virtualbox ([2.247.243.12]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9NE-1dyF320tci-00GW1b; Fri, 27
 Oct 2017 17:18:44 +0200
Date:   Fri, 27 Oct 2017 17:18:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: Consequences of CRLF in index?
In-Reply-To: <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710271716330.6482@virtualbox>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com> <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org> <alpine.DEB.2.21.1.1710251415040.6482@virtualbox> <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org> <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dUAUsOnFfDHklGDhbg1fei+2EqPSDKnjzGrHARvHM7Okf6pSbVH
 ajbuSdBA9LMApD3jc0HOX+g7cDnVMwjSL37u+VCod2fWsAEL0Lsr3/giDGq1EtXWajGoKSK
 An0XJaJElCU0eRwhGnlNahe6G1baDd55oBx+KzzhSf3GUtKocEhBMN+oPIJGSFTSNsgqy7B
 vzSqqm9yWoNH15q6LDe/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j2TXNPfK80Q=:/DKTUnAiLkvYZKLEtpZOkg
 z0Q4vjOVhrwd7eNiPN1sA/PQG6gL1MyfsOWSmtH9XzbU3T1wPziEmovsuSb9rL3EJRBxJBt7m
 6W+8mGwY349LOu9P8c89uZdBqrorrLrTGcnHOX86Uc8yxepwDhuWuSbf2ip/p78nwEJB/AoGn
 I5X7KcPkKdDwFNBiVZmLgBC3uWHHrvEL63vmIijF3tU0DmCNfbGdgD3pCnqV6xy21va9XqAS/
 DouG3RMSbyMkl+VClKEl69XxXs252hcQpRHQ5ScstQ9gnOFgHQHWpP7u5wQxmjTZQjeIuKtjk
 G6h1GM7EZ4L++BzyNG72yWkt9h3QX+cXt+jaY8iS2N1tM1/mS+puF/TRDExs7F9osieANXzfq
 h5NOLxab86tiM3G9UT9yDca46FpRF+5vCM/gIwYuGWRW9/w6sFMj94ga7WR05SmG1qr+1dFuB
 TkG5SDndNatc9ED5iO/nZHVE+YTWDyApKcSHYLrJ9LX6IwLLg5VsMBZ9XFoZWLObewKlVNpu3
 p+vbkFLKuNBdP45sXsiqrqPFA7Ma/1vxlfwZpGYYKYnF8A3v15Z0A9uogNr0jGQD6Y9afp/gI
 G6aU+cYAHIAJNsf7FspBSFe7HrnvbZnx9ozC8lHnaJbVI31lX4X27DDDlYWaFG8Oki10WRGNm
 zpaeYf3O4KHhM2wJSsmBHxZmEforiPdy1QZM8hAdqq76zYwmXiBNeCUV7OAc3PxNG/AWWk21e
 QjLEx5YgbhGfpk5JAFrjGnU6xvFdm+v9DJ04KHQxQPOtdYOYKwSNHrftl0Ik0LMDm005YdEwN
 B97XluxFAotny+JuJN1AjsS/2V+1SE442ciq8wZ/z0TnHNiRYg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Thu, 26 Oct 2017, Lars Schneider wrote:

> > On 26 Oct 2017, at 09:09, Johannes Sixt <j6t@kdbg.org> wrote:
> > 
> > Am 25.10.2017 um 14:19 schrieb Johannes Schindelin:
> >> I envy you for the blessing of such a clean C++ source that you do not
> >> have any, say, Unix shell script in it. Try this, and weep:
> >> 	$ printf 'echo \\\r\n\t123\r\n' >a1
> >> 	$ sh a1
> >> 	a1: 2: a1: 123: not found
> > 
> > I was bitten by that, too. For this reason, I ensure that shell
> > scripts and Makefiles begin their life on Linux. Fortunately, modern
> > editors on Windows, includ^Wand vi, do not force CRLF line breaks, and

                        ^^^^^^^^^^^^^^

This put a well-needed smile on my face. Thanks.

> > such files can be edited on Windows, too.
> 
> Wouldn't this kind of .gitattributes setup solve the problem?
> 
> *     -text
> *.sh   text eol=lf

If you look at the commit I mentioned, you will see examples where it
breaks down: when using Unix shell scripts *without* .sh file extension.
Most notable offender: GIT-VERSION-GEN.

Ciao,
Dscho
