From: Eugene Sajine <euguess@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 16:01:07 -0500
Message-ID: <AANLkTinnwM0h_TiLW0oXVmSrv25HMu4oZm8ZBcBOZ8r3@mail.gmail.com>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
	<7v8w07rje3.fsf@alter.siamese.dyndns.org>
	<AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
	<AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
	<20101203175212.GA8267@sigill.intra.peff.net>
	<AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
	<20101203202923.GB15517@burratino>
	<AANLkTin94XN8_+q8a1EdfY3ySqJpx_j9megQYsq8a8ux@mail.gmail.com>
	<20101203205534.GA15658@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POckl-0002dq-Ii
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab0LCVBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 16:01:10 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48245 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307Ab0LCVBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 16:01:09 -0500
Received: by bwz15 with SMTP id 15so8740381bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 13:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ahLTO7UIxZ5Rw07za5za9PdpqW515+48lX5K5QiDO5o=;
        b=t1a5ywLD6KDdIQzuAQlZym15wj1jIVkfhHJBEnLtlsPuv775mffqqrxYMGmKl6TKRk
         k1OGX8VynS8P8bjj6lz3SYfyhzF/cg0Z6d+zkT8ZjPVDtouA+JdZn9kSP2rcN3Hbs5Id
         ny97sGysad+7KpG9keGJSyYaG5WFyD0ZuPqJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cGj+nP/Fz6k/CUaFh3TTKfEpLcktSTNhUI3eh1X0ATxxPJ3qolTjtefiAWI3J3r2HH
         0xN/h6gKpC7N/0+qZ/wqDqIbRw3TqXGvfMnVjwX793JF3c6zW1vF09P1DZ2asBZMiu5n
         TTGY9TJA1jJ0fKrYdpVnDmm0N5fvbFsxwZPQQ=
Received: by 10.204.118.77 with SMTP id u13mr3172173bkq.158.1291410067806;
 Fri, 03 Dec 2010 13:01:07 -0800 (PST)
Received: by 10.204.80.131 with HTTP; Fri, 3 Dec 2010 13:01:07 -0800 (PST)
In-Reply-To: <20101203205534.GA15658@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162852>

On Fri, Dec 3, 2010 at 3:55 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Eugene Sajine wrote:
>
>> ::SourceMode1 SourceMode2 resultMode Source1-SHA1 Source2-SHA1 resul=
tingSHA1 MM path/to/file
> [...]
>> 1. a) Why this exact output is not provided in "git log --raw" or in
>> "git whatchanged" for the merge commits? b) Can it be provided?
>
> Sorry to be opaque. =C2=A0"git log" et al accept -c too, of course. :=
) =C2=A0I pointed
> to diff-tree because it seems you are scripting, so its simplicity an=
d
> better guarantees about long-term compatibility might be appealing.
>
> Cheers,
> Jonathan
>

Wow! that is pretty cool - it is one of the diff options that log
understands... interesting...
Thank you very much!

Eugene
