From: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
Subject: Re: [PATCH] git-imap-send.txt: remove the use of sslverify=false
 in GMail example
Date: Thu, 11 Apr 2013 16:36:01 +0300
Message-ID: <5166BC41.5020202@gmail.com>
References: <51657E59.7030001@gmail.com> <7vmwt6mdjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 15:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQHfg-0008Tm-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 15:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632Ab3DKNgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 09:36:07 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:34367 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3DKNgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 09:36:05 -0400
Received: by mail-ea0-f176.google.com with SMTP id h10so736055eaj.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tlsR8nIO9ADmpE4T9alvqlGcGWrgKwZrSJTIYwnXIFo=;
        b=WFxPsjwyk111K0qw/hcS2dDS+RaQxVxenTHfMR2nGg51JTD9V3P3dnEsPzHuzKWqfk
         JLDqnIKXzWZ/Ij9rk6p/XWEZ1yPu7Oa2zdyhCgmEB6/6fhHx09Ttd3VmJLWD7Ulhj2ab
         EcX/HcSUqgtdN4ZlqmnTd8WoA2/1rqqtsdidsnDAVEc4uudjuMxkNoUyS6JIZ1V7fNZp
         Cmt4KRUtZ6dknKC0wCh3KYJ3DZUni+4kDYKcTmNuMzVQ1VqH3GhKRgltnPioXnqgugsf
         9VHn3GbDZdr5NthF3FvkwzWE85k5OBBZTgu9ETmYqGsZzNHep8lWfKHF4SbI1/TwU2XO
         e4fQ==
X-Received: by 10.14.202.71 with SMTP id c47mr16943112eeo.39.1365687363394;
        Thu, 11 Apr 2013 06:36:03 -0700 (PDT)
Received: from [192.168.16.100] (5-15-249-103.residential.rdsnet.ro. [5.15.249.103])
        by mx.google.com with ESMTPS id r4sm5637965eeo.12.2013.04.11.06.36.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 06:36:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <7vmwt6mdjg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220880>

On 04/10/2013 09:44 PM, Junio C Hamano wrote:
> Thanks.

My pleasure.

> While removing that item from the configuration is a good thing to
> do in the post 1.8.2.1 era, the reason why it is does not have much
> to do with "GMail is SSL capable".

Should I change the commit message in order to avoid confusion among devs that
read it?

> The configuration item is not about "Do we connect over SSL when
> talking to this host?", but is about "When we use SSL with this
> host, do we verify the certificate it gave us?".

If I change it, how should it sound?
It could be:

Since GMail's certificates can be sslverify-ed there is no need to set sslverify
to false, the example using it may confuse readers that it's needed since it's
also used in the previous example configurations, too.

Have a nice day!

-- 
Barbu Paul - Gheorghe
Common sense is not so common - Voltaire
Visit My GitHub profile to see my open-source projects - https://github.com/paullik
