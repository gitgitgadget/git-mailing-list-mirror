From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] git-merge: run commit hooks when making merge commits
Date: Thu, 12 Jul 2007 09:03:44 +0100
Message-ID: <200707120903.46538.andyparkins@gmail.com>
References: <11841499201242-git-send-email-sam.vilain@catalyst.net.nz> <7vd4yy4opa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 10:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8tet-00063Q-EC
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 10:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbXGLID6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 04:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbXGLID5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 04:03:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:27501 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbXGLIDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 04:03:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so284281ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 01:03:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CsfXLAQxzAa0NrNeht2/K1Z2eD4ROm4Y3YSd6Om7WW/QMaEzRQOw135Lq3WhwGVvjmNXTJ2/UInGXvOnYz7HYMN2kMKROKooFc3kpXdSfJjwhu79XfNahDdB/kebkd2mzXlyZ+59X5g5AjCdxnJemJjMYtkTusUeorSUDe6J/M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iernuMYq9PcaBob6JLs090vcU/Uf/Z45hxDCaZj23xovTb3yX9+amSEsGvTJFCWrT4Owwe1y2wGHa8InnvTVXL0whdRNXMbmBl/o9ZyghdvwtuaVTxqr7PelqdtOOBlh5FE1Nww8g/c3SXKEImRSNGDINrYXiF0sW1BTGJUPoio=
Received: by 10.67.118.20 with SMTP id v20mr1042361ugm.1184227429743;
        Thu, 12 Jul 2007 01:03:49 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm35093134ikz.2007.07.12.01.03.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 01:03:49 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vd4yy4opa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52256>

On Wednesday 2007 July 11, Junio C Hamano wrote:

> The commit-msg hook I have no clue what people usually use it
> for in the real world, but a merge commit message tends to be

I use it for adding my Signed-Off-By automatically in my git repository.  Of 
course that's only valid for the likes of me because I can be sure that I 
only ever commit my own patches, rather than integrating other people's.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
