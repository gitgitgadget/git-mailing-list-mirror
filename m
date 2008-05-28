From: Geoffrey Irving <geoffrey.irving@gmail.com>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 11:28:44 -0700
Message-ID: <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com> <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 4A102)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Cc: Geoffrey Irving <irving@naml.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QPW-0003RE-21
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYE1S3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbYE1S3O
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:29:14 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:45869 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbYE1S3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:29:13 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2033395ywe.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to:in-reply-to:content-type:x-mailer:mime-version:subject:content-transfer-encoding:date:cc;
        bh=L3EiHB0j8NlNYC0fMd3668ZaZZ8RKk8MRhgdP9xar4E=;
        b=gCLjHaUCgv7Tpx9LkG+q1VIwneFW8WACNKMk8KGmkN+RtU2t1ThugpX/WSUTX81vAUaqG5mG5nQ1OEDX517kSDxh3rPdWhudndPeb/0YyNWqXph6GZSt3aZRB1wsf/vuT6i9lvCFCrA7OKnkEJaW5wjXdiUNrqj7i5t3fRyxyrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type:x-mailer:mime-version:subject:content-transfer-encoding:date:cc;
        b=GYabhpHAUCavhjZvcyEYlxpasVddXjqHM1ujv6CABzLPdNzA41uXYcpFBpR8R54OkgOarJTugw7QMHJ48aY6jzfE0VDv9VY/Bmp0HlwDhn8fixHMTlRObU9TaT3tPjEN1jjtc347amZR+XK+yJIWkWFz/vcXtxl94BsrrdaZMiw=
Received: by 10.142.242.11 with SMTP id p11mr1171042wfh.135.1211999330924;
        Wed, 28 May 2008 11:28:50 -0700 (PDT)
Received: from ?192.168.60.34? ( [199.108.77.12])
        by mx.google.com with ESMTPS id 28sm23980846wfd.4.2008.05.28.11.28.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 11:28:50 -0700 (PDT)
In-Reply-To: <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
X-Mailer: iPhone Mail (4A102)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83123>

On May 28, 2008, at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:

> "Geoffrey Irving" <irving@naml.us> writes:
>
>> Would it be straightforward
>> to add an option to "git cherry" to ignore differences in metadata?
>> The cherry documentation doesn't give its criteria for when commits
>> match, and I'm not familiar enough with the code yet to figure out
>> those criteria directly from cmd_cherry in builtin-log.c.
>
> cherry does not look at metadata at all.  It compares patch-ids.

Can you define what a patch-id is?

Geoffrey
