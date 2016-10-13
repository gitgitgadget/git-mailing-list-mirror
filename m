Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D1420989
	for <e@80x24.org>; Thu, 13 Oct 2016 16:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756547AbcJMQFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 12:05:04 -0400
Received: from mout.web.de ([217.72.192.78]:54333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756557AbcJMQE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 12:04:58 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MEmgA-1bej7X1gRG-00G3dn for <git@vger.kernel.org>; Thu,
 13 Oct 2016 18:03:25 +0200
Subject: Re: 2 directories same spelling one directory is camel cased
To:     git@vger.kernel.org
References: <e0a3eb0590552c98638d486db8ad4a12@davidwbrown.name>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <967e9ca6-1e0a-7995-6e11-a3f0f255f087@web.de>
Date:   Thu, 13 Oct 2016 18:03:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <e0a3eb0590552c98638d486db8ad4a12@davidwbrown.name>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:+tmowvqlp3eYf9Dwi9OtUxJQCQtK8YZJ1CNjKBgrur7LtV0Wkbc
 cuVnYro3rv4HKKLUES0mSj5DdAubgubE2XdO4OQNPudWlOjEdLJ4mP4gO67kxl3sOrZx/Ai
 cJSz2P6fABvXg+/jL2Bk5VJQjbC+nhrIlHYitFZKSq4D+O6MSqfi9vVoRED5rQGDMCPnjXg
 K54HX/uKCbyB9Vm5Vy12Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OYzWs828AOc=:X3zlyzS+H3uOfvqIxVEY+Q
 T6qjHmMv/fj19Gxi7mdRSKlACFevLri7PXyRP9IUdUjXy3oDNRIzqepbZdMNav4bPl1v/gwiD
 eE09wIxYrVa69fgnBKrdOMCsQfo6XX++b9x8c65LmltjTnThJVdyZVAV8PqlhaJwp9cs8ldC9
 hMsP/OddqaxWID8ntEQq/3YcsLQJRWmuXuREZ+EJq/MMpFcxHjOvyLi8vufSRkT5dR0CmGhaS
 rFZ+3NcLnRKQo9gq/yWy+DBbvb9vNjomQyXyLZFNP1EYZdLafJ14TkJaNPJ5umptteCnCEhn8
 r5W1edoZbQOov54OfnEnM2J5OhM4iCnU2cmu0Gs5IeSFbt5QKi3or0etOeCEPMyCf3ic9x6Yd
 UlkATuRPMwqJzU+p/lp0Hl+b/xjhmLxHBnftpXshn8UOei3MzcIy7FEB+LI1q7a5ODAIgfuny
 MEXh1uBhgreEyrV3JEtROKhIkeWYMRc5evU5iK5tNrqI+llxN34AtqRFsj8V4Y8PzI2Tv4q3a
 pVVfwVuo27Fi7bhFbJ8DF7dzefKsdeH7O+Ig+AJgPG8SYIUbhnFJZlQgQYEv0oJ5Vbzu4Rr0R
 O95VHzcvZi7I3TrC2Q8ApfpkNeoygv+O2RtSvagH46+P29cs8JqWnn/TocA4JA8qccMsQ6Mhx
 monLulmoldmMOqJI/pvk8F3fI3HQu9ot/PpGqKKXZCY9AS0f5ASd10g2o4np5wdNsSwrO9kl/
 xdL4jJHShFWg27cuBNt6TLnVtcvrTujWtWriITDjnHLMBoB0VVjejItYyItvB7kD25mnTl+ST
 QR2izCE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.10.16 18:05, David Brown wrote:
> Howdy git gurus,
> 
> I have the dubious distinction of working with a remote repo (master) that has a class loader run-time error when cloned, built and executed.
> 
> The reason for the runtime issue is a directory hierarchical path has to directories (folders) with the same name spelling but one of the directories is camel-cased. The package names are the same.
> 
> The compiler doesn't care but the run-time class loader has an issue with the 2 'same like named' classes.
> 
> How to remove the offending directories and files at the locally cloned repo but not push 'deleted' directories and files back to origin/master the remote repo?
> 
> Please advise.
> 
> Regards.
This email did not resolve from here: David Brown <david@davidwbrown.name>

It is somewhat unclear, which issue the class loader has.
What does 
git ls-files | grep -i "sameNameBitDifferent"
say ?

What do you mean with 
"How to remove the offending directories" ?

Just run
rm -rf "offending directories" ?

Or, may be
git mv dir1 NewDir1

If you don't want to push, you don't have to, or what do I miss ?



