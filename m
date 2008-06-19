From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Thu, 19 Jun 2008 20:25:32 +0200
Message-ID: <485AA49C.5060607@gmail.com>
References: <1213796224-995-1-git-send-email-michael@ndrix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Oph-0002G0-AH
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758206AbYFSSZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758205AbYFSSZH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:25:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:57057 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757192AbYFSSZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:25:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so453604fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=ninmPTJqETma/NTuvDdSTuTo1wt5N+httt7AzkuoBYM=;
        b=riT8rcp34jMNIyYx36Tmfeb6XUD2mxBl/si3nyqtFNZAB8V2KTc4pZ4Pif9CCSSA+M
         ozsZOKKed2Gq1Z6XM20XU8e8D99u7nn/Ho1lm6tc74klRjz5l9DWVSgy4ffemZW35red
         ALSsbMupSKitGe52yIXoXtEX8kVy576HNZ1Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=ighEvsJybbxvHLFyS8EP2zEuz6ItaZ2Vonypxy6mrJsqpRvQK32jAlm5/zMULXRhdr
         ewPrWqSkb2ffn+fCHhoKazlbRNjRMRjOf+7ZGZm4oJdQjlglxvkC/OqsgqC0nyHA7wx0
         WIRrE8FofX3TGLvEB3Ho69c8qUNb+8XWYQqr4=
Received: by 10.86.80.5 with SMTP id d5mr2568307fgb.19.1213899903272;
        Thu, 19 Jun 2008 11:25:03 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.94])
        by mx.google.com with ESMTPS id 4sm1501702fgg.9.2008.06.19.11.25.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 11:25:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <1213796224-995-1-git-send-email-michael@ndrix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85506>

Michael Hendricks wrote:
> Instead of using IO::String to create an in-memory filehandle, use
> open() with a scalar reference as the filename.

I've now sent a new version of my script that uses File::Temp and only 
depends on Perl 5.6.2.  Thanks for making the start!

Jakub Narebski wrote:
 > [...] Lea Wiemann (who should have been CC-ed, by the way).

For the record, CC'ing me or not doesn't make a difference if it's 
posted to the list (I don't actually notice whether I'm CC'ed).

-- Lea
