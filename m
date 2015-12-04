From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Fri, 4 Dec 2015 18:54:08 +0100
Message-ID: <5661D340.2010305@web.de>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
 <1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
 <565E99F9.2020906@web.de>
 <CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4uZ5-00031K-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 18:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbLDRyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 12:54:36 -0500
Received: from mout.web.de ([212.227.17.11]:52985 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbbLDRye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 12:54:34 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M73SD-1aRVzJ1H2T-00wqN9; Fri, 04 Dec 2015 18:54:16
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
X-Provags-ID: V03:K0:fEL6tAusZuofiD6lEkKMK8okzozpAnxOWGjU+pJHVxowSp4GJJO
 W+DGL9Y8Zc7Q1vq7/mWtf67p4SO6jwFcRGeFatV9CSNq9Jb70jQwlJDCFkYgTEMy3J0hWCW
 Eyiq5FJ6f3KKXNSrZX9tAIG4cWh3Zmb3sO08aU+aNcMdulQM1oCHdIQ/glJBvaiwJRiMuzU
 4nuyXd1mEiXFnYjPAF3eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:joNxICzoKpk=:YZGkHnrLnmw+fWDnmqJezZ
 UF41IL8yEBs5ORsncdngoZn1nbkkevwWxv3je66sgRIxtQxEDpKcyJxFwXM6Enb7V9VpIbzVE
 OQO+GmBXH3qRHXiH35hvlgo1ClJC1Rj3aYGYHbUs1GSZoccdS/STeYZNPYe6p77GvfZptcCTq
 ddOeg6CfVEgNX9nO86p4lPaCkIlcT8U+ws602niPTknSYz35dreLzEwpglc/fHxhBT9q8FKW4
 Zbb3Eep70Tp6yNrZAtPfKiefY5nHE+m27uKKxsW9YC5k9navrAaJ6alvJmsYHtDGCugMHlEfP
 BbxFDC4Nfgwv1pu04UM80DnX2xfj52wpqEuDbFifP+M7Od1lDBHLwZNBiLAdH3JCVtgtisZag
 7MHSswSiss2WE794f5DPDUQ9uugyw1B5X6/AoVvToJps0/GB9LRxdM8UF3phrFfFUvQ1FgBVc
 rFJP74VkBwC2xNOe8JYtL8vcLsgrnZWT4HiVrdq07YFJhZAYsYYEUIfkddoGlsiLQY3C1yPBQ
 rUMwoS+ix7RVPG7I3Wt1K5dcLzvXEsQhFwK2Su34sNNvPu2NOU7SuZ3Bh5jEHY3UaJ8Cni3mf
 etUVsX0lGyzcqwi1eS3h7k/8d5nCJ9rog2WnA7dcTMAxf8TaQkRSZgWb4pnd9h1RuNhiWxVf/
 JbtkeD84QdioHELazBBEN4does46eiUMMZNlLPZQaufq8ts8lSBesYpenxSnZDaTSpkx+iVzP
 xHbqRNlvtTSrvjcSYyorWHszpBS6TVFSqxtfO0Q4mJac7XRLZAGKFH6aIxNSx9CNAfoGyPYx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281991>

> Current state of affairs:
> 
>  * Enable on a per-repo basis: git update-index --untracked-cache
>  * Disable on a per-repo basis: git update-index --no-cache
>  * Enable system-wide: N/A
>  * Disable system-wide: N/A
> 
> With this patch:
> 
>  * Enable on a per-repo basis: git update-index --untracked-cache OR
> "git config core.untrackedCache true"
>  * Disable on a per-repo basis: git update-index --no-cache OR "git
> config core.untrackedCache false"
>  * Enable system-wide: git config --global core.untrackedCache true
>  * Disable system-wide: git config --global core.untrackedCache false
>  * Caveat: The core.untrackedCache config has precidence over "git update-index"
> 
> With the rest of the patches in this series:
> 
>  * Enable system-wide & per-repo the same, just tweak
> core.untrackedCache either for the local .git or --globally
>  * If you want to test things either per-repo or globally just use
> "git update-index --test-untracked-cache"
>  * If you want something exactly like the old --untracked-cache do:
> "git update-index --test-untracked-cache && git config
> core.untrackedCache true"
> 
> I think applying this whole series makes sense. Enabling this feature
> doesn't work like anything else in Git, usually you just tweak a
> config option and thus can easily enable things either system-wide or
> per-repo (or any combination of the two), which makes both system
> administration and local configuration easy.
> 
> A much saner UI for the CLI tools if we're going to ship git with
> tests for filesystem features is to separate the testing from the
> enabling of those features.

My spontanous feeling: squash 6-8 together and add this nice explanation
to the commit message.
