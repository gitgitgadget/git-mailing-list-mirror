From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 3/8] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Sun, 31 May 2015 23:18:46 +0530
Message-ID: <556B497E.3010105@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-3-git-send-email-karthik.188@gmail.com> <xmqqr3pwabsb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:49:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7M5-0001nt-2Q
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758374AbbEaRsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:48:53 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34973 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433AbbEaRsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:48:52 -0400
Received: by pdbnf5 with SMTP id nf5so29675457pdb.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9oPCxT2SUaaSyGpco42G9/SyR3p0DLmcbNFN0o6sIxw=;
        b=byg9tPMZQtfUutGKLFOusUX8+D+YIn1YuQoB1CQMHbGJNnFdqAXCYnKjtYF6GN/SUS
         uKPhVRrT8JS208ej3onecSuJHNplgrhYzTT0VCSq1szRMklXzpac2T+e+UwlzBNFR3Ve
         dYEAzI77yCkDzFU7U7PgRZDofIL6ad3LPbpYDEdBT/bJQ14B+c08TW0PcdcU55vZXi7G
         350H0GiNhp/AFSqtoPqVzd3Ok3egRmULUT9NA3oDaC+KnPApyL6lwFdwOIW+TpQegLhB
         fq02zgchE9P0FIggXF/CZaejNdP3EYIXnQB37TzSfz6f/7jJdDsFU6Yo5UeuL0nvXBhU
         QOsw==
X-Received: by 10.66.159.68 with SMTP id xa4mr34166995pab.105.1433094531617;
        Sun, 31 May 2015 10:48:51 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ax2sm11861380pac.21.2015.05.31.10.48.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 10:48:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqr3pwabsb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270337>

On 05/31/2015 11:07 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Rename 'refinfo' to 'ref_array_item' as a preparatory step for introduction of new structures in the forthcoming patch.
>>
>> Re-order the fields in 'ref_array_item' so that refname can be
>> eventually converted to a FLEX_ARRAY.
>
> Not a big enough deal to require a reroll, but I think it would be
> easier to read if this reordering is done in the same patch that
> makes refname[] into a flex array.
>

Yes I was thinking the same, I'll add that in the re-roll.

-- 
Regards,
Karthik
