From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/14] Extend index to save more flags
Date: Sun, 28 Sep 2008 19:21:22 +0700
Message-ID: <fcaeb9bf0809280521m5bd0de7aladdbb50b2b750018@mail.gmail.com>
References: <48d723bf90941_5de93fcd2ee870984625e@app02.zenbe.com.tmail>
	 <200809281359.46858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 14:22:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjvIK-0006Iq-3F
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 14:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbYI1MVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 08:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbYI1MVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 08:21:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:18392 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYI1MVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 08:21:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1120798fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gOQGB2Xe6engKyZRFeMCQm+h14pKnAhecsRFbnqVj84=;
        b=SBjtqU3zvA1f7LEJ9g6xximAr8g8rAOdHgnhZ7ZciowqujX+04WyRyw8HFANJe1lrG
         Or2CzszuOiNoNMzG2ahR2zUtqZtb8nIg2d8wE4Dd54yboFqIsluhOTsvWUDYSE5rpwtL
         VrVvQP97/FStn6dA0PGu2YIFotnnb7Bdoe/P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NPGQQH3wsmMs1dc7KEVFdtLdAam5XX10WdqkL2glLdFn1k2FBtiqSOlsMezB448Eo2
         RZW3hm9MijJSY//F/Idje4w6pWF/WD7TF7QiwSAqiKI9hYtMRyM/etV+bYpZP60s+G4r
         j/viyGAY3DMDsGQBYjFLrm9QrvtRUoJbqGvEo=
Received: by 10.86.23.17 with SMTP id 17mr3178031fgw.32.1222604482718;
        Sun, 28 Sep 2008 05:21:22 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Sun, 28 Sep 2008 05:21:22 -0700 (PDT)
In-Reply-To: <200809281359.46858.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96960>

On 9/28/08, Jakub Narebski <jnareb@gmail.com> wrote:
> So now there is:
>
>  Now CE_EXTENDED_FLAGS & 0x803FFFFF is bad because:
>   * CE_EXTENDED_FLAGS & 0x0000FFFF are saved flags (not extended)
>
>   * CE_EXTENDED_FLAGS & 0x003F0000 are in-memory flags
>
>   * CE_EXTENDED_FLAGS & 0x80000000 is 'extra flags' bit
>     (this is not mentioned in quoted comment; I'm not sure if
>      it needs to be or not)
>
>  Is that correct?

Correct.
-- 
Duy
