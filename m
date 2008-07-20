From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: [RFC variant 2 of 2] "needs update" considered harmful
Date: Sun, 20 Jul 2008 11:03:04 -0300
Message-ID: <b8bf37780807200703we8f8608yb009c1039b829b23@mail.gmail.com>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
	 <7v7ibhdmii.fsf@gitster.siamese.dyndns.org>
	 <20080720112957.GE32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 16:04:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKZWD-0006Lv-5f
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 16:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbYGTODK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2008 10:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757073AbYGTODI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 10:03:08 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:18020 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030AbYGTODH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jul 2008 10:03:07 -0400
Received: by fk-out-0910.google.com with SMTP id 18so659764fkq.5
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fhGakbZ8q4I5B65lLSVmsC6cFnDYlTx/nWTPuLQyH24=;
        b=XVpGt7fQxwAq+lZvXWi7xW8/8dyWEEUMeO07gKSunZGHsQkWGUG600aEbQ+e+7X/0e
         7lmy3GhANtE0gXLK7HMUi7q9n1TswyTpWTQ4d+hyjR03yGfKvIY5nB9oXXc+lD0kAeZb
         hx+fL2HDyP4fLxUfq06WEM+7k3lOVVcqYtdV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aXctvR8CXFinrYM1RIt9W0ts7GA84gtLr+CVnanQz7BZoCb+QCWP0eFPe0rdiJkeY7
         akj1TBMa8Vf8vGuR9mX+SR6ZQlA7DQC+6b4VMNLaRu4L/HFfIJc3iyaIVhw77L/Rwzj6
         KyiwGpjUlSCbzP30cyKR0QTvcfbr2EJrIlhBQ=
Received: by 10.187.158.2 with SMTP id k2mr17458fao.15.1216562584073;
        Sun, 20 Jul 2008 07:03:04 -0700 (PDT)
Received: by 10.187.189.11 with HTTP; Sun, 20 Jul 2008 07:03:04 -0700 (PDT)
In-Reply-To: <20080720112957.GE32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89202>

On Sun, Jul 20, 2008 at 8:29 AM, Petr Baudis <pasky@suse.cz> wrote:
> On Sun, Jul 20, 2008 at 12:48:21AM -0700, Junio C Hamano wrote:
>> "git update-index --refresh", "git reset" and "git add --refresh" ha=
ve
>> reported paths that have local modifications as "needs update" since=
 the
>> beginning of git.
>>
>> Although this is logically correct in that you need to update the in=
dex at
>> that path before you can commit that change, it is now becoming more=
 and
>> more clear, especially with the continuous push for user friendlines=
s
>> since 1.5.0 series, that the message is suboptimal.  After all, the =
change
>> may be something the user might want to get rid of, and "updating" w=
ould
>> be absolutely a wrong thing to do if that is the case.
>>
>> I prepared two alternatives to solve this.  Both aim to reword the m=
essage
>> to more neutral "locally modified".
>>
>> This patch is a more straightforward variant that changes the messag=
e not
>> only for Porcelain commands ("add" and "reset") but also changes the
>> output from the plumbing command "update-index".
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> I believe this is a good thing. Scripts need to be modified for the

Thanks for doing that. I hope this goes mainline soon.

--=20
[]s,
Andr=E9 Goddard
