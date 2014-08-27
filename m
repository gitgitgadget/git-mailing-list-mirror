From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/6] clean up author parsing
Date: Wed, 27 Aug 2014 11:06:27 +0200
Message-ID: <CAP8UFD3Zk-Z+OWaCSfetSASYLBJ3kkDKYo2bB9QLJw8APTQPAw@mail.gmail.com>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 11:06:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMZBa-0006C0-83
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 11:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbaH0JG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 05:06:29 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:61465 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbaH0JG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 05:06:28 -0400
Received: by mail-ig0-f177.google.com with SMTP id hn18so54570igb.4
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wJcqaw1qVAW/zASsnguq7I3lKs4nvZQVdB3KVSk5NCg=;
        b=vbfhIx9B2UE/RLwM+tcFw86io6PTwkB3/DylgyeFAS4afNBXrZvAE/YjWAPegYTKwr
         sPs445GGKxhDD45DU4iNOtGv90bd2F7inA7C3SPArpGVmh/03ioZvi2XpFdniSXQ2bWh
         lhnH94Fd88dmp8SxXUzb0oHfEx8RvthjbZauyxnNeq83f/9WLw+cs6WqDnzgynjlZA9s
         z82w2ZlwrBvyyxK1qdGb266YHEa8ZFTcyIt9DyxeqAPOjfgAwNxFVlMOTQf1mntK5m4E
         ptXHDp4AwiPcPaiYWdljXFL7o7X2PciRSwN71qwjKMwtNcI9foIFPTtXc+EYKJ/dI7Qc
         FS5Q==
X-Received: by 10.50.33.73 with SMTP id p9mr27978353igi.24.1409130387513; Wed,
 27 Aug 2014 02:06:27 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Wed, 27 Aug 2014 02:06:27 -0700 (PDT)
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255990>

On Wed, Aug 27, 2014 at 9:55 AM, Jeff King <peff@peff.net> wrote:
>
>   [2/6]: record_author_info: fix memory leak on malformed commit
>   [3/6]: record_author_info: use find_commit_header

s/record_author_info/record_author_date/

Thanks,
Christian.
