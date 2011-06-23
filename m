From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/5] check-ref-format doc: de-emphasize the implementation
 detail of a ref
Date: Thu, 23 Jun 2011 18:14:34 -0400
Message-ID: <4E03BACA.8000303@sunshineco.com>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org> <1308847958-3429-1-git-send-email-gitster@pobox.com> <1308847958-3429-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 00:14:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZsAd-000202-Ri
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 00:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760027Ab1FWWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 18:14:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33094 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759791Ab1FWWOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 18:14:38 -0400
Received: by vws1 with SMTP id 1so1621390vws.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=H9DRKeS1WQNkxExBd8jLqZwzVrnymY5WiXROExQQtZE=;
        b=QfVwBC50tctNZ69ObJ+LfwZH3d60eWPUqZSMCcCpFKYvwk0ydF6/pRoE1HMRR23H6m
         NEOoJWgvBgUifFdO+r8d1gKi+CbFAnEJGNy60eIs0HkqN0CUpnG7Osad/UJ1tSHvQzIe
         7Y+JuIH8FBdYxMBDdbkvqKTLKjm7BZKFSPDBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=H1xEkqVVNutqXlUHqRn7Kq/y0VFJDbgQc/bSMGW8cg3ddRO2HTS19ucTa06pdhcwr3
         PNYonDCpegrBf33S4Y8oxKvbZDkkcn4b1q9TIvQGPY/uc1PHjFBej7h5GDhyPYzSrS5I
         CSc567S5zpDqMpveGq08aVJFyxldank4k3X4U=
Received: by 10.52.115.72 with SMTP id jm8mr3433799vdb.93.1308867277405;
        Thu, 23 Jun 2011 15:14:37 -0700 (PDT)
Received: from [192.168.1.2] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id dq5sm1135493vbb.16.2011.06.23.15.14.36
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 15:14:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1308847958-3429-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176297>

On 6/23/2011 12:52 PM, Junio C Hamano wrote:
>   A reference is used in git to specify branches and tags.  A
> -branch head is stored under the `$GIT_DIR/refs/heads` directory, and
> -a tag is stored under the `$GIT_DIR/refs/tags` directory (or, if refs
> -are packed by `git gc`, as entries in the `$GIT_DIR/packed-refs` file).
> +branch head is stored in the `refs/heads` hierarchy while

s/hierarchy while/hierarchy, while/

> +a tag is stored in the `refs/tags` hierarchy of the ref namespace
> +(which are found in `$GIT_DIR/refs/heads` and `$GIT_DIR/refs/tags`
> +directories or, if refs are packed by `git gc`, as entries in
> +the `$GIT_DIR/packed-refs` file).

Grammatical complexity of parenthetical comment makes it a bit difficult 
to read. Perhaps simplify as:

   (typically in `$GIT_DIR/refs/heads` and `$GIT_DIR/refs/tags`
   directories, or as entries in file `$GIT_DIR/packed-refs`
   if refs are packed by `git gc`).

-- ES
