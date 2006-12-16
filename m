X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [BUG] making docs blows up in b1bfcae438ad:git-merge-file.txt
Date: Sat, 16 Dec 2006 15:47:09 -0800
Message-ID: <4584857D.703@gmail.com>
References: <86y7p7cssx.fsf@blue.stonehenge.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 23:47:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VbPzx2W471pwl6DLv5qrSX/Az65JcQArPmwmOlssS2kqejupgAXiMp7KpI6yFTbWN7h4pkH9xYDeRSDa6LUbgy+Hts01Y7d/BZ2bd2l4eqAHoSOZzQ+99hKxWMbRv5F/7bXb7cNJl2tYoX7ajgfPzZrdcbFfYoaXbQO7OUN8WhA=
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
In-Reply-To: <86y7p7cssx.fsf@blue.stonehenge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34659>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjFP-00039g-Eq for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422853AbWLPXrP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWLPXrP
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:47:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:10245 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1422853AbWLPXrP (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 18:47:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1175464uga for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 15:47:13 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr2511525ugm.1166312833441; Sat, 16
 Dec 2006 15:47:13 -0800 (PST)
Received: from ?10.0.0.6? ( [76.167.71.78]) by mx.google.com with ESMTP id
 e33sm6574887ugd.2006.12.16.15.47.11; Sat, 16 Dec 2006 15:47:12 -0800 (PST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

Randal L. Schwartz wrote:
> asciidoc -b xhtml11 -d manpage -f asciidoc.conf git-merge-file.txt
> ERROR: manpage document title is mandatory
> ERROR: git-merge-file.txt: line 3: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 8: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 15: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 46: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 65: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 79: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 84: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 89: title not permitted in sidebar body
> ERROR: git-merge-file.txt: line 92: closing [blockdef-example] delimiter expected
> make[1]: *** [git-merge-file.html] Error 1
> make: *** [doc] Error 2
> 
> 

