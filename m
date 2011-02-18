From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Commit/merge messages for binary files
Date: Fri, 18 Feb 2011 21:30:42 +0100
Message-ID: <4D5ED6F2.8030008@gmail.com>
References: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com> <vpq39nlsb3r.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 18 21:31:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqWyn-0005L3-IZ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 21:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab1BRUa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 15:30:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50573 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab1BRUa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 15:30:58 -0500
Received: by fxm20 with SMTP id 20so4192554fxm.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0YG0UWmkFlanmkN+K/R2D8XJLr042SwVTvUGa2VISco=;
        b=EImIU9HzSJS9yTMGh1rWQXcCZYfk6pRof44ithnWBIhPJKiMaSY5ZqvtrxDIT/ogpI
         f/x8UgMG9Tno4+Y1pYFDSVKUIbPdJgeoE6nxFnY/R9+FLQA3YS+XEOcLTtc3kYg5rKoz
         oFmY1KfXAXUCESc2zTFntrbK2X+85qyLYnZ7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BbirY5xZ01ptNGlnIqd+hojcm8DFR5+51CobYCsHFGV12aAR4CBkkoqMXAWxo7fy7T
         YKU2ffX2VYsGTaUzoe07gfEcX1nSjjwa9B1arOyr9R9jCXV9Eu9Y2s9An4Ae8QedOnlK
         2VsImppJhCAsVODY18YrFoCOTvKGa8T8mC69M=
Received: by 10.223.116.1 with SMTP id k1mr1535727faq.51.1298061050824;
        Fri, 18 Feb 2011 12:30:50 -0800 (PST)
Received: from [192.168.1.101] (akw69.neoplus.adsl.tpnet.pl [83.26.26.69])
        by mx.google.com with ESMTPS id o17sm730014fal.25.2011.02.18.12.30.49
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 12:30:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <vpq39nlsb3r.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167228>

W dniu 18.02.2011 14:53, Matthieu Moy pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> Hi,
>>
>> there's a different output when committing change and when merging
>> change for a binary file.
>> Do the insertions/deletions have any meaning for binary files?
> 
> No. They're inserted/deleted *lines*, and that wouldn't make sense for
> binary files.
> 

So it's a bug?

-- 
Piotr Krukowiecki
