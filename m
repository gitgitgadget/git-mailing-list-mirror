Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9402620281
	for <e@80x24.org>; Fri, 29 Sep 2017 23:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbdI2XMo (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 19:12:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:55438 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbdI2XMn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 19:12:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjIit-1dLAff2yNT-00dXFe; Sat, 30
 Sep 2017 01:12:40 +0200
Date:   Sat, 30 Sep 2017 01:12:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Pavel Kretov <firegurafiku@gmail.com>, git@vger.kernel.org
Subject: Re: [idea] File history tracking hints
In-Reply-To: <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
Message-ID: <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com> <E8C827ED458648F78F263F2F2712493B@PhilipOakley> <alpine.DEB.2.21.1.1709131322470.4132@virtualbox> <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+1MHnWA9dvz6zo/MaUOUz/F88uRMtOh9s+heNB40QOMMuLvQKKH
 j1sIgycV3fXIWbN3bxbKkdrOsG2DRIYtFeykQRHQpo4EE5p8Vd3W01q4CgUKB1nzsf0Nkd5
 nnK1lHYZ5KKf5K2zXU15tHsYPWZZ9TaLKJt/k3RygI3kvoiEBDO3lZBzhuw/EpwOIsdalyF
 0g5RUhtj8ZnOUYUlYGiAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VPib0NKo/LU=:6H8Xqrkg27drzfSO05vfUI
 U2/3Zrz96MS7DvfgZibGSmRVMl2Z/XcvfvuitMjFN9ySFGuvfFkFUg3fZcPqtyI37beD3lbN5
 M3H9wz7CsWWsfo3aG376OAFkeCma+mGe5AjaRO3Lq/EpkGNezod+uXPSZPiI9hMktdtlJwTna
 7abn/MEDwaIWhlplzxOrHMPNkouEN1JdFcdNxsiepls6XQICpPNsHoBRWXcM5bEvGCvTopqGe
 +L/lhvew672ivwx1S5O7XOode9khJvW2obWLPm8LW4yQi868030wFeCZZRD/FUCI6cXgiSMRC
 4FqrknbhW1aN5zOdH6Me7/8hMv0kjznq42975W1ug4Heh2tto4MAPB7pzqhKNO8v3g+EOhOzR
 9IOh7Xr4taRXLDgESPqOWJT9bmjAB1cyaDGuitV/h2DUXn7y6JCmwqpGRH2nkQd3R494YuPVO
 K9dna6DCOy8l7XVAY0rWLBdZg2aPL8m0n78Z1FhJOZOiM4jQztFtWlHcxeTcGt3l/eV5akRC5
 WYbg+okAXVHKFDHJEQYhQXBkRFMqn5MfEsAqXhJaIYE6xL0sNJ9/0yA9snwOW63E8vQOWDS0P
 UJi0Hwab8+5u5TvWxqgU86dMuzdJ5KMBN0+t4nrJW+kOMemgIqRtfxxRTZ0e5rnvyVc0f+vRf
 y2wW21QmPMywDba+SpGdY6w7LQho/+wljZe4APlhkFDmUc6TrmIkhkpsiu7/MV/un5dnNlR8Q
 k/nLldAmnW+ejKI6eZsd0r2yc/CLiVYZrvtm4TXXo66Xewn+LuziHyEbBunHD0WkyFKIsYGdC
 SaMFjJJziNj16SogtPTzq8oYc6IwohZaDr/HvH3jk3jZvarb1U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 15 Sep 2017, Philip Oakley wrote:

> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
>
> > In light of such experiences, I have to admit that the notion that the
> > rename detection can always be improved in hindsight puts quite a bit of
> > insult to injury for those developers who are bitten by it.
> 
> Your list made me think that the hints should be directed toward what may be
> considered existing solutions for those specific awkward cases.
> 
> So the hints could be (by type):
> - template;licence;boiler-plate;standard;reference :: copy
> - word-rename
> - regex for word substitution changes (e.g. which chars are within 'Word-_0`)
> - regex for white-space changes (i.e. which chars are considered whitespace.)
> - move-dir path/glob spec
> - move-file path/glob spec
> (maybe list each 'group' of moves, so that once found the rest of the rename
> detection follows the group.)
> 
> Once the particular hint is detected (path qualified) then the clue/hint is
> used to assist in parsing the files to simplify the comparison task and locate
> common lines, or common word patterns.
> 
> The first example is just a set of alternate terms folk use for the new
> duplicate file file case.
> 
> The second is a hint that there has been a number of fairly global name
> changes in the files. so not only do a word diff but detect & sumarise those
> global changes. (your class move example)
> 
> The third is the more simple global word changes, based on a limited char set
> for a 'word' token list.
> The fourth is where we are focussed on the white space part (complementing the
> word token viewpoint)
> 
> The move hints are lists of path specs that each have distinctly moved.
> 
> It may be possible to order the hints as well, so that the detections work in
> the right order, giving the heuristics a better chance!

I think my point was: no matter how likely we thought any heuristic rename
detection can be perfected over time, history proved that suspicion
incorrect.

Therefore, it would be good to have a way to tell Git about renames
explicitly so that it does not even need to use its heuristics.

Ciao,
Dscho
