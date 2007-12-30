From: "Ping Yin" <pkufranky@gmail.com>
Subject: How to find a commit containing a given sha1
Date: Sun, 30 Dec 2007 18:39:34 +0800
Message-ID: <46dff0320712300239m54ab8280w9c1ec6347f095b40@mail.gmail.com>
References: <46dff0320712300238p67e82c66r5bf49900dd21aefa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:40:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vaL-0002YW-Kr
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbXL3Kjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXL3Kjf
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:39:35 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:8845 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbXL3Kjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:39:35 -0500
Received: by py-out-1112.google.com with SMTP id u52so8536859pyb.10
        for <git@vger.kernel.org>; Sun, 30 Dec 2007 02:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kjhSMKS8hB/xml5Idhr3wEgjmVknpiTmiVPG0fyjFZY=;
        b=RFYaR8b591vWmub/BNoxXTg4bE5CHDKSL2fEBKanAy7A5eKRfKy4ScFRzVIAbaZJ/A3upqOn04+Im1UDXRcnxsaWqPprwV2y9ZEyU9CXUCTG3e3i9ncfZrhZx2A6q+kE2nMeGdU4DCkpmUveoQpvI92dtg/iKvtYjBzMpWkQSPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9h3tg+9T8iepegPwonB81paM8sN01/8ZIfPe5ZW+eA/mWj3nkyDdFgkxooFWgf9oY6amD9b3rMpv1ozcVfBtscVo57iPgsqCja2SkW1Qxbb8Msf1blYhSmk+XqhJYG1t1gRQ06Fj6JBZOL8WIdEBU7oqcV5NZwSpt3LwWBV08Y=
Received: by 10.35.127.9 with SMTP id e9mr11135309pyn.21.1199011174605;
        Sun, 30 Dec 2007 02:39:34 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 30 Dec 2007 02:39:34 -0800 (PST)
In-Reply-To: <46dff0320712300238p67e82c66r5bf49900dd21aefa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69345>

Given a blob sha1, is there a simple way to find which file it
corresponds to and which commit it is contained?

-- 
Ping Yin
