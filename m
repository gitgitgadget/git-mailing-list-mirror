From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 19:29:10 +0400
Message-ID: <4BBB5346.6070607@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 06 17:29:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzAix-0002YH-3p
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 17:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab0DFP3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 11:29:39 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:40375 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab0DFP3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 11:29:35 -0400
Received: by bwz1 with SMTP id 1so4870bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=gbFq1RDBcK77z5mGcPBLiwcbL7NSZN2zWh/kJOD9U2M=;
        b=bBKKKzrpKN0FNyUTOI0QJqSNaKwjtDy/mr0tflo6sn/9G8hm9Q38vTnvqJKkifSoj4
         0qmIlzeAcxsQ/wskyiyr7eWUOn70PIY5hLtR9GtEO5avBv/4/irOtm6jlsaDUHemYV0x
         o+clg8vnSe7KfqZgPdvPJ3NJz3uWuopTgpdkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=NwEot3K3ZJsQ7sd+MxdhaAt+kbXEgcZXeZ6iCuu9guxklYZ+5lkYIMKqSI+A386Zmg
         QzgUzenXsaNSDXPZX1L8wiN/GfirxyZ9nIjo15vo3kNKDTL/2g1gJzVEVjqCvc5n7Skt
         exSpKy+FB4CGfuOh3RVq0ZZ0EU37vBa5kgxYs=
Received: by 10.204.6.212 with SMTP id a20mr397892bka.22.1270567774015;
        Tue, 06 Apr 2010 08:29:34 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 15sm6646567bwz.8.2010.04.06.08.29.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 08:29:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <vpqljd062xb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144148>

I didn't try this, but I'll give it a try, thanks.

And what does this stage mean?

On 04/06/2010 07:01 PM, Matthieu Moy wrote:
> Vitaly Berov<vitaly.berov@gmail.com>  writes:
>
>    
>> We have quite a large repository and "git clone" takes about 6 hours. Herewith
>> "resolving deltas" takes most of the time.
>> What git does at this stage and how can we optimize it?
>>      
> Does running "git gc" (long, but done once and for all) on the server
> help?
>
>    
