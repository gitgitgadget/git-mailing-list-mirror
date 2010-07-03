From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: Re: what is the test target of t9400-git-cvsserver-server.sh
Date: Sat, 3 Jul 2010 23:28:01 +0200
Message-ID: <AANLkTilxJh18NKKDQSf-qItBLMFejAhAM30RvGeKnYQi@mail.gmail.com>
References: <AANLkTimhp_D22jGlfkbJenYpyzLKWN6HqCyHePCOwJ50@mail.gmail.com> 
	<AANLkTimuYhTyQmxOdKuFUujGmXDC9scHQLGMaWCxcLeG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 23:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVAGB-0001L5-PG
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 23:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab0GCV2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 17:28:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab0GCV2W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 17:28:22 -0400
Received: by fxm14 with SMTP id 14so2998133fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 14:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yjIrB9s25WEzGgoYrnF9gOOy/kcsxqOT04kNPq7kcNA=;
        b=aJWFDSOUihdcCdGmY2OaoDosSxOtM/lFHyz6JDYTmjN3Ge63VNktAy7BH3aT0SaIt1
         ga53ctWfTZjUki55CG2vq7qvyCW/G3zmk3rJhv/dyX2g8c5RuXtAPp1bXRrBBtk33svg
         GD6Q9p1cXYakPS8JZQ2lrpcdaJW9kv8lR9FL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HuQApjEfXU91WbsxFePTy8Hl+VvNB8NTh74iibx5ZInxtg5R47gsPC5EckkbhhiSin
         mayIn6LuvyW/5Lh/O5PJPPOOWmvkpztr9yx7Se8xyon9mOeBfnzRqV71dFdL7dneLB9e
         typ00QCyF6ugthyUqFyo7qUk26VWoroJdU+tI=
Received: by 10.103.222.12 with SMTP id z12mr70573muq.13.1278192501139; Sat, 
	03 Jul 2010 14:28:21 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 14:28:01 -0700 (PDT)
In-Reply-To: <AANLkTimuYhTyQmxOdKuFUujGmXDC9scHQLGMaWCxcLeG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150207>

You are right, I don't know why it didn't work for me when I first
tried. Now it does...

On Sat, Jul 3, 2010 at 22:52, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
> On Sat, Jul 3, 2010 at 17:04, =C1shin L=E1szl=F3 <ashinlaszlo@gmail.c=
om> wrote:
>> t9400-git-cvsserver-server.sh refers to git-cvsserver as CVS_SERVER
>> for the cvs client:
>> CVS_SERVER=3Dgit-cvsserver
>>
>> What is the goal of this test? To test the git-cvsserver executable
>> found in the system (in $PATH), or the one bundled in the git source
>> distribution? I would think that unit tests are to be run before mak=
e
>> install, so it should test the latter. I have a patch already to fix
>> that and I will post it in case I am right.
>
> Have you noticed that test-lib.sh sets PATH to include the git direct=
ory?
>
