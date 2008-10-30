From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git adds some text file as binary file by mistake
Date: Thu, 30 Oct 2008 14:32:47 +0800
Message-ID: <46dff0320810292332y34ea0daemde05b58572946497@mail.gmail.com>
References: <46dff0320810240537i4f0d86b9p56def9ef6a69c180@mail.gmail.com>
	 <4901C58D.4010309@drmicha.warpmail.net>
	 <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 07:34:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvR6w-0007ph-2D
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 07:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbYJ3GdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 02:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbYJ3GdJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 02:33:09 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:17218 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbYJ3GdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 02:33:08 -0400
Received: by rn-out-0910.google.com with SMTP id k40so280768rnd.17
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 23:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mnARqVFISFfkTnlK3t1RP/I/sUo0LY47+2hYFOyVYkM=;
        b=v8iL2eQr0VUlAIbwudbzFjX2naG8qCOlW0wEazEmWhK0x6cVPtKwKbg2rncK1g/1uJ
         +6lxHHKyvv2mZGybxcZ1ww9NM8Rte1mc4UFrwNTzh6rtR9dSEORx3KyYb5gfHYf3y/km
         HPWr2lxRmVXUuPMBfcbWiBww6BKdwF9g19jh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Qt0lxAFw+hQnPdFC4uHIBK8sHDRTGHmEcP1j3CQHtywE1YarDqJOHG0B1Hhrixm9Jr
         I3aehxTXQj4feiPG2QWUfmHXUNq6QOejAc027C/ClQAB5Ml/3W0zhs9MouLdLK8ERecB
         7vqvENwbGg1Yrf3iafrE1/cTeCrj1Fh/HTpHw=
Received: by 10.151.41.14 with SMTP id t14mr13510212ybj.179.1225348367915;
        Wed, 29 Oct 2008 23:32:47 -0700 (PDT)
Received: by 10.150.140.10 with HTTP; Wed, 29 Oct 2008 23:32:47 -0700 (PDT)
In-Reply-To: <46dff0320810240630s5cbfa62esd10a9da45ce37bf8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99446>

On Fri, Oct 24, 2008 at 9:30 PM, Ping Yin <pkufranky@gmail.com> wrote:
> On Fri, Oct 24, 2008 at 8:54 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Ping Yin venit, vidit, dixit 24.10.2008 14:37:
>>> So what should i do if i want it added as text file?
>>
>> You should give us more detail on the file ;)
>> What's the extension, what's the typical content? It may be a simple
>> matter of specifying attributes.
>> Do ordinary diff and grep recognize your files as text?
>>
>> Michael
>>
>
> It's just an xml file. I guess maybe there are some hidden characters
> at the beginning. I will figure it out later because i have no access
> to that file right now.
>
> Ping Yin
>

I have figured it out. It's just because the BOM characters feff00 in
the beginning of the utf-8 xml file.

-- 
Ping Yin
