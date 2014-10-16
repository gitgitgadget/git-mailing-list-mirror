From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/11] Consolidate ref parsing code
Date: Fri, 17 Oct 2014 06:53:09 +0700
Message-ID: <CACsJy8DOxFiq5S7o89KSXywqonXei6fArWqHMbv5ivpyZWiEpw@mail.gmail.com>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 17 01:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xeuri-0002AO-5R
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 01:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbaJPXxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 19:53:47 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36822 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaJPXxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 19:53:40 -0400
Received: by mail-ie0-f181.google.com with SMTP id at20so4543102iec.12
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qi6OPoUyF9RAnYUIQtknDg7TPJ12OxRSVXX8IcOEAUg=;
        b=nTCAiDUUscWEDwXjaiuUjQZic6+ieS3bcifjZrlj8oVvEnophXqZnkMDL9p4Zb9uVe
         XNflpRvu46PBCe4toEbHrhW0awgregeTMrmGruN4rQn0fk8CXYiifI8VEtIOP1qKubIb
         AGQGoJTLa6GJvVCBb+v8jL8riTcH67JJmktK9Mc8dxk+UByFy5KBrHwVF3bMqtx/xvnw
         UjtAwWwulPktOh33YC7bVyFMq9Fcy0QegZk4YMOFGhrGrxtF+3XiKxKTSg4KQ6FPdPzW
         DMqPsi/qiouU1yaH4677Ap7UflVGOnQbXWFecdNnAsQazRlCLYKDIR/CA+KyLdDi9art
         WFJw==
X-Received: by 10.50.43.167 with SMTP id x7mr25217274igl.41.1413503620127;
 Thu, 16 Oct 2014 16:53:40 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Thu, 16 Oct 2014 16:53:09 -0700 (PDT)
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 15, 2014 at 10:06 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> As far as I know, Duy isn't actively working on this, so I hope my
> reroll is not unwelcome.

I couldn't be happier that someone does the work for me and I still
benefit from it ;)
-- 
Duy
