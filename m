From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Mon, 13 May 2013 16:05:57 -0700
Message-ID: <20130513230557.GJ3657@google.com>
References: <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org>
 <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
 <20130510190705.GA3478@elie>
 <CALkWK0kZWrY5_B3mxuVV1cA-AqvkqJpjRAuSovXLi6OCA+3ybQ@mail.gmail.com>
 <20130510191639.GB3478@elie>
 <7vk3n6zgr3.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rqjduiWsj2-iqCoW9tsv4G8gvpf7fCZwg5=TKuEo+bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 01:06:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1ot-0003pg-4h
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab3EMXGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:06:10 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36616 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab3EMXGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:06:08 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so13980474iec.29
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fJbRhbpvGqtuoCPVAir5ivgKVdd1y/SSG15waG3nleg=;
        b=PGie5D3bWkbKu1K6m1y02aZOhaKc7u1yXlkW6ykpq1rBAOtcTF10sOqQUyHtan6Jrc
         MXM/IErLTdq4so4NTlNhlRspZeosaCD0yScknoRWf3iI67O4OqDfP5ujYxbVPcSYyo0N
         GckdfKecCVgFQ/ocbQ7grlJiTSfgDbjXeGHIZQC3QCB8yKuobsAv8+k3ycHnqTcv500q
         V4amYAtqw3aXJKQpiz6BUy9QmbI9dkkH2lGmiPYR2sK94wo2Y+f9Fewwk+l51UQ2OIhj
         e3CLHswbF7GhDHpr/bvnfJeA1sDwyc+Qvm6wPOfctx36AeaDWdZwsn+VKB90hF5gpTAr
         pNIQ==
X-Received: by 10.50.16.36 with SMTP id c4mr223616igd.60.1368486368401;
        Mon, 13 May 2013 16:06:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c11sm21472172igv.1.2013.05.13.16.06.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:06:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=rqjduiWsj2-iqCoW9tsv4G8gvpf7fCZwg5=TKuEo+bA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224217>

Ramkumar Ramachandra wrote:

>                                                              I've
> never really found the outputs from earlier tests enlightening.

If the test suite would automatically use "set -x" when appropriate
so output for each command was preceded by the command being run,
that would presumably make the verbose output more useful.

If you are not in a situation where it's difficult to debug
interactively, I doubt you'll find anything better than reproducing
the bug by hand and exploring.  I suppose an option "Run up to this
test, stop, and tell me the $TRASH_DIRECTORY and next test so I can
try it manually" could be a way to simplify that workflow.

Regards,
Jonathan
