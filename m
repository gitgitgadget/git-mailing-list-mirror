From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
	mark
Date: Mon, 24 Aug 2009 08:21:41 +0200
Message-ID: <20090824062141.GD3526@vidovic>
References: <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <20090823171819.6117@nanako3.lavabit.com> <7v1vn2yklo.fsf@alter.siamese.dyndns.org> <20090824060708.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic> <7vk50tq0g5.fsf@alter.siamese.dyndns.org> <7vmy5pojsg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thell Fowler <git@tbfowler.name>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfSwH-0007hU-Um
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 08:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZHXGVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 02:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZHXGVp
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 02:21:45 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:2189 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZHXGVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 02:21:44 -0400
Received: by ey-out-2122.google.com with SMTP id 22so545882eye.37
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8kjYKCIeu9fVkD9xpGXu1Vtto72cGQzCVrsz/nRwb4E=;
        b=UU25uGK7inHDSQsFgUAMeUCL+l5XdNel/aRcWbMqR8hsnbZA8soo5r7OD1+8TfmDe3
         OnF4P+hqNPOLCCRNfQvjJGPvd7jDLSAOVotVvs5FEwpDbDxo9gJIertIGveZq2q90vrE
         pt7GT+y5zEPSb5Rf3Rz38/tF5H4qosK4GwYyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SJBRHqurJ3ABBiP37jlp+dbLZTbNLd+0lDf7cZB1Bfar61RJUCElE23BHvwOc83e6X
         +5fSxCWJf4xpb8PpooFkXULVSPD3auiDzrSZY5cNYCXDS+ls3rP51+S3fT/YuATru4Op
         YGTpI2ejAmMDT5xQcEDwLu1p3MlNgv4FVfIhU=
Received: by 10.210.43.17 with SMTP id q17mr2956468ebq.0.1251094905268;
        Sun, 23 Aug 2009 23:21:45 -0700 (PDT)
Received: from @ (88-121-114-119.rev.libertysurf.net [88.121.114.119])
        by mx.google.com with ESMTPS id 28sm10214994eyg.2.2009.08.23.23.21.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 23 Aug 2009 23:21:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmy5pojsg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126909>

The 23/08/09, Junio C Hamano wrote:

> Try this patch, perhaps?  I forgot to reset the mysteriously named s_hdr
> buffer.

Nice. Please add

	Tested-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>

> Does anybody remember what these s_hdr (vs p_hdr) buffers stand for, by
> the way?

Has been added by 87ab799234639c .

-- 
Nicolas Sebrecht
