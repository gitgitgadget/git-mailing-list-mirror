From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 17:53:04 -0700
Message-ID: <20130430005304.GG24467@google.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <7v61z5hzqg.fsf@alter.siamese.dyndns.org>
 <CAMP44s0rT1097=481aSH=Gy465zb2Bd_xLv=Xvte-GHcamWLyA@mail.gmail.com>
 <CAMP44s0mHxv24GtpY2KzmrKQjZo+97FNN_T7tQk_peyWmusMWA@mail.gmail.com>
 <7vsj29eysv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 02:53:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWyol-0001Jh-6a
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 02:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759799Ab3D3AxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 20:53:10 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:44931 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759744Ab3D3AxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 20:53:09 -0400
Received: by mail-da0-f52.google.com with SMTP id j17so3184703dan.39
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=AVFNhxL88NVZOu+IbCPZ5jLJfB+l/Uuw0rLWbilo6sQ=;
        b=qlxg0xUmu6VBhWNlswdG0JrCXvIdV4zA2M92XXi8c2Gf4pPUU+1yAS4L2lpqKH3NEi
         UTe/EaEZHpVoHIPC/4hC0VezHOXCDT9+UHoLeQTul6d+U2A7X7KQmHfkKaIBPtG+ycyU
         pbozS6JuLlEdlLaMg4HKFebsCXXyKySrUaJxfim6osPRCbnTathLNJX1crfXxH9DGGxr
         KOzKiyUSswfNdsiHskPXuOcuDFNv98w4p870eJV4eTeq3X56zQ9DXEYZNJl1kc2MtfsQ
         XQ31IH+l/9DxlPS+MMvopya8Z24PSYGRHLop4YeV6uk9q6jNXk/7MldlTqOylRQ/CjsC
         Y0Ew==
X-Received: by 10.66.147.103 with SMTP id tj7mr44582493pab.82.1367283189258;
        Mon, 29 Apr 2013 17:53:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id uf2sm6005553pbc.41.2013.04.29.17.53.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 17:53:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsj29eysv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222891>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Never-mind, now I see the difference, still, I don't think it's
>> relevant for this patch.
>
> I don't either. With the precedence of @{u}, @ does not need to have
> anything to do with a reflog. It is just a random letter that casts
> a magic spell.

I thought the convention was "^{...} is for operators that act on
objects, @{...} for operators that act on refs or symrefs".

Which works fine here.
