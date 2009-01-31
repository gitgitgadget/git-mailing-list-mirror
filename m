From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 0/3] gitweb: make static files accessible with PATH_INFO
Date: Sat, 31 Jan 2009 03:04:50 +0100
Message-ID: <200901310304.51205.jnareb@gmail.com>
References: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 03:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT5Fi-0007gv-GD
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 03:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbZAaCEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 21:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbZAaCEx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 21:04:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:5436 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZAaCEw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 21:04:52 -0500
Received: by fg-out-1718.google.com with SMTP id 16so168845fgg.17
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=V/ir3oImoVgtRZZEYkoV+WsMv4CMK7XwsmtPLIYyr1k=;
        b=B6rLmZs2O6PxUr5LPGzFOFoqeOexBXG8gP+SIdwuCfNOsVSPWUVLOsc55sQNQ+cwA3
         +dOptXIrPuyhnOBhrZuv7qWMTcpCcFqgLWCsdhvTFrnnn0kzZQei7gc5RDoSAdoCeZ/S
         QPHXEV1tetMqK0+/H3oXyTzzLr8gAm5LpYMRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MpcJgKCqX5U4EH9bgRWC4rVtwffcScmgVHFcpOkrz3uUrt0euVB5lKx9GUc2Xk8IRE
         xnwUiD40shcvznNqF4mxU1DFNRmThAEHEav2P2dtTu1MwJgurI6266x0U7kfBTazOJqW
         0X0sL6sJY3lfFTvUWmtaScur7lRapIs6aEZKU=
Received: by 10.86.97.7 with SMTP id u7mr1001552fgb.34.1233367490607;
        Fri, 30 Jan 2009 18:04:50 -0800 (PST)
Received: from ?192.168.1.13? (abwh184.neoplus.adsl.tpnet.pl [83.8.231.184])
        by mx.google.com with ESMTPS id 12sm999555fgg.53.2009.01.30.18.04.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 18:04:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107903>

Giuseppe Bilotta wrote:

> This patchset includes
> 
> 1. the single patch to make static files accessible with PATH_INFO, with
>    the same quoting standard as the nearby code;
> 2. an additional patch that extends the README with some examples on how
>    to configure Apache to use gitweb with PATH_INFO enabled by default
>    (and gitweb as directory index);
> 3. the repeatedly recommended comment fix to align comments to code in the
>    git_header_html() sub.

I like it. Ack for the whole series.
 
> Giuseppe Bilotta (3):
>   gitweb: make static files accessible with PATH_INFO
>   gitweb: webserver config for PATH_INFO
>   gitweb: align comments to code
> 
>  gitweb/README      |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  gitweb/gitweb.perl |    9 +++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)
> 
> 

-- 
Jakub Narebski
Poland
