From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http-push: fix missing "#ifdef USE_CURL_MULTI" around 
	"is_running_queue"
Date: Mon, 11 May 2009 20:25:05 +0800
Message-ID: <be6fef0d0905110525p7e7072d3y18f5c99b782c9bf9@mail.gmail.com>
References: <20090510164431.3526.47427.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 11 14:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3UZJ-0005If-BQ
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 14:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbZEKMZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 08:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZEKMZG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 08:25:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:36036 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbZEKMZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 08:25:05 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1515583rvb.5
        for <git@vger.kernel.org>; Mon, 11 May 2009 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SU/2AXI6VhuuWbXyb0fwsypjRuaMeOpA2+7CPd7LTiA=;
        b=Q36AxyJrTYRZIt5cRIZ2Lj/xhYoDmTSnJpd3b9itDqNQdp+d62A5WT07bJuSNRmJMf
         AewxQwWoqsA2DFXJm5fbcSStwNmCkLdPn3pDcxqQkbByPkgd3OvynV7CdQrFn/C1dbAH
         dqgRTbUeIibsB/9cKjHy5bycEK1zW14aSIyks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uoin7XGHOrAePxD/b1Am/8X97LT874caHAaZYkVjgOxWGIsrz9OfUrWOfrJcDAY48c
         lzN2tahRRt/tfK5YO8zkTzNYUD1MBNr2tmbVuVxomhXRfh5uPheBzYVAlK9N1m8UaujA
         xkh3TcKbysYpCzjedJFc2dz793v+pXkNfJwhM=
Received: by 10.114.168.15 with SMTP id q15mr5486767wae.56.1242044705809; Mon, 
	11 May 2009 05:25:05 -0700 (PDT)
In-Reply-To: <20090510164431.3526.47427.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118794>

Hi,

On Mon, May 11, 2009 at 12:44 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> As it is breaking the build when USE_CURL_MULTI is not defined.

thanks for catching this. By the way, how did you catch this? Are you
building without USE_CURL_MULTI defined?

-- 
Cheers,
Ray Chuan
