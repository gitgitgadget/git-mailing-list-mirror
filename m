From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 0/2] jn/gitweb-blame fixes
Date: Thu, 19 Nov 2009 20:05:15 -0800
Message-ID: <4B06157B.10203@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911200005.08841.jnareb@gmail.com> <4B05EA37.7060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 05:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBKlD-0003S6-Mm
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 05:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258AbZKTEFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 23:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbZKTEFN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 23:05:13 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61758 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731AbZKTEFM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 23:05:12 -0500
Received: by yxe17 with SMTP id 17so2651079yxe.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 20:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=m9eMFsDAZm6rN4eLjkEGFez2mVYIW8MtkJKYp2Cf6xY=;
        b=qiduERCId99DDKU5RJ+VF+L/7Id3tCchrUAEwUTHyzl5MmDMdSygTx1dOUqxRY9PA4
         bqa46gYqTUX9LxX49TDvIWj/RXyXFasTXXG1dRNYtWqkU8ZqRsNgl/LEHXTx3RvYucwZ
         62WzMvLeP18X+jFSlsjRpFRYwbOovUS5W/GWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=fbD4hso/EXYMCNYBQhlgG7yRbY3edok3sV9yAJS5aLNPhBrgEKulpNNREsmKK2Gtrr
         IJuvXSOdFoiPkE80038zIloQTkPRFC+afam5S0YD66aBDS7t4tTt6JVbRB6jq+liMRC5
         4f3tVIOsYhWOj/o4J7tPb3J52bIT7KFHvaP1w=
Received: by 10.91.50.28 with SMTP id c28mr1451369agk.67.1258689918154;
        Thu, 19 Nov 2009 20:05:18 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 6sm575736yxg.48.2009.11.19.20.05.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 20:05:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <4B05EA37.7060704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133303>

Stephen Boyd wrote:
> Jakub Narebski wrote:
>>
>> Thanks for working on this.  Also it is nice to have incremental blame
>> tested for another browser, beside Mozilla 1.17.2 and Konqueror 3.5.3
>
> For those following along, Opera-10.10 has been tested and works.

Ok. I tried using the version of incremental blame that's in next 
(e206d62 gitweb: Colorize 'blame_incremental' view during processing, 
2009-09-01) on IE8 with no success. The page loads and the file is shown 
with line numbers, but the progress is stuck at 0% (with the &nbsp; 
showing too).

I then tried with my two patches applied on top of e206d62 on IE8 and 
still no success. The page loads and the file is show with the line 
numbers but still stuck at 0%, but the &nbsp; is gone at least.

Do you have access to IE8 to confirm?
