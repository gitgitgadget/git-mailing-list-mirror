From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] zlib: fix compilation failures with Sun C Compilaer
Date: Mon, 22 Apr 2013 19:50:02 +0200
Message-ID: <5175784A.5060805@gmail.com>
References: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com> <7vfvyipl4f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 19:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUKsZ-0005Ks-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 19:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735Ab3DVRuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 13:50:08 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:37706 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab3DVRuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 13:50:07 -0400
Received: by mail-we0-f181.google.com with SMTP id m1so231390wea.40
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Pn4HYgRp7MzspslTEjLQss6UDvf+f5cvjhuvow2LnY0=;
        b=dQhWpKU8Z0DRslCtQbdy1cdcVRyZx/liXDlOwOGJRHynZuv+PTYqdF+BobSOCdXTC7
         AozW/ROaBYSyuu1B7CX9qdt3e/vpqSDlK04mS+y2V4jhqy3eSfeX5DWXUhxvvVf8W1YO
         awQSON4BKfC8ow9Lh8bE2FcW/zzFOi+W6C6C7Ie3JKIbRShrVlr734rwxTsAvx9p0D7H
         MziwD4s5RwVtJxJpjufkJs3PJSalnhhebzEan4RJpDFGJXIYmS+7B2l6GkTscjKBqYfa
         OcGU+5gxt4mBMNJZL2RhfQcaW51waNjNeEAg7dsmAvzVlA3hisB3pdAlGXZzQte4MAwj
         WVHQ==
X-Received: by 10.180.21.167 with SMTP id w7mr31294647wie.2.1366653005283;
        Mon, 22 Apr 2013 10:50:05 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id d8sm23559135wiv.10.2013.04.22.10.50.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 10:50:04 -0700 (PDT)
In-Reply-To: <7vfvyipl4f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222041>

On 04/22/2013 06:48 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> Do this by removing a couple of useless return statements.  Without this
>> change, compilation with Sun C Compiler 5.9 (SunOS_i386 Patch 124868-15
>> 2010/08/11) fails with the following message:
>>
>>   "zlib.c", line 192: void function cannot return value
>>   "zlib.c", line 201: void function cannot return value
>>   cc: acomp failed for zlib.c
> 
> Thanks for catching a recent regression in the mainline before any
> tagged release is made out of it.  Very much appreciated.
>
Actually, I tried to build the bleeding-edge git on Solaris to use it
myself, rather than to test it ;-)  So, thanks to you and all the git
contributors for continuously improving the package, thus making it
worth to try to build and use the bleeding-edge version.

Best regards,
  Stefano
