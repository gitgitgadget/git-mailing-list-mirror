From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] fmt-merge-msg: Update fmt-merge-msg and
 merge-config documentation
Date: Fri, 20 Aug 2010 18:09:50 +0530
Message-ID: <20100820123935.GB9448@kytes>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
 <1282307041-19681-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:47:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmR0b-0004Ru-Kv
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010Ab0HTMmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:42:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49204 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab0HTMmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:42:08 -0400
Received: by pxi10 with SMTP id 10so1185493pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aMC4GGaJ82GUO8u7/q+0BV7uvPu2s+L+NyJBJRAQxe8=;
        b=szzUSPTbU1WNeVB0JwimtVgXtebnqiM6y0aTSpnvT+TmsdJ0f/SNrrzrh9MWZ7zo4E
         FeH1LnOtxqkFiT2yT9yS02jxZsboEIra45nV/6Uqyzwgz10KouZl4RPN1JyRVIcaTP8w
         jVxxfraJJqM2r8w4G1L5PRiwZIVi8FG4EXZ9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VN9mIsBB2/ABFTHOmQLyfxi6Sq8DuX9WDmd9OoKX/UWLX5SPraTzdssd6catsnQtzM
         JrfeGP5plZalnYdIgyv/da0k/bqIP3Tb8LkyQOvzaUPUI4Avfwt0UoEWDKYjW5al3H1r
         H0sRNskB/d7IH3fkos0l+qYZDN0rQAB+8v4PE=
Received: by 10.142.201.9 with SMTP id y9mr535487wff.24.1282308127663;
        Fri, 20 Aug 2010 05:42:07 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3194818wff.7.2010.08.20.05.41.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:41:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282307041-19681-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154024>

Hi,

Minor mistake: This patch removes the --summary option from the
documentation before removing it from the code. Swapping this patch
with part 4 will fix the issue.

-- Ram
