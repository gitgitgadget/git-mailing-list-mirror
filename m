From: Marc Pegon <pegon.marc@gmail.com>
Subject: End year project : minimal Git client based on libgit2
Date: Wed, 18 May 2011 18:42:40 +0200
Message-ID: <BANLkTinGPvekMDT5nmsFQp3SpR_QOYq+UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 18:42:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMjpi-00077Y-3O
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 18:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab1ERQmp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 12:42:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49434 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab1ERQmo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 12:42:44 -0400
Received: by iwn34 with SMTP id 34so1442491iwn.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=jmAiHKNtVArWSC9CikS14bZQbHs3l1KqgfBdAIorkT8=;
        b=q98q0mUl1oLQBhenuJ7KesZ7qYRO+Ewf/Z2z9NJrn4M4D4trItFGPOVcGbWrKfgfIz
         wK/XIE/OB+lg7GC7rTGkf0F2yUmPOdzouSpfTh7DALdertpC6CTrd2jzviJAixq2Gtic
         Gyb5t8IduHIIOMWkEl20GcQpWNvQT4ECFZ1kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=djUjq6fGUeXNlb33r2TuxPRNt/e4KH18Jv0jm1S1Ce/Heiveh9m0h4NOervi+e2i+k
         zpD06KIrUIS6yz7QF0dHvOjyeQiI1j/I63yIptbwKEVx7JFvPv0wDH2umgN/q3q5JaNL
         4Cn2qDoS/yDcHCgrkjRrMv1ZYhQmHNmj7cnv4=
Received: by 10.42.213.137 with SMTP id gw9mr2624859icb.158.1305736960694;
 Wed, 18 May 2011 09:42:40 -0700 (PDT)
Received: by 10.42.164.199 with HTTP; Wed, 18 May 2011 09:42:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173887>

Hello everyone. We are a team of four students from a=A0French=A0school=
 of
engineering (Ensimag:=A0http://ensimag.grenoble-inp.fr/). To end the
school year, we are supposed to work on a four-week full-time project,
under the supervision of Matthieu Moy, who has been following Git's
development for quite a few years now. We thought it would be
interesting to contribute to git/libgit2. We are especially interested
in one of the GSoC2011 ideas : Build a minimal Git client based on
libgit2 (http://git.wiki.kernel.org/index.php/SoC2011Ideas#Build_a_mini=
mal_Git_client_based_on_libgit2)

We started by taking a look at libgit2 API and Git source code, and we
have already begun to write some (quick and dirty) code.
We would like to know more about your expectations around the
"minimal" git client. What are the key features to implement ?
According=A0to the GSoC proposal, we should implement some high level
functionalities (push, commit, branch...). Perhaps we should
concentrate on more "plumbing" commands ?

Regards,

Bettaoui Nassima
Geissler Romain
Glesser David
Pegon Marc.
