From: Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #06; Tue, 25)
Date: Wed, 26 Mar 2014 10:03:50 +0100
Message-ID: <CAP8UFD3YuGuekwrzrx7Qr_saDyLSo7Chvggb7ygTuie9w0T93g@mail.gmail.com>
References: <xmqqlhvykp62.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 10:03:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSjka-0000FU-MD
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 10:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbaCZJDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 05:03:52 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:58507 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaCZJDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 05:03:51 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so1940845veb.24
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P/okY8ZtBaiAaWuj2uZ3CE+18vPrVwQPpC0zi3HNV30=;
        b=S9CISE+NicWRbKQOd7BGeXkE3DtGPKBI1nJEkQ40VPcrmvMqOAN95w4PeMRYDZdpck
         3LHYE6jCIlQSU4/oBaWo8+hBFzypL9l2rMa+BQRM93K8ylVWUKxm0mPg/N5wFbdaPBsc
         VijgybDup0xvCpvz5RVmtUeRfGQw2ei6eDZa+vZBd//zuBDLqRJThTUGgCUdlK2ceAzS
         w9cayaL2SsQSlA3uNg8YnNDkTsI2W10oi7E2EnwTiZx4AQ9Cg1eq6oGH6FYtTEVZZOSQ
         31g+DIU0bGXX+H/x1w9+cSvFGtuTfy/KL94Z4e41VkiYoaTuDEKIGlqKTBoGSxz3xdM/
         00Dg==
X-Received: by 10.220.191.134 with SMTP id dm6mr60238312vcb.16.1395824630534;
 Wed, 26 Mar 2014 02:03:50 -0700 (PDT)
Received: by 10.58.137.166 with HTTP; Wed, 26 Mar 2014 02:03:50 -0700 (PDT)
In-Reply-To: <xmqqlhvykp62.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245171>

HI,

On Tue, Mar 25, 2014 at 9:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * cc/interpret-trailers (2014-03-07) 11 commits
>  - Documentation: add documentation for 'git interpret-trailers'
>  - trailer: add tests for commands in config file
>  - trailer: execute command from 'trailer.<name>.command'
>  - trailer: add tests for "git interpret-trailers"
>  - trailer: add interpret-trailers command
>  - trailer: put all the processing together and print
>  - trailer: parse trailers from stdin
>  - trailer: process command line trailer arguments
>  - trailer: read and process config information
>  - trailer: process trailers from stdin and arguments
>  - trailers: add data structures and basic functions
>
>  A new filter to programatically edit the tail end of the commit log
>  messages.
>
>  Will merge to 'next'.

I have a new version of this series, but I am not very happy with it.
Especially, I am not very happy about not using strcasecmp() and
instead lowercasing some parameters read from the config file.
That's because it adds some lines and one more patch as I feel that I
have to refactor lowercasing functions.

I will send this new series soon anyway and we can choose if we want
these lowercasing changes or not.

Thanks,
Christian.
