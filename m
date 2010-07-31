From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Fri, 30 Jul 2010 22:33:39 -0500
Message-ID: <20100731033339.GB1607@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <20100730013534.GB2182@burratino>
 <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
 <20100730195022.GB2448@burratino>
 <20100731010439.GB5817@burratino>
 <AANLkTi=n-LYGiYw=g4QsO=9GtvzHc8Vn=m99pcDR5r00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of2qe-0006i4-C1
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab0GaDev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 23:34:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52563 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab0GaDev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 23:34:51 -0400
Received: by yxg6 with SMTP id 6so860516yxg.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=StQQND9oxIqw6CCCe27DtZkffYIE+e50B4RHaufApQU=;
        b=lpwacmXCUBo/NmPXSCiTaGN5hnBptIXi6WNalfxAKU8S0jp5JDGC1GmNqyFaKjOe2n
         7jjXrXRqO6LYfllkE7hd0fyKYhDrHVeiOoAxBvazeK5KZxPVUgyKCUYE29y6uCkc+UOs
         n1hIHs52BQLE5jrsqU/w+4vFO/vr4QArus5xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SxU9+xTU3LHPNFOEg8nz2ceQwxHCsNSFhkJ44O7Ymeusu8qGI01cm7659muXURraqO
         gbdTcipQGMdH626h1CZECgrcbMmX6UgsWGr6k/lSttJ7/w60EEJtirHoT+beLESeOqzr
         Yf7yDj3HyNI1KtuodOy2/Xrv06VGVTDvpdjDM=
Received: by 10.150.117.13 with SMTP id p13mr4440276ybc.20.1280547290232;
        Fri, 30 Jul 2010 20:34:50 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id p8sm2937205ybk.3.2010.07.30.20.34.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 20:34:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=n-LYGiYw=g4QsO=9GtvzHc8Vn=m99pcDR5r00@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152297>

Nguyen Thai Ngoc Duy wrote:

> maybe we should move the CE_UPDATE/CE_WT_REMOVE removal code into
> apply_sparse_checkout().

Not a bad idea regardless.
