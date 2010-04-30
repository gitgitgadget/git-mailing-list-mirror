From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Re: push instead of
Date: Fri, 30 Apr 2010 23:54:43 +0530
Message-ID: <p2nb42431c81004301124l6744553csbe5abdeda0d48e67@mail.gmail.com>
References: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>
	 <4BDB1231.9090600@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 20:25:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7uuN-0005dF-I7
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 20:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335Ab0D3SYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 14:24:47 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:33344 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759331Ab0D3SYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 14:24:44 -0400
Received: by pxi17 with SMTP id 17so311600pxi.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=VCrwVFBMxgvCVzJ6yQ5WBIQI33gV8r8sJqVo4Hug8Jg=;
        b=IUO8jW+EBBezkmmoR+4RamcEZX0IZqlXGYiJql+i8TfbjcCmV8xQX28FscL0rG9NpO
         JIKn/shCxFEDap4WuN0DFiMrCPm8hwQZB0S/2ODBabXZ0N1b7QaK3u80xfELmbQdvJjI
         o4UMGd6J6qZqeXRqA8cv8Jx9s9rCAeg1Ps7QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=rwh6tjlaZUincdtnEDuukm9F1SX8fgL629xomI0iVqxgyMtPnLFuUvW1E/ZPiAAKCn
         VHRJqkVMKEHmKNXOWVO/lBqZQkURCD1vo1rdfVBjImdKNUMizRR87ZPWmvXPQgnrC521
         5mMsBKH8dapq8T3oJXJKBwKZX9fHyTPpkJXkQ=
Received: by 10.142.150.41 with SMTP id x41mr266863wfd.112.1272651883826; Fri, 
	30 Apr 2010 11:24:43 -0700 (PDT)
Received: by 10.142.134.21 with HTTP; Fri, 30 Apr 2010 11:24:43 -0700 (PDT)
In-Reply-To: <4BDB1231.9090600@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146041>

No Luck, it still hits  readonly url ;


On Fri, Apr 30, 2010 at 10:54 PM, Tomas Carnecky <tom@dbservice.com> wr=
ote:
> On 4/30/10 11:56 AM, Mahesh Vaidya wrote:
>>
>> I am facing problem at pushInsteadIOf. I would like pull from
>> "pullhost" and push to "pushhost" as my pullhost as pre-receive
>> trigger which not accepting pushes.
>>
>> However when I do git push it still hits pull host. I have following
>> config.
>>
>> [remote "origin"]
>> =A0 =A0 =A0 =A0 fetch =3D +refs/heads/*:refs/remotes/origin/*
>> =A0 =A0 =A0 =A0 url =3D gitosis@pull_host:repos.git
>
> =A0 =A0 =A0 =A0pushurl =3D gitosis@PUSH_host:repos.git
>
> tom
>
>



--=20
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
