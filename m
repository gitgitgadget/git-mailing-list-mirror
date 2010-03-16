From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Tue, 16 Mar 2010 15:17:04 -0300
Message-ID: <55bacdd31003161117l5c43631n80e2e4a023a78199@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org> <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com> 
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org> <m38w9wlg7i.fsf@localhost.localdomain> 
	<55bacdd31003141457x74222a79lc060112d20dbbe4c@mail.gmail.com> 
	<7vhboil4ni.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 19:17:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrbKi-0004EM-4L
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 19:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938007Ab0CPSR1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 14:17:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45854 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938001Ab0CPSRZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 14:17:25 -0400
Received: by gwaa12 with SMTP id a12so61435gwa.19
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/CYFBfe58XE1NqCG7wehD/PfvGWT/7FqiaFii+LnGAk=;
        b=Ny15Nfaq7YiYkbJ1Juz9cfW3ShBMXtE76L2UGzVoGGwGhqjmGA1RHe3g9lamkLJllw
         lSI052FRK7dAKwmGBMi5HhsTQ/eiUPNK+1Z1M6jYANxyeTZXDDmHaqxGLrbgSYpcUVSR
         biZYOQzPO6/TFkBBXvEBDAuNsp0W0+YOOl9EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=StfMIplW6osN3XwGf6qXj6JKFD33hO4FIbBCQLOkMl3Py1kOITQrZDlG563Lwuk1p8
         DqDE+JL0w7Xj1n3np3jQteVG9ZInFbL9StIy6Z7V8KKVsjpXae55CHsOpfPPLXz/q2Ry
         eqRlIi3U9nXAFeXOH9tn1F9SG+psIJV3Azcx8=
Received: by 10.101.131.27 with SMTP id i27mr57538ann.230.1268763444095; Tue, 
	16 Mar 2010 11:17:24 -0700 (PDT)
In-Reply-To: <7vhboil4ni.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142344>

2010/3/14 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> You got it right. =C2=A0HTML and man branches are really very good e=
xamples.
>
> Not at all. =C2=A0You fundamentally do not want to have checkout of t=
hese
> branches in the same place as you checkout and work in the main branc=
hes.

It is unimportant the folder you will have them within.

It is a good example because they could be started or even kept
(merged only when needed) as an unrelated branch.
