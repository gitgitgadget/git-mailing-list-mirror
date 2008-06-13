From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT RFC] Commit behaviour
Date: Sat, 14 Jun 2008 00:41:33 +0200
Message-ID: <4852F79D.4080100@gmail.com>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com> <4852EFBF.6000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:42:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7HyZ-0004wN-FD
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 00:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbYFMWlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 18:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbYFMWlh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 18:41:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:60380 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbYFMWlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 18:41:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2893883fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 15:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8SJKcah/iDAUHhKpMlAAKKPUAe7itq6Dsqw24il8Nfc=;
        b=TXRVL7au7qFL+lHThnZM6fI5IbCeKy4jZdsCXBCMlJTWzPtbUDDsgyRdD8FOZZSYvm
         //3BSCQmRSVfSzZIdV1qxwJfEkJdaciZcXDePeCF4D1ctq6Fbzf9OcKfT5U8f/Vb0RJS
         BG9t6gh6mle1liOxXXqHcxt0vWd39C8rNZCw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xCY1iGk3TohEdlE3NMGDm5xlYZ1rRs2GujtboRVtk+DA+YWceyD2m0IsrxebOHHSbs
         RP0zbaML9ohdxUWPNB7Q4rOHIP24Rnv/CNxVyzE6h+H8jcf7XDMEGzvCn6QRjLv9d+0g
         2fSl/0iEL9PE7AQWDZfRXh7+0ol5hvnNmRM4Y=
Received: by 10.86.99.9 with SMTP id w9mr4688895fgb.70.1213396895072;
        Fri, 13 Jun 2008 15:41:35 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id 3sm6780165fge.3.2008.06.13.15.41.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 15:41:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-3)
In-Reply-To: <4852EFBF.6000406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84948>

> Robin Rosenberg wrote:
>> Then we could ask ourselved, should we do something similar for Checkout
>> and reset too? I think that is not as important as those operations are
>> much less frequent.

Hey, by the way - do we already have some action for checkout? Did I 
missed something?

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
