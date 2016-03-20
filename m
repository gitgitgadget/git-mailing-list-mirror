From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 20 Mar 2016 16:39:32 +0100
Message-ID: <33EDD26C-ED5A-42EE-B523-240AEF5C51B7@gmail.com>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56EAC49B.6020909@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Kevin Daudt <me@ikke.info>, philipoakley@iee.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 16:39:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahfSM-0006tS-0l
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 16:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbcCTPji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 11:39:38 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34704 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbcCTPjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 11:39:36 -0400
Received: by mail-wm0-f52.google.com with SMTP id p65so124981295wmp.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qiLp5MVYclu1JA0SvY6hoX/lHEeptxFk/UtcW5nbFiY=;
        b=pZKBlfEavDBFIucUQIQpFClQDtw4iQjcsv+snH03QISr96nqwcDhvbFmXn0PbF3TOm
         tXBi7fgkBeneGISlpmLPWXk7miYnKcK+LF3aaQPuDPngBhkhDgMuRRRCZG31GZLH8zvH
         C4vKONOJfLI3yhP7JJjT7lkab/J27uvNC1tQXVh3+rneZJlw3ys/TXQJB9383G6JB/o7
         VnFIC8+3JmhWhV9XlbjFE2YA0tzNuIEW6ryZ722ryI4ZSNuyCOvdUBnKDvjuyPAlhyaw
         7fkoXXBs8iIvgUacNwn4C7m6bRND7yCEQWagCfqWGzRtYzqiQW8EC2NAA1MQmTFDkuun
         ay9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qiLp5MVYclu1JA0SvY6hoX/lHEeptxFk/UtcW5nbFiY=;
        b=Yd7gXBwwTAIbeU8xFfdKH5J1KZau/7aFsit+e4lLmEFtqLHYrbG4Zc/9pvs/UTVlRy
         HppOe9JZLqlmAZB0il8YNSKFdpRW8jvku/TPMG6dzcjScxPJZl3KI8M+d6dgzvoc3ZUi
         aV6jmJzNofJ4gV3WqA1PRtCS+uwMOLtYy7KJTF5WsT8d/jQ16aT46rbzRvrGethuUU0G
         S/hVsfYEic+lNoVlwy7OrUh9UpF26DHOm9/2uP+wEUxt2gSZZjsZpeW+rdgS7xfR8iC/
         W21SBvrQRVudEv9QRyh/OyPNxbwcr4KkpSaqCJne29zRwTXQnQGti0TIqNA49+5j1YDn
         viKg==
X-Gm-Message-State: AD7BkJKKrFEG9FS9uMcgl7s+qGP4J7+n5b9SfQJ3jBfIO7/E6wIy36ZqJfgPM9VX/HqrPQ==
X-Received: by 10.194.94.106 with SMTP id db10mr29486826wjb.175.1458488375244;
        Sun, 20 Mar 2016 08:39:35 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id ls5sm21105009wjb.33.2016.03.20.08.39.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 08:39:34 -0700 (PDT)
In-Reply-To: <56EAC49B.6020909@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289359>

Hi Sidhant,

that sounds about right to me. In what language do you plan to implement the 
wrapper?

Best,
Lars

On 17 Mar 2016, at 15:52, Sidhant Sharma <tigerkid001@gmail.com> wrote:

> Hi,
> 
> So to sum up, the list of tasks for the project would be:
> 1. A wrapper is to be implemented around (called 'ggit') that will scan the
> arguments for potentially destructive commands. When none are found, all the
> arguments will simply be passed through to git.
> 2. If such a command is found, 'ggit' will:
>    a. Show what the command is actually going to do.
>    b. Ask the user if they are sure they want to execute it.
> Eg. "You are about to do X which  will permanently destroy Y. Do you want to
> continue?"
> 3. For all commands that are entered, 'ggit' will also show a brief summary of
> the command what it will do when executed, explaining it's intended usage.
> 
> Is the list correct, or did I miss something?
> 
> 
> Thanks and regards,
> Sidhant Sharma
