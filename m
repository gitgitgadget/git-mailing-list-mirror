From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Wed, 27 Mar 2013 15:09:21 +0530
Message-ID: <CALkWK0=mTOcHTLAqhF0JpqkrXuO5s3HHfxA-V_gsBv92W=HSMA@mail.gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-6-git-send-email-artagnon@gmail.com> <20130322145640.GB3083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 10:40:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKmq5-0008UF-2m
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 10:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab3C0Jjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 05:39:44 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61051 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3C0Jjm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 05:39:42 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so7046906iec.33
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TbcibQUft+O3ravo4e+H2so7nqcCphNV4vSO0PJH+88=;
        b=MK5NVC0m3cjzy41qDZE43Aaa2NDcg1KftBZpSYzn9lgs81kwVSvaxGjHuwrQjEL9A2
         mZrUjfrp5b7ESoXdDBJzNi9xBARF60FGW/z0nWbYk8thSqckDy9oV0TfEIsIMwc6qnvA
         MGziA3h2Qms1knN2DmIu9xuNh6/0tc1MyxVaBwSNDgfrnTxlPFzS8V1nnFrpQU8hfxgA
         DmgbJdUmEnzJRCJa4u30XG7vcNTZdTRAZcfhAnfzUnk03Smj/12xItH7cBLh3NZ8SVkg
         k9yqugcm1LeFTKhPBTiCDrcCABe4lPmRZSYux7dZ1Phc17Zb9n9lwL7tAWSgMXykji8t
         3Q5w==
X-Received: by 10.50.17.166 with SMTP id p6mr3748094igd.12.1364377181848; Wed,
 27 Mar 2013 02:39:41 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 27 Mar 2013 02:39:21 -0700 (PDT)
In-Reply-To: <20130322145640.GB3083@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219243>

Jeff King wrote:
> but also possibly just move it with the other remote parsing, like:
> [...]

Done.  Thanks for the dose of sanity.
