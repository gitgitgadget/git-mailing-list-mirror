From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v5 2/5] git-submodule summary: show commit summary
Date: Wed, 12 Mar 2008 16:27:31 +0800
Message-ID: <46dff0320803120127o62d484eaw54ecebafe88a0eac@mail.gmail.com>
References: <1205243539-797-1-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-2-git-send-email-pkufranky@gmail.com>
	 <1205243539-797-3-git-send-email-pkufranky@gmail.com>
	 <7vabl48tt4.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803112128j23337873jf1fb12f5716151d8@mail.gmail.com>
	 <7vmyp479i9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 09:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZMJn-0008SD-CU
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 09:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbYCLI1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 04:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYCLI1d
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 04:27:33 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:1052 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYCLI1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 04:27:32 -0400
Received: by an-out-0708.google.com with SMTP id d31so674356and.103
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aLwxpQ/S+wIXMMqk0L7W3sI+lf1Ou4U683rUutzld4Q=;
        b=IyFHLTexGPdEZ+achKMhA5XO+k2JXsOEOjHbpai1AmJjhELN1BXfgrtdYLTpDuunCwyFFvMT7rjmjHIGdE7Uv3Q+kPN7ogvNZvVLOIe9/LAWHW+0or7T6jPWcSGGYK+rVB53SNaOwh+bnFXKFQkjXG2jyLjDbAvjN8wYmNWKJ5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jYxEqDwOW5df27DalNq71d0Lza9mBpE48+spfBCHvJmpjoFEbsQce5EdxKj0NBJj7ein8aHMGoQY/kAoQiLnPDkvK399vFhaVB+Nvojbr09UmcVeKo+vIwgB9PliQVHnPRX+oWmJwBrGJQlOLkNzbOP7hH+iAjg8jVTPNbCgzkg=
Received: by 10.100.165.13 with SMTP id n13mr15429488ane.116.1205310451297;
        Wed, 12 Mar 2008 01:27:31 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Wed, 12 Mar 2008 01:27:31 -0700 (PDT)
In-Reply-To: <7vmyp479i9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76939>

On Wed, Mar 12, 2008 at 2:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ping Yin" <pkufranky@gmail.com> writes:
>

>
>  They never appear, as git tracks only one executable bit, so mode bits for
>  regular file blobs are canonicalized to either 100755 or 100644.
>
>  Don't you ever see 000000 mode bits here?  There is no case arm for that
>  in the code.
>
000000 mode will appear for added or deleted or unmerged modules. The
deleted/added case has already been handled. However, the unmerged
case is not handled yet which will appear at very low frequency. So
this case can be delayed to handle.


-- 
Ping Yin
