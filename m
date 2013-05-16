From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 15:04:05 +0530
Message-ID: <CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com> <CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:34:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuaK-0002P1-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab3EPJer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:34:47 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38744 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3EPJeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:34:46 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so5961137iet.14
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VKxdaHse+lKVUvYspqLmemXNTaLM6O09/eSeJPDqUkA=;
        b=nT/AWT9kBAmhbXlMzYk7Rl0+kIZKSZ/Wp9VnFZia6oBsoqZSewr6BpNf8bDsStf6Nk
         SaAjQhat+QcuTh3OyZcl7CDYK43NH0PaXSIG3d7clC9NzHSsLAGaxBorhue5O7IVlp8q
         a8UU8gepzCtvfCJFfIkSv2pNuGNdUB3u9IeGRQBcCxk2kkIeZ/IhfHWkeYQLjbcbx1JN
         ODXRVW6swy3TNI95vd3RqeyHC+K8FKk0ez6s2u29QgNoPqKVSZ6+QTmQ1jDe/eSUkhPZ
         osr/gESAJOrEFspGRCMD4oGR+U+Fv035qKWotte3U7gudmxuTDzI1CUNw3mLKwInUir+
         1BlQ==
X-Received: by 10.50.66.140 with SMTP id f12mr8357952igt.63.1368696886513;
 Thu, 16 May 2013 02:34:46 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 02:34:05 -0700 (PDT)
In-Reply-To: <CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224525>

Felipe Contreras wrote:
> But my only concern is that there's no way to
> do something like:
>
> % git fetch backup 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'

[remote "backup"]
    fetch = refs/tags/*:refs/tags/*
    fetch = refs/heads/*:refs/heads/*

What am I missing?
