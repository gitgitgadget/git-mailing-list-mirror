From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/10] Change "tracking branch" to "remote-tracking
 branch" in C code
Date: Sat, 23 Oct 2010 13:51:12 -0500
Message-ID: <20101023185112.GI21040@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1287851481-27952-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:55:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jFH-0001gV-Cd
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758226Ab0JWSzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:55:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41873 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab0JWSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:55:03 -0400
Received: by gyg4 with SMTP id 4so1346076gyg.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5GVrJ37cNz1NKDfZKHzjfKa3h7zuQd8gX4TQjoApMkU=;
        b=jCqdtU4U+qnvZ8r19pMO6wDcyv/9T2HNQ6jT1HGbfZZ61Xn0aSCRe6gfFSBLL4C/0H
         bgyHptBTCK/DHy28fPWCaMkMSCAvVFhNgGAWOa2/7XHuXdz6mQg0vvRv0tFccrfrEeLM
         pxa0lDryofn/mFkCOpkniuCBxbeMyl8MmrLIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=np9ZD2ya4LRq2xpjvrl/uuX2uatqqZ4PcelrvfFNg95/NiQvz3dlq6yyREf56WYcHr
         4FiGnXF3//NL2MkAMIKDOfa+1Ikwmq9IzmP5aSJQ1J0NEIcWpSnx9wz9WnhurOfvaXlM
         jRiTMLdiirdE4H0WotHJyQ7tIjq7Sv/9ADSmg=
Received: by 10.150.197.11 with SMTP id u11mr2393196ybf.401.1287860102998;
        Sat, 23 Oct 2010 11:55:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id a32sm3677004yhc.25.2010.10.23.11.55.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:55:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287851481-27952-6-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159812>

Matthieu Moy wrote:

> [Subject: [PATCH 05/10] Change "tracking branch" to "remote-tracking branch" in C code]
>
> (Just like we did for documentation already)

Could be squashed with the previous in my opinion.  Comments
especially but also usage strings still feel like documentation.
