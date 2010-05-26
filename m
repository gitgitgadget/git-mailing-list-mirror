From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: bug with 'cl' as alias for 'clone'
Date: Wed, 26 May 2010 18:39:13 +0200
Message-ID: <AANLkTikVStq4KCp94GplKl0TwANKYlzMmp3IZrwvP6fU@mail.gmail.com>
References: <E4D176D9-E1D2-4C8F-8F18-11060E49ED80@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: James Tucker <jftucker@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 18:39:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHJdt-0007xL-La
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 18:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145Ab0EZQjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 12:39:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51620 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0EZQjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 12:39:35 -0400
Received: by fxm5 with SMTP id 5so4626809fxm.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wGrakv3G1TxMMkKKYIXnQkSUN9oYgM17j/cximC3TDs=;
        b=GMRWw3050z9AQOyiTO63pKQIVNKRzyW9cZWwqfwK7TOvJbFcXE5DM5K8sfoSsEsJnV
         LURS/3QGvclBC3/4XeO/6RJFTRQYY1B+hIIg/CSOdALPWmCLC4Ex0QfdLkPhr6+uSNs0
         UUjbxj9faEVRrKkq8f/yXj+QCpiv1AjDutzN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Bvn7RmOKd9aNVyEbA0BRzjBhbaq6RqywK21xCdA20rvMo5evmbSDKtR/VV66M+NBDm
         EJFlS2hcG8/95cCO3dwQKjNsy1zeJ+e4ZR9GuGfUm5QyzV/V19D/Rzve5VPDpbcE4ug/
         o+yoy0fWYSwgW0qTX2OWIT6/tdp5Swq73r35w=
Received: by 10.204.4.153 with SMTP id 25mr3753533bkr.77.1274891973197; Wed, 
	26 May 2010 09:39:33 -0700 (PDT)
Received: by 10.204.70.79 with HTTP; Wed, 26 May 2010 09:39:13 -0700 (PDT)
In-Reply-To: <E4D176D9-E1D2-4C8F-8F18-11060E49ED80@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147812>

On Wed, May 26, 2010 at 2:48 PM, James Tucker <jftucker@gmail.com> wrot=
e:
> I've been running the following aliases for a long time now:
>
> alias g=3D'git' # in bash
>
> % cat ~/.gitconfig | grep clone
> =C2=A0cl =3D clone
>
> This appears to still be calling the right UI command:
>
> % g cl
> You must specify a repository to clone.
> ...
>
> But when I try to actually clone a repository:
>
> % ls rdbi
> ls: rdbi: No such file or directory
> % g cl http://github.com/erikh/rdbi.git
> fatal: cannot set work tree after initialization

There is something with alias and work tree setup that I should have
addressed it with my series. I suspect that is the cause of this.
Unfortunately I have been too lazy these days. I'll try to work on it
again maybe this weekend.
--=20
Duy
