From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Fri, 26 Apr 2013 16:56:27 -0500
Message-ID: <CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net>
	<5178C583.6000703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Apr 26 23:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVqd7-0007DK-RW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549Ab3DZV43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:56:29 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:50941 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3DZV42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:56:28 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so4178806lbi.39
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Y7flfBvgFf/R+4xl5DO20k8OdbDHO8/2wGgePPUTBP4=;
        b=Tt33suFWmZH6ri06/8ISBL0WaF+4YxHwF+JG5VDWN4Za8WvvF5A03vtIhnPHWCZBO7
         7zpHIH4uMKcx6gtkYlGAGt52+si/9koTKC5zKAcF9jXR9Z6ocAnlEkWMinIOQIH2fONx
         vU9pxck1mVQwFmTw0hdVOSRcv2eBAnXoGzrT2Ij4swRpkJpWv62RaOJrMzgjNQdHwSRt
         2zFqSBKv0wR+ZaXxv6de0W90b8pa5YM1T0hUL/ckL3gfs5zSwAUl3RweLfMSmDidDvS4
         XO1arcAIHd/9Rpa3k++UtiLCA4GyONVoPBuB8C+hgTId7ipEmKJyftl/vmjuXtfoKQ9X
         ncUQ==
X-Received: by 10.112.22.198 with SMTP id g6mr18716774lbf.135.1367013387094;
 Fri, 26 Apr 2013 14:56:27 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 14:56:27 -0700 (PDT)
In-Reply-To: <5178C583.6000703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222594>

On Thu, Apr 25, 2013 at 12:56 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> From: Johannes Sixt <j6t@kdbg.org>
>
> Bash on Windows does not implement process substitution.

Nevermind, reporting all the refs creates a lot of irrelevant output,
this version is fine.

Acknowledged-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
