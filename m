From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 6/7] fmt-merge-msg: remove custom string_list implementation
Date: Wed, 31 Mar 2010 23:08:32 -0700
Message-ID: <4BB43860.8090003@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com> <1269414964-9518-7-git-send-email-bebarino@gmail.com> <7vzl1qwfno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 08:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxDa8-0004rM-D5
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 08:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab0DAGIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 02:08:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35355 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0DAGIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 02:08:37 -0400
Received: by vws20 with SMTP id 20so430720vws.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GpFF8ri8KQjtUzVMc5mlXn5QFpkjnRtreRDbqWoCA7o=;
        b=tssbvwGhbQnbSLWRK/1IE+xGO7KoEObYAZY4eC8y/fQWWnoVHuxd5xQpG0duYI0ejM
         ZKR7ImwbvENvhhP7cCGqUD9Dr5cua5emxeoHtVAQCxWkDAO/Na6lc575WN/nP0guiyor
         JDPIicGXqNME7WjfDGGDAf1IIlnP2/xZx7OCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xl8MWWE+1om+4fYIPOxAXVJ8jhNtrKfSefCUOex/sHA3uMsenoJkAUohJxkMkLOTSL
         NNEGRKz/sVbuO2OprY5SnqC32Ybpdk12qAqPIyiamabvv9AjIOMJjqR0I7CK4csK6qDs
         lFASVPfG2YwZhBRYQoORMlV2aw3hz/XuQrpSM=
Received: by 10.220.158.12 with SMTP id d12mr192050vcx.84.1270102116193;
        Wed, 31 Mar 2010 23:08:36 -0700 (PDT)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 25sm160531624vws.1.2010.03.31.23.08.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 23:08:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vzl1qwfno.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143716>

On 03/29/2010 10:18 PM, Junio C Hamano wrote:
> Stephen Boyd <bebarino@gmail.com> writes:
>   
>> This command uses a custom version of string list when it could
>> just as easily use the string_list API. Convert it to use string_list
>> and reduce the code size a bit.
>>     
> Thanks, although the above is a bit unfair.  Back when 00449f9 (Make
> git-fmt-merge-msg a builtin, 2006-07-03) was written, there was no such
> thing like string-list (nor path-list, its predecessor).
>   

Sorry, I didn't mean to be misleading. Maybe something like:

This command uses a custom version of string_list since back when it
was written 00449f9 (Make git-fmt-merge-msg a builtin, 2006-07-03)
there was no string_list API (nor path_list, its predecessor). Convert
it to use string_list and reduce the code size a bit.
