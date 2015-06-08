From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 01/11] for-each-ref: extract helper functions out of
 grab_single_ref()
Date: Tue, 09 Jun 2015 00:03:03 +0530
Message-ID: <5575DFDF.7000404@gmail.com>
References: <5572F904.1080608@gmail.com>	<1433598496-31287-1-git-send-email-karthik.188@gmail.com> <xmqqlhfuaxjw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:33:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21rU-000277-E7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbFHSdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:33:12 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35330 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbbFHSdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:33:10 -0400
Received: by pacyx8 with SMTP id yx8so65623615pac.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AJqP4hglVm6eNY3mf3KR4A6jPOS/g3RxJp2I1HhZKuI=;
        b=kT/2nHwiByM1UPRrGdJVAiThBytqzM5143z5NU2m8BJgyyT1pUzJZzWmwL7Ab5O61X
         u3e4OSoK6n4kF1YCklCIUoqdm0zjeDu/OrM0lsWR3PgKLVQvtUplwXCio8N6SKvFi3yp
         f3IJEbEBVMS9w2cnjUJ91BnLEdSAgnT65/bCR+1ZdD5eFRl6ViVYtJ5vpTG4FoL1lE62
         UtqDkxz/WBBxq6JWFbjm3R7r875HEzlJOYY/XCvwVrZGkneMVLqhH4Ixs85Yp9gDN22A
         ephGKPKHJbPplYv/zq0oGAUbHnQI4EenM0o3Zn68nWW3xE9YsgpaYV+XK/MOxUFh4xBW
         4bTA==
X-Received: by 10.68.204.229 with SMTP id lb5mr31807822pbc.139.1433788389861;
        Mon, 08 Jun 2015 11:33:09 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ku10sm3279444pab.3.2015.06.08.11.33.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:33:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqlhfuaxjw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271102>

On 06/08/2015 11:32 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> + * Given a refname, return 1 if the refname matches with one of the patterns
>
> You can "match refname with pattern".  But "refname matches the
> pattern" without "with", I think.
>
> I am not a native, though.
>
>> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
>> + * and so on, else return 0. Supports use of wild characters.
>
> s/wild/wildcard/.
>
> 	Return 1 if the refname matches with one of the patterns,
> 	otherwise 0.  The patterns can be literal prefix (e.g. a
> 	refname "refs/heads/master" matches a pattern "refs/heads/")
> 	or a wildcard (e.g. the same ref matches "refs/heads/m*",
> 	too).
>
> perhaps?
>

Sounds a lot better, thanks :)

-- 
Regards,
Karthik
