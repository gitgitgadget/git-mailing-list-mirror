Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 141901F856
	for <e@80x24.org>; Sat, 10 Sep 2016 06:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbcIJG3i (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 02:29:38 -0400
Received: from mout.web.de ([212.227.15.14]:58063 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbcIJG3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 02:29:37 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LsyBm-1b29UW1jsg-012XST; Sat, 10 Sep 2016 08:29:22
 +0200
Date:   Sat, 10 Sep 2016 06:29:20 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, jacob.keller@gmail.com
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
Message-ID: <20160910062919.GB11001@tb-raspi>
References: <20160908182132.50788-1-larsxschneider@gmail.com>
 <20160908182132.50788-11-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160908182132.50788-11-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:x6MBHyUYruFHS7hysKrHzKcFzQBjgg6WR5QUiz1jcYlRPlsREhI
 sirsHcYkurqJHgZpwEF7eFvcnF8kMT9uoAvdaHSETYtnSVZE8aKOvtg71EuD/PJPG6NR3nH
 7Fsu3A2U5L1EiKDisZlcyaZ4XiJBXc2gLtSS2rikyNbwBFIxTHKjoeoC5e1dty0eGzsmRFj
 m2qnJjrZtRoIBGQmY0wUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9yHkOWYF6Hc=:tMPd2b87/7aF2d2TbpX92e
 q/+Ez4+nWUTw0EG/XtUqtQYMx542UosqRqvoorPD5l3awdqELmBWfBcfFGuGwb4rF4kfNqgxZ
 +3j3H2eblME5GWUVBT9GVVYOUcAZX2tlBwL9Mj5FulnmLOt4elGHmPGFYhQbYQc0mToRBqd17
 uP87hHPQ+4HfTPh/MUWTg5O4EWQdmxr4yXi9zPgZN+RVmGw7uOPLXzsrzCQXdGJTX9gvFHoZu
 eP1Je5OgiHk2xywUAJP9AwJtaEKgfgl6R61azHdRM0kqvLn+3fI91Icohl6c5B8fUIB5cOXbC
 VIJ7yY4cEDaDjnoexeQA4bjoFa1UPbWQ4y5h0qxtGT1UBIZdlNJ7cvFsdxOs/DWMGY3NEyACY
 nu6vhmKTuMsQxs+VQhtzFp0tXfWF/qU3Mt6565XLcbUMZbPfa1BR7InPS0XxBmpLyFdMrdSQJ
 AX6bJ3b5Hh+0r6AfhkIYHrm/O6INKxvMyLTK6EcGJ+fYN+/RnlOLqtoqhE6Sa9N25Xi0+HD1H
 zxvasAOAjh2jsAYNCw87gYtIblrk/4YSJFLelC1/o7oNJUVrlrFNs1Q2WcjFrgRJ6XgDtoC6t
 yXg6/AzVhgXlKO+TJK3QQFfe0vuFwvwmBIh73my6qY8GW/fpxyAQrbX3i1pLD7S3ArhVmluyQ
 rynL1vVWtpiDSXuW9d/8+RNfqK4a6iDSZdow/2SVulkVXTN50gX+BG0lgB+7Y3w+vZ7hrcHDF
 XTDl96+HN5rfgE6yhB1Ytq45FGlb1bVI6AoZbT6b3EGgxuI7yH10rseqo40=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 08:21:32PM +0200, larsxschneider@gmail.com wrote:
[]
> +packet:          git> git-filter-client
> +packet:          git> version=2
> +packet:          git> version=42
> +packet:          git> 0000
> +packet:          git< git-filter-server
> +packet:          git< version=2
> +packet:          git> clean=true
> +packet:          git> smudge=true
> +packet:          git> not-yet-invented=true
> +packet:          git> 0000
> +packet:          git< clean=true
> +packet:          git< smudge=true
> +packet:          git< 0000

It's probalby only me who has difficulties to distinguish
'>' from '<'.

packet:          git> git-filter-client
packet:          git> version=2
packet:          git> version=42
packet:          git> 0000
packet:       filter> git-filter-server
packet:       filter> version=2

(Otherwise the dialoge description is nice)

> +------------------------
> +Supported filter capabilities in version 2 are "clean" and
> +"smudge".
> +
> +Afterwards Git sends a list of "key=value" pairs terminated with
> +a flush packet. The list will contain at least the filter command
> +(based on the supported capabilities) and the pathname of the file
> +to filter relative to the repository root. Right after these packets
> +Git sends the content split in zero or more pkt-line packets and a
> +flush packet to terminate content.
> +------------------------
> +packet:          git> command=smudge\n
> +packet:          git> pathname=path/testfile.dat\n

How do we send pathnames the have '\n' ?
Not really recommended, but allowed.
And here I am a little bit lost, is each of the lines packed into
a pkt-line ?
command=smudge is packet as pkt-line and pathname= is packed into
another one ? (The we don't need the '\n' at all)
Or go both lines into one pkt-line (thats what I think), then
we don't need the '\n' afther the pathname.
And in this case the pathname is always the last element, and a '\n'
may occur in the pathname, since we know the length of the packet
we know how long the pathname must be.



> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +------------------------
> +


> +The filter is expected to respond with a list of "key=value" pairs
> +terminated with a flush packet. If the filter does not experience
> +problems then the list must contain a "success" status. Right after
> +these packets the filter is expected to send the content in zero
> +or more pkt-line packets and a flush packet at the end. Finally, a
> +second list of "key=value" pairs terminated with a flush packet
> +is expected. The filter can change the status in the second list.
> +------------------------
> +packet:          git< status=success\n
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000  # empty list!
> +------------------------
> +
> +If the result content is empty then the filter is expected to respond
> +with a success status and an empty list.
> +------------------------
> +packet:          git< status=success\n
> +packet:          git< 0000
> +packet:          git< 0000  # empty content!
> +packet:          git< 0000  # empty list!
> +------------------------
> +
> +In case the filter cannot or does not want to process the content,

Does not want ? 
I can see something like "I read through the file, there is nothing
to do. So Git, I don't send anything back, you know where the file is.

> +it is expected to respond with an "error" status. Depending on the
> +`filter.<driver>.required` flag Git will interpret that as error
> +but it will not stop or restart the filter process.
> +------------------------
> +packet:          git< status=error\n
> +packet:          git< 0000
> +------------------------
> +
> +If the filter experiences an error during processing, then it can
> +send the status "error" after the content was (partially or
> +completely) sent. Depending on the `filter.<driver>.required` flag
> +Git will interpret that as error but it will not stop or restart the
> +filter process.
> +------------------------
> +packet:          git< status=success\n
> +packet:          git< 0000
> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
> +packet:          git< 0000
> +packet:          git< status=error\n
> +packet:          git< 0000
> +------------------------
> +
> +If the filter dies during the communication or does not adhere to
> +the protocol then Git will stop the filter process and restart it

My personal comment:
When a filter is mis-behaving, Git should say so loud and clear, and
die(). 
The filter process can be left running, so that it can be debugged.

Here I stopped the review for a moment, 
I still think that Git shouldn't kill anything, because we loose
the ability to debug these processes.

