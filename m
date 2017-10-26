Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1361202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 19:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932450AbdJZTWI (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 15:22:08 -0400
Received: from mout.web.de ([217.72.192.78]:58432 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932326AbdJZTWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 15:22:08 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNma-1dkk0V0FHI-00Tnhk; Thu, 26
 Oct 2017 21:22:03 +0200
Date:   Thu, 26 Oct 2017 21:22:01 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Consequences of CRLF in index?
Message-ID: <20171026192201.GB27760@tor.lan>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
 <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
 <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
 <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:PCBZlGmTqn3eMkvHYJBdiBth4UkSM/iNd1PE5V7dPqcuabVQqzR
 +k6pyJRPgfv74JmCJDSc+GDu01MySu0RS0qF5VMpBAHHOjpDcZtx63uWhfNfVj9I1y60ALR
 QWZz0e4tTrrhwKO9jXK7dnWAv/4+82XwZfMduQriSnMZPdn20AEVxKI/DBe7L7oGQPNEXo7
 7aGZOM5ioPJn+cLU9NLZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y5IhP3YGd3o=:o/NfNp84LcXYQ7QbMxBcux
 6HLNLU+V5zqD9mhzsN6AApRXENJjKe5az2IhEX7KqJUh3P2If4S2ClFpk7x8uhLIXnbxwxfJo
 RS/Q8UGu90WyjSj/TufD1hK5gDwZBC6Da1Yvau6uPot335LOuxHs04kXMcv/CPOXmdSpgfCr1
 Ia25lCzZZZ56eyIsrX4pchHlxOWdGnow2+ppe7FrXSIuU1DG16YqlTgd8sPSQLBXMbrLbcSfK
 CKgbci3ayeNkbSCWEzTYB3TFLkF6cbSfha65kTEOPXI5L8k5ylIk7xBi8bX3/DciiV/ubPd7K
 dlxBHfWpCOyCV7a3rjE2sb2wY9tg73DxEbQGErFrrZGlDwUJ5uRj2p+1iYy5ijvOpuo7W3d7I
 bXDSFeEq9EjwKI40n3FFzC/SE6+Gj7D5+023uaxzrXZmgAlUxA3xFTDib2xT6iDHux+cBUWdc
 P4BLb0woivkaBcuYH2uzgluaSt2LzJ3ZX8f8YIsxLrt9N5E+qLvjVTheR/5Ws/rzneknlXZfh
 Pp3MiqyskiwYJMycWX6zBxg0qsXi17IaQSrMgXrt4oAHto6dqigPKLJ9NoRr+ft43ZFz0ZqUB
 chZ/XPdGbt/43W+dUq0pQXftqRnUcSVrtSHMfxAtn9ugNf6Azn/7ZUqKp++nKMGpTx5pHrLXm
 BLLCjek69BZrUkjfPPaVons1JONQhJptoaYBpVnDKB85iaL6LE0wyduvt7VJPM7i08eYcAYX0
 r63WZfRgmumtcgS6RmTDfVArJAeQRSNOe8/oiVd+M2CG9kgM22ta5s1iyh80LxDBOSdhadw9t
 cFSb3VcN4tA/NV0riQVUVDN0GRhPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 01:01:25PM +0200, Lars Schneider wrote:
> 
> > On 26 Oct 2017, at 09:09, Johannes Sixt <j6t@kdbg.org> wrote:
> > 
> > Am 25.10.2017 um 14:19 schrieb Johannes Schindelin:
> >> I envy you for the blessing of such a clean C++ source that you do not
> >> have any, say, Unix shell script in it. Try this, and weep:
> >> 	$ printf 'echo \\\r\n\t123\r\n' >a1
> >> 	$ sh a1
> >> 	a1: 2: a1: 123: not found
> > 
> > I was bitten by that, too. For this reason, I ensure that shell scripts and Makefiles begin their life on Linux. Fortunately, modern editors on Windows, includ^Wand vi, do not force CRLF line breaks, and such files can be edited on Windows, too.
> 
> Wouldn't this kind of .gitattributes setup solve the problem?
> 
> *     -text
> *.sh   text eol=lf
> 

Yes, exactly. and for the snake-lovers:

*.py   text eol=lf
