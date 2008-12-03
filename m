From: "Tzury Bar Yochay" <tzury.by@gmail.com>
Subject: Is there a way to control the number of revisions will be saved by git
Date: Wed, 3 Dec 2008 13:01:10 +0200
Message-ID: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 12:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7pV7-0003Dm-H8
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 12:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbYLCLBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 06:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbYLCLBN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 06:01:13 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:5528 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYLCLBM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 06:01:12 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2880433fkq.5
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 03:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=YDSDYmYBXY/RWoRluR3IYElQiLaWbSR5HF3+P8HnM8A=;
        b=TJgJWwQqbgISE/r2v3vX7pIpDZjorUiDfko4ODTOOLwS5F9NhGnFUOWgYbngX6VH96
         SVZtgkkkgY5JhmTnr5CUuOKDwpGSDa3n0wUA//u+wLtmoKNtAftLwcpYrj2mt+fGTu+b
         9t2Hk4UrcYFvzmB60i/7OkPGl2iMnpv6WDQmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=iCIvxDAktlVXff30sKYXTAwnePZU5wDXcwySG7cFZMS76EFkqHm8s4kXK5dz9+DMmC
         R081r3OGOua2ygD+UjiySgx7zlgPvakUj1IYYlcg01AINwAm45aXV7/7Tw6qZQqNYN7/
         XIK8N/NSowKToFGyLRjLy0sBPXSEBSWPayPBc=
Received: by 10.181.205.15 with SMTP id h15mr4355633bkq.19.1228302070195;
        Wed, 03 Dec 2008 03:01:10 -0800 (PST)
Received: by 10.180.249.13 with HTTP; Wed, 3 Dec 2008 03:01:10 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: 2102514725ccafdc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102239>

Hello Happy Gitters,

Say I wish to save only 100 generations back (per branch).
Is it possible to configure git so it will save only N records back.

If git cannot be configured for that, Is there a way to shrink the repository
manually so it will contain the last N generations?


- Tzury
