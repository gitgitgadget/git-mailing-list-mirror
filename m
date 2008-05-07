From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Removing from index
Date: Wed, 07 May 2008 02:39:43 -0700 (PDT)
Message-ID: <m3abj25u7e.fsf@localhost.localdomain>
References: <4B58A837F454E14AA0453EDBADE96A62B5F3C9@mildred.leeds-art.ac.uk>
	<vpq4p9a8r57.fsf@bauges.imag.fr>
	<4B58A837F454E14AA0453EDBADE96A62B5F405@mildred.leeds-art.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>
To: "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 07 11:40:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtg8a-0003iT-S9
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 11:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYEGJjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 05:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYEGJjt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 05:39:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:51105 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYEGJjr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 05:39:47 -0400
Received: by nf-out-0910.google.com with SMTP id d3so119123nfc.21
        for <git@vger.kernel.org>; Wed, 07 May 2008 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=3Pue5qQW6uHU3WAl98bsIwHzYiYxHZ+CXSfG4BUy4Rs=;
        b=g2Q3ghsHY+mU5bZ2+ff0GUAnTd1s3tKrZcsFb5qroNKDrtPkK9jpZ0eyVAVEolneQn1fokfcmMFboGoM18LZcqLcrQsJSLQ1vbYti8317qmM8kIEkxhmg+VVxSqGabj5NgBIixKer5DL4vfXdhXyxvkxLyg8D39Z4CQToLyOPM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=SqRhlaXJVDtWxHU512yQB5m5rXwWMWpEsHt6iWBvoumnQBOqXf4uiz3U/v09GhRd4aDxitoJo/10yZ2JqaZHs9TgboSGxnNV1kI3H/TnOp7iVt4acAXVZ0x+uvj/yc1bnxcAkET4HVGiabZoxM2HSsPzsjQqffwaaRpJA2XTCG0=
Received: by 10.78.81.2 with SMTP id e2mr491910hub.13.1210153184882;
        Wed, 07 May 2008 02:39:44 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.194.224])
        by mx.google.com with ESMTPS id p28sm685792hub.59.2008.05.07.02.39.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 May 2008 02:39:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m479dbVW025703;
	Wed, 7 May 2008 11:39:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m479dXov025700;
	Wed, 7 May 2008 11:39:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4B58A837F454E14AA0453EDBADE96A62B5F405@mildred.leeds-art.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81424>

Please do not toppost.

"Ryan Taylor" <ryan.taylor@leeds-art.ac.uk> writes:
> Matthieu Moy wrote
>> "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk> writes:
>>> 
>>> I've tried adding logs into my exclude file and also running the
>>> git rm command on *.log to remove them from the index but they're
>>> still being tracked?
>> 
>> What does "git status" say after "git rm *.log"?
>> 
>> Are you sure you didn't forget to commit after that?
>
> I do a rm then a commit. But then I keep getting modified logs in my git
> status?

What are the names of the files you want to stop tracking?  What is
the entry in .gitignore or info/excludes file?  What was the sequence
of commands to remove them?  What command did you try/use that
returned unexpected output?  What was that output, and what did you
expect?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
