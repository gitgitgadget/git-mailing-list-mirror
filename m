From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Fri, 26 Mar 2010 06:47:07 +0100
Message-ID: <fcaeb9bf1003252247x339e7fb2y1b714b018c04afef@mail.gmail.com>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org> <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com> 
	<25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Mar 26 06:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nv2OM-0001sE-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 06:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab0CZFr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 01:47:29 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:32319 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0CZFr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 01:47:28 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2485324qwh.37
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pNSDKqHCi4kv5ZVC7OaI3AH4ddDqZPU3aWJ5IDTfmW0=;
        b=wItHD9JXYqyKdMrrZ0wL2J8VksNjrxkhtFwd13f7rrXO52ilFpOjwCQuRXnbS/gvSg
         Ss5097kEo3oc/ZDZQUMiT8FfdGQnQ3hcbRRf5+q3c2xm8dm1V/rR7fdfIexEvVbrZimJ
         as9pN9WUjXsXVGfwlnATSZepzGgUMLKLSz1gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=C2khkzNqQlZuN3vnE8LzYDie8OpG/LoH7WDl3jh3EEoM2vuoyh6IRvhYDK1+JVAO4R
         J7Kjbr5x2M+IW7Zd0VXD9Zlwu4GRIBXx+X2XseZPw1eRn8lHkgcCrcjXBPETsDH3wci6
         VyIRtgQHSHOHxosIHQ/29JeE09swQ+9rQ4gMM=
Received: by 10.229.221.195 with HTTP; Thu, 25 Mar 2010 22:47:07 -0700 (PDT)
In-Reply-To: <25yNvbuAivZlBuEJoRhXtfoEc7HEZorM5qOrwgQKk7FER_fdzljyMQ@cipher.nrlssc.navy.mil>
Received: by 10.229.213.81 with SMTP id gv17mr615574qcb.14.1269582447767; Thu, 
	25 Mar 2010 22:47:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143209>

On Thu, Mar 25, 2010 at 5:27 PM, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 03/25/2010 10:11 AM, Nguyen Thai Ngoc Duy wrote:
>> 2010/3/25 Junio C Hamano <gitster@pobox.com>:
>>> * ar/config-from-command-line (2010-03-19) 1 commit
>>> =C2=A0- Allow passing of configuration parameters in the command li=
ne
>>>
>>> * bc/t5505-fix (2010-03-19) 3 commits
>>> =C2=A0- t/t5505-remote.sh: escape * to prevent interpretation by sh=
ell as glob
>>> =C2=A0- t5505: add missing &&
>>> =C2=A0- t5505: remove unnecessary subshell invocations
>
> methinks you were over-aggressive with your cut/paste? =C2=A0I don't =
think bc/t5505-fix
> contains a strndup. =C2=A0Hopefully, it does not break your build on =
Solaris.

Yeah. It should have been after ar/config-from-command-line. Made me
wonder why this topic had test fixes..
--=20
Duy
