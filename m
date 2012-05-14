From: Stefan Zager <szager@google.com>
Subject: Re: submodule update --force
Date: Mon, 14 May 2012 12:29:02 -0700
Message-ID: <CAHOQ7J8Wq+jHdghgNEGD+7aWNCv3rpPu1erCK4V_pu3sgXQLxA@mail.gmail.com>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
	<CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
	<7vobpwpoyi.fsf@alter.siamese.dyndns.org>
	<7vk40kpnia.fsf@alter.siamese.dyndns.org>
	<CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com>
	<7v8vh0ozge.fsf@alter.siamese.dyndns.org>
	<20120510185738.GE76400@book.hvoigt.net>
	<CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com>
	<20120514165231.GB58058@book.hvoigt.net>
	<CAHOQ7J_O=8NL0wp0Pu6pfjN_Y6NDJhKZUft9G2FL0vUWL7aEBw@mail.gmail.com>
	<20120514191802.GE58058@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 14 21:29:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU0xC-0001pr-V5
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 21:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab2ENT3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 15:29:05 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52175 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab2ENT3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 15:29:03 -0400
Received: by qcro28 with SMTP id o28so3641700qcr.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=XQN/76nG0uvvRti7WzcIbylOHYQzb637AwTqAroXmQs=;
        b=bkMoGdJuwoccGzyrPqyAaDctLKiGquHr5RF9sRUmX9bairoOVTgPqfdVn8T58QrY/C
         SFKrRUvzTz8LaVul3e7C/Dz4gWYqp86KzpkowlTxR0S330RswZEo7rreM+D+RSImdDZv
         N1ORXh1ULhrkDz7a0bH6v3ug/zRXlYSRr+a08at5D3kL6jTklAt5/kMcYG3QVoY4irwS
         PufaGv9K1V5MDddfSKHZJnqY9yrvWAsALBS2HxRHE1190Sn1S92D1iRPcI+4TVLZYOmQ
         r5FD+AX1RbN+5iBPwgV3jHMh51SyjTTtxBeN9A3qjSPnXxJAKeTOjmtaO8EDiGPdTp71
         IUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=XQN/76nG0uvvRti7WzcIbylOHYQzb637AwTqAroXmQs=;
        b=fpBpBPc3/XDU3Y1NGZYvxlKHe1zLKYTMVgZ3tWtnjEN3igMvVoac/wOAFVBwgpKHo7
         36HiONtIXTU7yxDoPQh2subYJI7IBp9Oe2tpypY8q/MZS2i2Xu4tsWvT0EdGnxWZ2+hZ
         sVTfrcctuw2/UW4tEl5znNP7AGpSUkY+C6oz8mF5OxbMBkyQRR8sIwCHuNvS4NuR2+Ik
         Zalsy7RwpkACuHx++xgcfentAQSXPKYVMiauwqtv/lMCVZ1tU4bxxbv6DKSCSWBV9QyB
         VvWZ3ASZ88fu7dd0jvhMLlKXi4uydR0eZcNsYu5DPb7oi1mYBnIgrTly1hjJmxGsNzUn
         zCiw==
Received: by 10.229.102.130 with SMTP id g2mr4525682qco.77.1337023742995;
        Mon, 14 May 2012 12:29:02 -0700 (PDT)
Received: by 10.229.102.130 with SMTP id g2mr4525655qco.77.1337023742660; Mon,
 14 May 2012 12:29:02 -0700 (PDT)
Received: by 10.229.135.211 with HTTP; Mon, 14 May 2012 12:29:02 -0700 (PDT)
In-Reply-To: <20120514191802.GE58058@book.hvoigt.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkqiLWjsXwkBk2Jxe9rJun0Eu1J5bAWvuVb9d0/Iud4rIQUlutyFqO7l+cX3jmb0YuZgjaNBrUBRvjP4r/JFgDQI76jCZNZZDBwhcxN7waWRbKpsomTUGg/FxU4ahgpidFbwmU9fp23T2yE4torZN1WFaKhgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197802>

On Mon, May 14, 2012 at 12:18 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> On a side note: I am surprised that cloning through git is really that
> much slower than copying a zip from the network. Do you run git gc
> regularly enough on the server?

Don't know about running `git gc`, but I can tell you that the
'resolving deltas' step on the client side is very slow; anecdotally,
it appears to take longer than the network transfer.  We also would
like to relieve the server of the burden of creating large pack files
many times a day (the repo is frequently cloned).  I'll check to see
whether `git gc` can help us.

Thanks,

Stefan
