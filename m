From: Paul Chown <pmchown@yahoo.co.uk>
Subject: Re: git-p4 under cygwin
Date: Wed, 4 Jan 2012 08:54:45 +0000 (GMT)
Message-ID: <1325667285.61811.YahooMailClassic@web132101.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Thomas Berg <merlin66b@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 10:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiMiD-0004BS-HV
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 10:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2ADJAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 04:00:41 -0500
Received: from nm1-vm0.bullet.mail.ird.yahoo.com ([77.238.189.95]:40509 "HELO
	nm1-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752122Ab2ADJAk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 04:00:40 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jan 2012 04:00:39 EST
Received: from [77.238.189.52] by nm1.bullet.mail.ird.yahoo.com with NNFMP; 04 Jan 2012 08:54:45 -0000
Received: from [212.82.108.240] by tm5.bullet.mail.ird.yahoo.com with NNFMP; 04 Jan 2012 08:54:45 -0000
Received: from [127.0.0.1] by omp1005.mail.ird.yahoo.com with NNFMP; 04 Jan 2012 08:54:45 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 682103.76930.bm@omp1005.mail.ird.yahoo.com
Received: (qmail 61923 invoked by uid 60001); 4 Jan 2012 08:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1325667285; bh=OG+8rrQvlGdVb3pSahWLbJOz/r7VojDUC7Uf/hUjTt4=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=5Xren1T+TycU8DozADMxzcAX6aOu/iwOM8vAuVvaS6oEjCz1itcIsKIPi2p7qTJewhyll5auw7LowsTOZnbOPTbrbX3CViHdZpyio7U9BOJwaxI3C2RsPSmPFvxJp5ziu/J3h1FqIOQWBKg5oy5fkr3BjRwhMAN8SUloVY97Bhg=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QOyMdu4wpeh3CHREpdjstrjPzhdV49y3Y4Bx5qQs3PCYqt3b/2zSF4faXhSm3Clnv3UJ4uZePPZFU5sLmHcEoliTHOtn0/lzqY0bWykvT6WAolX3bZUPXy1L0UQ5zWb0Sg9XzxLUCD0RbOiteznA3wB8CcdtWyR0JmKm4LlS3xM=;
X-YMail-OSG: 8hqhNAcVM1npaSrW5d688gzOEX1PZRtkd6eOI_dS0SpETLj
 cevCYF4QvzLJML2wmGD0e9FUTPUXkokWor63rZzJXZSgo8FcBibB822awklZ
 gszh7LbXhZTvnKMIxa0rWIrGi_Ok.sU7IUgmQGtFS1hOIBAEG8XdUC7cnAE3
 r5b_QApc11wOmlVIwtVCvFlgmSNxPZUyyorrknMpH7e0WJBMGcM1VU3RCS6s
 1jN3gEji8BDEVFFXiJCe2dsB4VzNzsTa8SMc.W.Ju1CBfP9jl.Q6rPwC4EUR
 1oRXHRNtGM5DzMd4eHrFp.gXShPiCkQ0ZfDTEUEv6VDN0LLe4lmltBZqt5sY
 hoVHEJU7l8hxE9fzr_sL5u1cCIYlwNNnqoySVjML9Ck59MrD5RE6LHIIHuR8
 eZV7ff8imidNroZ_j
Received: from [141.249.133.128] by web132101.mail.ird.yahoo.com via HTTP; Wed, 04 Jan 2012 08:54:45 GMT
X-Mailer: YahooMailClassic/15.0.4 YahooMailWebService/0.8.115.331698
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187914>


On 1/3/12, Thomas Berg <merlin66b@gmail.com> wrote:
> On Tue, Jan 3, 2012 at 4:32 PM, Paul Chown <pmchown@yahoo.co.uk> wrote:
>> Path '/cygdrive/c/work/perforce/config_test\...' is not under client's
>> root 'c:\work\perforce\config_test'.
>
> Ah, sorry, I did not see this part of the error message when I first
> replied. This does seem like a cygwin related problem. Not sure how
> easy it is to solve. But as mentioned, msysgit works fine with git-p4.
>
> - Thomas
>

Thanks! with msysgit it works a lot better. The 'vi' invocation failed during the submit, and I tried just about every EDITOR variation that I could think of without success, but I could workround that by setting EDITOR to use the Windows notepad.exe instead.

Paul
