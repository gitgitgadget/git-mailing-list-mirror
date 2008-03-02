From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Sun, 2 Mar 2008 19:40:09 +0100
Message-ID: <1b46aba20803021040ofec56b9q120a654a192eec09@mail.gmail.com>
References: <47C98472.8000002@gmail.com> <20080302094031.GA2973@steel.home>
	 <1b46aba20803020454v322f061bi4f34a737e9e2b7f3@mail.gmail.com>
	 <20080302155541.GH2973@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 19:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVt7A-0000am-Le
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 19:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYCBSkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 13:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYCBSkL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 13:40:11 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:39156 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYCBSkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 13:40:10 -0500
Received: by wf-out-1314.google.com with SMTP id 28so6146711wff.4
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 10:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Gr2XigYooYaQNBM5+RGmixEvEVI18xTjFIi8UBDUuW8=;
        b=cZM3hAlvTjw2Jww4z05GKKXzxca0RZ6YkwfIzEFRIJyETglxjSXVBgGACFUvgWAbLQY4WhLKHEgBtB+/0LVg8lJiCL9WF/o212gR89A24Id5nXaul7Nbad7WrBzB26cqwzj5Mq8Emf5NiNqKAqm+68VNK7pT9h9IZSd2gKtnofs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rx19h9pGDuOXBqSJEvTQpvvVJ0RqpcAosJou9n51lGOWYM9gV802Iz0A4C2j7yAV44by94U15uQQ6lbdc3bH4/gfMw5ZdkRs8ifnrdOFVSJO1uVifghcL3QAurhXGwSyYnMxIQnkcGMNHIbqC3fItYi4L25R/7FPFgwRSMwDPfI=
Received: by 10.142.215.5 with SMTP id n5mr8468686wfg.161.1204483209465;
        Sun, 02 Mar 2008 10:40:09 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Sun, 2 Mar 2008 10:40:09 -0800 (PST)
In-Reply-To: <20080302155541.GH2973@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75828>

On Sun, Mar 2, 2008 at 4:55 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>
>  "static const struct option options[] = {"

The other files using parse_options have only "static", or nothing.

To make "options" static, then reset_type and quiet should be
static too, otherwise it cannot compile (in my system).

I don't know benefits of making all of them "static".
Has this been discussed previously?
