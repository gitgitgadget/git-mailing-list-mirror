From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Documentation for git gui blame
Date: Tue, 12 Oct 2010 14:46:48 -0700
Message-ID: <4CB4D748.9040907@gmail.com>
References: <4CB48909.6050708@workspacewhiz.com> <4CB48C5F.2030007@gmail.com> <m3iq176vh2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 23:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5mg5-0003Gm-AW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 23:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab0JLVqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 17:46:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46101 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab0JLVqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 17:46:24 -0400
Received: by pzk34 with SMTP id 34so1378145pzk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=HRU9rOOyE1X/HIjqJpid9RErv+mixGws/6zfKuw5lNc=;
        b=TY+2XzD4mKZoSt0l6wlniWVW4YfJl/JkV33jOpMMVJkmIdNT7eHJxGKRlPhaiB4zK5
         qGglTFyfgkYsAajagkGDZFRtJITYhRofkiIYlIzF5u9SX3CavTT4q0s0/NtCBzei6JUq
         q5abem5DUK0xdxo5SxvYEmY1N8Vq2WP0x4GWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=J++tKtWRbfj1GJrdEh2SzLw9QwxI9/gomyNQugytq8m/SRkjEYsY6hdxe8dUgnZUvo
         nW7zD9gzQXbKZof+Hptq6Zb7N4tx0/8u1chR5jY4peIR7PWC++oDb0hGd1h4ICQ4wi6Z
         VWpMGqW/uB5PFIX/KLK+ftwAaYKtuIVWc1pmY=
Received: by 10.142.134.16 with SMTP id h16mr6859854wfd.363.1286919983517;
        Tue, 12 Oct 2010 14:46:23 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id x13sm1110843wfd.19.2010.10.12.14.46.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 14:46:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <m3iq176vh2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158881>

On 12/10/10 12:50, Jakub Narebski wrote:
> Chris Packham <judge.packham@gmail.com> writes:
> 
>> On 12/10/10 09:12, Joshua Jensen wrote:
>>>  Is there any documentation for git gui blame 
>>
>> Not sure but it's displaying the same info as git blame so start with
>> man git-blame. That probably covers most of what you want to know
>>
>>> that explains what the two left columns containing 4 letter SHAs are?
>>
>> These are the first 4 characters of the commit id that last
>> added/changed that line of code.
> 
> Note that there are *two* columns because one column contains plain blame,
> and second contains blame with code movement and copying detection and
> discarding changes in whitespace (like "git blame -C -C -w").  So if those
> columns are different, one column would show commit that put code here,
> and the other would show commit that changed this code.

Sorry, my bad I should have actually taken a look before responding (and
read the question properly).
