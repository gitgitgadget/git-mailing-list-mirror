From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon, 8 Feb 2010 23:02:46 -0500
Message-ID: <76718491002082002n587c4b05x44e5f577cf17a8e1@mail.gmail.com>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
	 <7vtytrrrju.fsf@alter.siamese.dyndns.org>
	 <76718491002082000s7be5b32dob5b3dfe764b12da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 05:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NehJM-0003IN-3Q
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 05:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab0BIECr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 23:02:47 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:56209 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab0BIECq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 23:02:46 -0500
Received: by iwn12 with SMTP id 12so8164983iwn.26
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 20:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=rHV9OLlLVmhC04+T9Afmll4LbPnxX07k5xQeKZlQf9s=;
        b=QiwzwqtaNf+ws5QcA4xKuHkFD5JHfJhKaEaP/V1GWp/sJ6E++Ec8M6BCAgOCZYPHJ8
         HkIevSaYXSYglo+PKke8+LXm1s8qtsYvQSPs3hGiWRcbh5VRVdOY9nR+Yo4cwFauNw4s
         /Y4UHQ+UH+VMB2dPMGGTEppJOmNLVxmmPno20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UVNdXEhFLU/UR7VliWVsfh7Kh/lsib5VTmtLEIPIS0fSTaxXIaRJJVAEw6XJ1DVzM7
         yPxL67BhaTmFuxhBkbNlwm7hND5zM8bSTQ1g9AXDgohR1OhqwdGc9RympNDoIpryr3yH
         a/NDb9rxCX0+6l7EQU0OEGTgC3QlM9CVuulnM=
Received: by 10.231.153.69 with SMTP id j5mr1190443ibw.33.1265688166243; Mon, 
	08 Feb 2010 20:02:46 -0800 (PST)
In-Reply-To: <76718491002082000s7be5b32dob5b3dfe764b12da0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139359>

On Mon, Feb 8, 2010 at 11:00 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> so checking with bottom alone should suffice, no?
>
> Ah true. You can squash that in? :-)

Actually, no, that doesn't work, but my head can't keep bottom=start,
top=end straight so I'm not even sure why not.

j.
