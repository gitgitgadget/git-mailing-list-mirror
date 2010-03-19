From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: submodule problem
Date: Fri, 19 Mar 2010 18:29:29 +0100
Message-ID: <8c5c35581003191029x7069ea10tecdaa49e176080c2@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F2403299C8395@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 18:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsg0v-0001TC-UO
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 18:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990Ab0CSR3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 13:29:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38032 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0CSR3b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 13:29:31 -0400
Received: by wyb38 with SMTP id 38so1627674wyb.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pyj/xo7AtYwMK/5ifyXnhkVxtavGR4krw5t1nB1yhwY=;
        b=nzWsQg/kOXMh4oyX9osL4x/4XXQyoGuGLCtnOhy9z3nchjNjzxQeejzgih5gVsyMwL
         eG2xCJXmA15WCUD2sOZCeZH0mq9HcdhyexvgboxYBqaoZwz9t7FYvZY5dtJJlaLHrVEQ
         7ODF3LrBmiF0pL9FEaDheV4iVRCY2A72/EKqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lqCW7KsMsB5lBH939aLdjcBY6wPQBI4q0owBR5ax4CxXF4uXPweAIiQm4uGCJ36RY7
         EOjlR1t/e+aFj8QiuLMYFBXMbvAEJrgKUWq2Zoq1WnP2yifosfnlxqWmPA8VUmuTY22w
         9akLGW5szwJUaeCVMVYmk02tlpZjwfhQa3/IQ=
Received: by 10.216.90.202 with SMTP id e52mr974201wef.150.1269019769597; Fri, 
	19 Mar 2010 10:29:29 -0700 (PDT)
In-Reply-To: <89030B4A18ECCD45978A3A6B639D1F2403299C8395@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142626>

On Fri, Mar 19, 2010 at 17:54, John Dlugosz <JDlugosz@tradestation.com>=
 wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git submodule update
>
> gives no output.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git submodule status
>
> shows "-8441e..." which is the SHA1 of the version I expect I need.

The '-' prefix indicates that the submodule isn't registered in your
=2Egit/config. You should have a 'submodule.$name.url' entry in the
config (where $name is the name of the submodule as found in
=2Egitmodule').

--
larsh
