From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Currently checked out branch is not bold in gitk when using ssh
 X-forwarding
Date: Thu, 22 Mar 2012 18:08:28 -0500
Message-ID: <4F6BB0EC.2080209@gmail.com>
References: <CALykgB0LCjDsMYSB1jAxBmPxsf-f6XDDFv+1nmtvCLP65ex5vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremy Ramer <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 00:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAr7W-0008Pq-1h
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 00:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757711Ab2CVXId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 19:08:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43871 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab2CVXIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 19:08:32 -0400
Received: by obbeh20 with SMTP id eh20so1867071obb.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6ITKh+YCKp0pbNvfq9WzgeupD7ztGwVLxz/7Bqg+N94=;
        b=MQ7zuZkk8+SjMenUp9d4UqTo4w+ltBSRhkUZMHFpcv07oPpq1WUW8vcc/BPBckd2HP
         yuKWcnEslUUrfNrl+fi2T0KngJwggr73OzwWTSrRUMVBNy6XKVdIk2VIkxz4j5XJwBNH
         UfMEaX16VTaJIcTqjCZLajbVyEKbCPx0PP+qYYnXc3uR1M9hcXizRlJ+MLJy7JuqFr7N
         obUr7LUDT1OVs6BpJuO+0jDL969KIMMLoRvwcqzjuAZCnhk1koCWb3fDRA/N/LiPfeQi
         f2SZDWbjBRf1cuik5QT1aJyARF6nMgdoNWp/H7f1SDSzafWoVMcPTMpytYJMxkYTZm1J
         IblQ==
Received: by 10.182.159.65 with SMTP id xa1mr12276643obb.25.1332457711584;
        Thu, 22 Mar 2012 16:08:31 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id n7sm4813159oeh.4.2012.03.22.16.08.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 16:08:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <CALykgB0LCjDsMYSB1jAxBmPxsf-f6XDDFv+1nmtvCLP65ex5vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193729>

On 3/22/2012 4:10 PM, Jeremy Ramer wrote:
> However, when I log in from my newer Ubuntu 11.11 laptop (ssh -X
> buildserver) and start gitk the currently checked out branch is not
> displayed in bold font. In fact, all the fonts are a little ugly,
> though it is the lack of bold that is the hardest to work with.
>
FWIW, my theory is that is has something to do with your fonts. Just a
simple end user observation.  I'm not a gitk programmer.

Maybe you don't have your fonts set for what-you-want in gitk.  Maybe 
you don't have the fonts installed/setup on your ubuntu box for 
what-you-want in gitk.

I assume gitk uses the fonts that you tell it to, or that are available.

Hope this helps.

v/r,
neal
