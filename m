From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] merge: Make '--log' an integer option for number
 of shortlog entries
Date: Tue, 31 Aug 2010 09:32:36 -0500
Message-ID: <20100831143236.GC2315@burratino>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
 <1283226800-28980-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 16:34:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqRuw-0005ZO-Ij
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab0HaOeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 10:34:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:56674 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757414Ab0HaOeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 10:34:25 -0400
Received: by pxi10 with SMTP id 10so2451076pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CJ0MSVwBvvav6/6EM0ciHaeDxtAbkIPChuiMRYZXato=;
        b=WYHF1SMOfdGR8P1MqIXjydebMWIiDNQYQrQLwhvdY5o+TQsdq4eEn22hStCK3u5U3F
         +2NAKjJlA+tvFskXfB0xUmsM5e0R1bgNvlA0hprPun/NP1vxKQj8WMSYzLkgD1Ol52Yo
         /jldW0RGDZ108xumzz5tJrRITb7fFdONOtzIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DfmZHR/yJGB209Pycw6mp/UG/dvKQj4Av3vXCW9JeIkE0qalqY5B2oYqbyaauqvKjx
         gGGGdXiyGHysUYQSFlXry1P910oMN3itTUxAgC1mLN3SVzihUPhfwmtFQ5oG9OU0V+a4
         lcc4E0U8wIlBHgzQoHm9+tHUc3YmmMX3pWyJQ=
Received: by 10.142.136.10 with SMTP id j10mr6072140wfd.62.1283265264553;
        Tue, 31 Aug 2010 07:34:24 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm8853980ibe.11.2010.08.31.07.34.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 07:34:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283226800-28980-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154901>

Ramkumar Ramachandra wrote:

> Change the command-line '--log' option from a boolean option to an
> integer option

What does "git merge --log=-1" do?

It looks like you have made "git fmt-merge-msg --log=-1" equivalent to
--log=20, but it might be better to error out or use INT_MAX or
something (especially because of plans to make -1 mean "infinity"
later).

Thanks for your perseverance.  Aside from those two nits, the patch
looks good.
