From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Decompressing a tree to a location other than the working 
	directory
Date: Fri, 6 Aug 2010 22:10:28 -0500
Message-ID: <AANLkTi=iApfmo3HhDU9BgxvJuHJwuDc=nHFpOib9TM8x@mail.gmail.com>
References: <AANLkTi=RjcQ_-PNUt781jhYEA-8krqXpdHRenVyR_Rc4@mail.gmail.com> 
	<20100806184345.GB2985@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Shrader <jshrader83@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 05:11:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhZoS-00070A-FB
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 05:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762182Ab0HGDLB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 23:11:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35709 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760548Ab0HGDLA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 23:11:00 -0400
Received: by fxm14 with SMTP id 14so4216961fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 20:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5704DUUTEGgvxsZaVSZQVkTBQh47qWB2mnJF9XBxpuQ=;
        b=LDPXkBa9OQlL39UN9I8MjZzCKE+AmiE8sptiFO4Bw7CsYpyakfIH2u2ntWqpSGMtqm
         NPaL4WHnpFCzMY1z+Os18fhZIBp1W5ACr52J7sqXH2U5CRXHYY7Hk4ClYkdMqIxEs9Tw
         z+Xpx1pjQTtF9/CUuodLijQKUEyPApoSbSkvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BeE3KibzTlc7j3ziP4ahNouiw0Kmryq4Aq2Gk8BuyFaVQzWdAZiPh+HzZ6+HcU8cZX
         Peap05UIxS0+dM++sbfL9NbDHp7bEP9z+YDzLQbO6zuJDJBBCdn02uieudEA48d6HOiY
         M7kfJxznw7bVGmkB2KxdQGLgYUNjfNX5CHfSE=
Received: by 10.239.189.142 with SMTP id t14mr637071hbh.41.1281150658865; Fri, 
	06 Aug 2010 20:10:58 -0700 (PDT)
Received: by 10.239.157.68 with HTTP; Fri, 6 Aug 2010 20:10:28 -0700 (PDT)
In-Reply-To: <20100806184345.GB2985@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152838>

On Fri, Aug 6, 2010 at 13:43, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> git checkout allows one to checkout a particular version of a certai=
n
>> path in the working directory. =C2=A0Are there accessible plumbing c=
ommands
>> that can be used to accomplish the same thing, but change the target
>> directory.
>
> I don=E2=80=99t know if it is plumbing, but "git archive" is very use=
ful for
> that.
>
> =C2=A0$ git archive HEAD^:Documentation | (cd elsewhere && tar xf -)

=46or single files (rather than directories), you could do this:

  git show HEAD^:path/to/file > /some/path/file
