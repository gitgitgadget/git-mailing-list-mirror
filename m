From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH 1/1] Fix --stat width calculations to handle --graph
Date: Thu, 22 Mar 2012 12:33:41 -0700
Message-ID: <CACz_eyfc+X8zUCBs+mfvWvPaCaki8ma8-wxeQ4QtsQC=d-Caag@mail.gmail.com>
References: <1332229097-19262-1-git-send-email-lucian.poston@gmail.com>
	<1332229097-19262-2-git-send-email-lucian.poston@gmail.com>
	<alpine.DEB.1.00.1203201109370.3340@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnlc-0005v3-5n
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab2CVTdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:33:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44641 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab2CVTdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:33:42 -0400
Received: by ghrr11 with SMTP id r11so2116449ghr.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0kQGKr7JcptfPV8VpBkISDhKVCDEmon3xE6vAhB0DVA=;
        b=M/jqIOedyVrKlYP90A/WuNgQ/c6VmYnRELvW9KurvwmMWEu1VwgcwEOixFd2nZVre2
         r2K8DdaYw9b1cYOv/OzI8VmspLz1SGJOgV2MTnQcPVaXvyqoWL5XKkuKK1LjEU5D5QkQ
         S0/Qcp0WJzzpFahs84YwoLGu7f8FmRqcIBEXi0VImibSbn1DkpFVxlAvbx9jy0tlttg1
         WyF+CTgvCtmbP1Ka0fmPhGh3rFlCBn4/m1rgs0a8vMwP1Dwzj9aK8tzAOi0PyP+O1EzP
         7/Km1+1asNe8tw5Z/1Qj1gFOhkwMFgIna5jTfUggf15Gy9gYlfmREn5V/i4oqXpGlea5
         dLbA==
Received: by 10.68.221.10 with SMTP id qa10mr21913347pbc.139.1332444822003;
 Thu, 22 Mar 2012 12:33:42 -0700 (PDT)
Received: by 10.68.47.232 with HTTP; Thu, 22 Mar 2012 12:33:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1203201109370.3340@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193697>

2012/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Good. Just a quick question before everything else: are the commit
> messages cut off/wrapped to the same number of columns? If so, where do
> they get the indent from? (Sorry for asking, but I figured that you're
> already deep in the code so you might know of the top of your head.)

Thanks for reviewing the patch! The commit part of git log is handled
in log-tree.c:show_log().

> My 1st reaction was: why is the current indent width not stored in the options?

The new patch adds a output_prefix_length field to struct diff_options.

Thanks!
Lucian
