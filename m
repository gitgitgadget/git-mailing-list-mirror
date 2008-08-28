From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] dir.c: Avoid c99 array initialization
Date: Fri, 29 Aug 2008 00:56:19 +0200
Message-ID: <81b0412b0808281556x24fe1446l738310daf74d619f@mail.gmail.com>
References: <7vwsi0dh61.fsf@gitster.siamese.dyndns.org>
	 <DvgiWt6vf5dOJWwhJg6Uvvb1c1lr9AZ9KS6iObwhTbjxnzKL45PkCw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"=?UTF-8?Q?David_K=C3=A5gedal?=" <davidk@lysator.liu.se>,
	"Andreas Ericsson" <ae@op5.se>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYqQe-00033g-Q4
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbYH1W4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 18:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbYH1W4U
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:56:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:29471 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYH1W4T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:56:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so596524rvb.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EzfVYgyahucNleOwMPlvSWsbDdvLIH85M2CrlLChQa0=;
        b=ri+oiMRec2YXgmCeZygNhNcbUs8iE290hUs1DLphYYo96Ea2KLmEM2ApMZRjM8nqL6
         phsSWWlRRStnTyn8tRNZoLIAHONWvBPyljQaW0ohEVsGwVjI+3Fo5Al2/vqgI+tRBYWp
         fipbjwYSdbQxq7kAGQtjXBJN3IUv8jov4Ml5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SEWzY8hdDie5WSQyJ0P8hJyNTUh5/GrXaiC7uB2P0La9DyQo9mInV0lHJBumhjys4N
         QS0DGjdCDvV5Cb6Mcx7W7jblcJpLctVfU90sz5i2sT66yUwka/oXdsmPSumEOhv0nMvR
         Klb02Nmr/Nh0wjvZfRczlWpsK8jJthJ2f74lQ=
Received: by 10.114.25.19 with SMTP id 19mr2014809way.225.1219964179120;
        Thu, 28 Aug 2008 15:56:19 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 15:56:19 -0700 (PDT)
In-Reply-To: <DvgiWt6vf5dOJWwhJg6Uvvb1c1lr9AZ9KS6iObwhTbjxnzKL45PkCw@cipher.nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94196>

2008/8/29 Brandon Casey <casey@nrlssc.navy.mil>:
>>
>> I think it was an unanswered question about stealing one bit from
>> ctype.c::sane_ctype[] that kept the discussion in limbo.
>
> That seems easy enough. Anybody got a 5 character abbreviation for special?
>

SPECL :)
