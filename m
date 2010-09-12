From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 3/3] t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
Date: Sun, 12 Sep 2010 09:46:14 +0000
Message-ID: <AANLkTikbOdCCgHZ8VNjN=1Gdi5SzeFDgMMyjU=ab+2kz@mail.gmail.com>
References: <1284284466-14506-1-git-send-email-jnareb@gmail.com>
	<1284284466-14506-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 11:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ouj8l-0008Eg-22
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 11:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0ILJqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 05:46:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab0ILJqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 05:46:15 -0400
Received: by iwn5 with SMTP id 5so3966670iwn.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CsntT57e7/phNfAYStwoZGjDPGCDIR2iSxLiVX4LvGQ=;
        b=acu27keyIAfT3Mtd0rLmh69HVigshq5jbmyiM+bBSBp5ZVDrQcHUth5IM1mlkdrIVY
         GyppWGRN5bWo2Un/m2mkRYe1kJr+0h8Q+jtpQlSM5oRHKrWrvu5HKJd33Noe6JVvuxd4
         GmRATryYV24HkYQNbc6SLhF60a7w78WJyqdPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=crrnde+NS5NWoAMQjZsuCge8+zjTMzInP82iEcPjbwjuJxIfQAlVhfIpF8bL+GLRmb
         7OpyLG5bgOglNkBEC2E57eiKrLa1ETHECH50tUDOLDgGWW+BpPGtBTUZEN7sGeFxgXlg
         cIGwRq0WmptTz0GiMniVzpMfW6noRMJPzJuWA=
Received: by 10.231.148.195 with SMTP id q3mr4036106ibv.199.1284284774601;
 Sun, 12 Sep 2010 02:46:14 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 12 Sep 2010 02:46:14 -0700 (PDT)
In-Reply-To: <1284284466-14506-4-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156027>

On Sun, Sep 12, 2010 at 09:41, Jakub Narebski <jnareb@gmail.com> wrote:
> It is an RFC because I am not sure where to put documentation,
> i.e. description of GITWEB_TEST_INSTALLED. =C2=A0Should it be put in
> t/README, in gitweb/README, or in gitweb/INSTALL, or in
> t/gitweb-lib.sh header?

That looks like enough documentation as-is, we don't need to document
every test variable like that.
