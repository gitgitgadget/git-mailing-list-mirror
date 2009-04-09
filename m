From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 13:43:26 -0500
Message-ID: <b4087cc50904091143s4ab8ccdfsc9848b70b23b00d7@mail.gmail.com>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
	 <20090409161756.GA12910@vidovic>
	 <b4087cc50904091027l4656a6adv6a72bad0a747cdc1@mail.gmail.com>
	 <20090409174547.GA15767@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 20:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrzFP-0007WB-VD
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 20:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760016AbZDISn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 14:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbZDISn2
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 14:43:28 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:27913 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbZDISn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 14:43:27 -0400
Received: by qw-out-2122.google.com with SMTP id 8so883819qwh.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gfSkmQwXBkNrhTwY4khJEQvpVJJur+S5YgbVAckLs3M=;
        b=mi7A08cRsMKwdQJ3rsgd5i3rV4BIqc2MslyWm3LLfKYldJLBNGanyrwosGwb9QEuia
         97G0plLnihg1wXrXt4dUPVP2Or8Bocdbi08XAh3Dq14skvVymDLHYrsQoN3ia+gLTWNF
         9mU9Faerd8U7RUGpPx30gXkbkEWyphx1TGoA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Nuy1QE/1/sfzVRnaQoBA2PWbDfaY7sp5nWFGbxLcBv1JDrhB58bvPL2ljxe86/TJwm
         PdRgMygrD5Lt+tx31bvoFHgKZuOsNBwbbNQCvkUmHuZx+5zHrWbTygwOouUNTjYiWcWJ
         /2f7/Yg5IgA55QspxjChau+0fRo9EeyQUkozE=
Received: by 10.224.37.147 with SMTP id x19mr1934421qad.386.1239302606157; 
	Thu, 09 Apr 2009 11:43:26 -0700 (PDT)
In-Reply-To: <20090409174547.GA15767@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116196>

On Thu, Apr 9, 2009 at 12:45, Nicolas Sebrecht
<nicolas.s-dev@laposte.net> wrote:
> But we could forbid the use of --delay with non-chained emails, no? Or
> at least, warn it should not be used.

Ah! Good point! I'll add that.
