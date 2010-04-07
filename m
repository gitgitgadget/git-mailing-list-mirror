From: Vitaly <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 09:57:39 +0400
Message-ID: <4BBC1ED3.6020008@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <alpine.LFD.2.00.1004061709360.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 07:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzOHG-0004pQ-9T
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871Ab0DGF6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:58:09 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:64567 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab0DGF6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:58:05 -0400
Received: by bwz1 with SMTP id 1so497981bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Vogj5G9bZIoKhbhcXFzJ9q4YlYvaXkOQhzcSW+c8pj0=;
        b=mYWuV8m5YjY2+tkfg3bDKLKSBYBNHrL0WC325SGPGL0VY5eENo/jOXA/euHjya9jI6
         bmmatmwMIHd05Agb38kaBWUUmBwC4Z9xFDp7u54vj55rrY4MYCOV1tJv3wKzYhTrxDAe
         ms6ZgLIIQhp/MSLFQyfFw5QzXl7pt5Y/P2d+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cHxCGpI+Q6i1z6W34mT+1TsrFz11EiaJVz6a9fSrsaeizqyGmnuiTw4eCIrcYw4iOQ
         jFpOxCwwWAA201WolAaNPfBDA9B126saCPWOODuZm0H349gQclR7G0OA2vnw5P50MH/p
         N/Bj7D3OslELDy5k+9OpkyiKoAXKI8IneYQTQ=
Received: by 10.204.134.70 with SMTP id i6mr8699489bkt.74.1270619883284;
        Tue, 06 Apr 2010 22:58:03 -0700 (PDT)
Received: from [172.16.11.219] ([195.218.191.171])
        by mx.google.com with ESMTPS id 15sm6992046bwz.0.2010.04.06.22.58.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 22:58:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <alpine.LFD.2.00.1004061709360.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144200>

Hmm, what does it mean - "makes no sense"? It works as it works - for 
several hours.

No, we work in a trusted environment. Our repository isn't open for 
external people.

On 04/07/2010 01:10 AM, Nicolas Pitre wrote:
> On Tue, 6 Apr 2010, Vitaly Berov wrote:
>
>    
>> We have quite a large repository and "git clone" takes about 6 hours. Herewith
>> "resolving deltas" takes most of the time.
>>      
> This simply makes no sense.
>
> Is this repository publicly clonable?
>
>
> Nicolas
>
>    
