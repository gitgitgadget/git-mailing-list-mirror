From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 13:42:13 -0700
Message-ID: <20130327204213.GG28148@google.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <20130327192630.GF28148@google.com>
 <7vppyklhot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:42:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKxBJ-0005wg-C1
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3C0UmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:42:20 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36935 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3C0UmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:42:18 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so1684872pab.38
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SYH4VxEVyr6P9OcFqgSyGCNLXLypu9ux/9jG+npJXGM=;
        b=04iU1ofsWRBWvKGcMEp1kDG1HzatuGdm2tyBgSBTxZkTEm08gQ6LuvHL6JqYYqvfZY
         EcJBn7hryl/I/0UnyBOPEk32q6XBPv/OmcCLlQeuZoF1F7r//aCvBrSgFlVLsM/FV4OW
         WC9J14h8aTNNG+D8A0wwwgj0SowQvFiQj5dIxKKngLAAimknc6BlU8Kgb2LbG0VhCe4B
         d3X1xmkjkupuBEcVD5fLgdXouR3gpSCzt5pxVcHKyxCBNo6Z1DF+8DtacWVhi/deJTht
         P35x/+zy6wx+5kqAsaIBpNcv5ZSGobS0Vxv83RIVZf3ATdH/imqW0JMDrxLm8hGcF72Z
         B8hA==
X-Received: by 10.66.190.2 with SMTP id gm2mr11544291pac.25.1364416938420;
        Wed, 27 Mar 2013 13:42:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id tm1sm22662089pbc.11.2013.03.27.13.42.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 13:42:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vppyklhot.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219328>

Junio C Hamano wrote:

> I however do not see the implementation detail of having (or not
> having) separate $GIT_DIR for component projects having anything to
> do with the goal of that ideal.

Yeah, I think the current gitlink-instead-of-full-git-dir-for-submodules
implementation that can allow "git rm" to remove a submodule and
"git checkout --recurse-submodules" to later revive it is good.
