From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] t9200 - Allow cvs version 1.12
Date: Mon, 15 Jul 2013 22:05:03 -0400
Message-ID: <51E4AA4F.6090008@gmail.com>
References: <1373920585-22370-1-git-send-email-mlevedahl@gmail.com> <7v1u6za379.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 04:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyudd-0001B7-D2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 04:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab3GPCFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 22:05:08 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:33572 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab3GPCFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 22:05:07 -0400
Received: by mail-qa0-f42.google.com with SMTP id hu16so2017951qab.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 19:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=o0Ve7LBJNpXEZ925ShS70K20qnRiyELjLXdDU1WD8b0=;
        b=uXA+vkjQtlpI5lYOgeKEFZ2MIe7M+7gZknv6ukxiAGLLXh/YBUuEJ6ebMKVtt+Tm8g
         ReVLPEDZyvjsjr5XmGp7ygzUeJxUuCPHUlFNC26N3XpX/8DbrRUETTsYV6kQKvoC3jZ+
         EV6GZOvfUoRoIPrGfziiGtpSokAs6E6pvlkqu6+BmeSrEOcJvpNmEOs0LYz7xAzJVehK
         4mcreKQc57JK/uyZUAXo6+yDEM0nWG2cOeAdlAZ5PViHwXkfPRvR/sKaBqlXX5Kcmpxf
         6aPWD8aW4+r49t+sGxhho9VpHhJsCHOqHjsg6v/FkC5hcGEKAkVkITnQYfDYmkwEiliC
         bKOQ==
X-Received: by 10.224.68.6 with SMTP id t6mr222908qai.76.1373940305632;
        Mon, 15 Jul 2013 19:05:05 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id w2sm59535526qec.8.2013.07.15.19.05.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 19:05:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7v1u6za379.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230534>

On 07/15/2013 06:06 PM, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> cvs v1.12 does not correctly handle "cvs co -d $DIR", which is shorthand
>> for "mkdir $DIR, cd $DIR, cvs co, cd -". So, use the latter form.
> Hmph, I think I've been using 1.12.13 and without seeing such a
> breakage.  Do you mean "exactly v1.12", not "v1.12.x series"?
>
Hmm, good instincts. Cygwin includes 1.12.13 which is what I used. I 
downloaded the sources, rebuilt, everything works fine, so apparently 
the Cygwin provided cvs binary is corrupt. I apologize for the noise, 
will take this to the Cygwin list.

Mark
