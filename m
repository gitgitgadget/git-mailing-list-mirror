From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [PATCH] git_blame2: fix rendering on Firefox 3.0b5
Date: Tue, 22 Apr 2008 13:46:45 -0400
Message-ID: <e06498070804221046j5b9d4edbwe798ddb44f4fecf8@mail.gmail.com>
References: <1208821391-7895-1-git-send-email-stevenrwalter@gmail.com>
	 <200804221905.41963.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:48:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMac-0001cc-UK
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbYDVRqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756229AbYDVRqr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:46:47 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:3538 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbYDVRqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:46:46 -0400
Received: by an-out-0708.google.com with SMTP id d31so617626and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tBeoIgHJT0z8WcbBpd2ixDFRNl6RTPTXpXoUhE4T7rc=;
        b=vIqQMv8R6Mp0TxowbPn6L9x2tKiL9moopvvqJO3IMz5p4vDDxr/j6DXWS0cdS3N9NM0O3gJR5YUFm99foud72f9NA3yA7fzhv6H89cQZjNaII7p8h60GXTQps/uhYckHFuPxbggU3WGaAkvrehTYcxWcpQmapUGG/xjQ7ed6K+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJvQXyce4tyi+a1OxDN1YozZraj6Yq0onDUDlO/tHWJEFniUiCRfORrQ+fs9m1Bztl6fl8x/t+o3rWOvqzXDYwvCZpn2wAlos5g6rzriCtxOlTIqazJ+m6LkQEzxOMWnLJpMWUfcMpa86aUHRyr4K/W84j7ZldLh70WjfJiBcFY=
Received: by 10.100.13.2 with SMTP id 2mr787014anm.137.1208886405553;
        Tue, 22 Apr 2008 10:46:45 -0700 (PDT)
Received: by 10.100.163.7 with HTTP; Tue, 22 Apr 2008 10:46:45 -0700 (PDT)
In-Reply-To: <200804221905.41963.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80150>

On Tue, Apr 22, 2008 at 1:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 22 April 2008, stevenrwalter@gmail.com wrote:
>  > Using variably-sized rows and rowspan does not render correctly with
>  > Firefox 3.0b5.  Instead, make each row have the same number of cells.
>
>  Beta version of Firefox doesn't correctly render perfectly valid HTML;
>  more, the way rowspan was meanto to be used, see example in
>
>   http://www.w3.org/TR/html401/struct/tables.html#h-11.2.6.1
>   (subsection "Cells that span several rows or columns" in HTML 4.01)
>
>  and you want gitweb to generate invalid HTML?

What's invalid about the way my patch generated HTML?  It renders
correctly on both FF2 and FF3.  It may have been fully correct before,
but is it any less correct now?

Conversely, I will also file a bug with Firefox regarding it's
apparently-broken handling of rowspan.
-- 
-Steven Walter <stevenrwalter@gmail.com>
