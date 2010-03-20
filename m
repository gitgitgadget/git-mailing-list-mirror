From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout: create unparented branch by --orphan
Date: Sat, 20 Mar 2010 18:37:52 -0300
Message-ID: <55bacdd31003201437x2b3fcd58j4c631468be63b1e4@mail.gmail.com>
References: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com> 
	<7vvdcrowlc.fsf@alter.siamese.dyndns.org> <55bacdd31003201206w6215c6a4qec09797fbe060725@mail.gmail.com> 
	<7v4okad9by.fsf@alter.siamese.dyndns.org> <55bacdd31003201336u685f4b91u5206ca719609d153@mail.gmail.com> 
	<7vfx3ubto9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt6NH-0003R0-5W
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab0CTViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:38:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58669 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0CTViN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:38:13 -0400
Received: by gyg8 with SMTP id 8so2071649gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=rRv963/I45vu1arjR5WjKV17/9q2C2yjRPRYLDpicCA=;
        b=u1WR04MM31pdPzDlzAyUxXHaEmU84w7fK1XpD/JakEmssFDH/eyfQALfHdj7oys68D
         XMVkriV2mbcudbnvYIFRDUu1l8WKvw36+WX5c609IIGo47GOxZwK2tJXzUUjx2PcIn43
         DpkHuB5gYIv3pVxY93ZFHRwjADGUoMjwFy8s8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HquPry9YB+Q7s4sYBv1s/5ri30fgv0U6jegj8tRfCgJXeGPIMrEcdIosIOTBJ6/UUT
         oifdLs2cbmB4mHvAWCVpzwgPToM42fD8h15s+PZtC/fR3kcQbui0oBHnBmVt4roq8UV/
         cXU5sJEqXuVF6Vgof0upZPV8erdYEYQLz/1Xg=
Received: by 10.150.119.33 with SMTP id r33mr75905ybc.304.1269121092099; Sat, 
	20 Mar 2010 14:38:12 -0700 (PDT)
In-Reply-To: <7vfx3ubto9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142757>

2010/3/20 Junio C Hamano <gitster@pobox.com>:
> I hope I am not giving you undue burden, but here is what I would add.
> One thing that I am not sure about is what to do with "-l --orhpan".

No problem.  I also like to do things right.  And you have made it
light with your attached tests.

About -l well... you tell.
