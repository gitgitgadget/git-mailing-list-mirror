From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of
 @{-1}
Date: Thu, 31 Mar 2016 17:31:48 +0200 (CEST)
Message-ID: <972993506.2587877.1459438308676.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	matthieu moy <matthieu.moy@grenoble-inp.fr>
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:28:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aleWe-0007ha-NY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbcCaP2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 11:28:44 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:53202 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752211AbcCaP2o convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:28:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 40735240B;
	Thu, 31 Mar 2016 17:28:40 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1O6Fc4nkWIf; Thu, 31 Mar 2016 17:28:40 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3101A240A;
	Thu, 31 Mar 2016 17:28:40 +0200 (CEST)
In-Reply-To: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: branch -D: allow - as abbreviation of @{-1}
Thread-Index: 0sFBiURXleNdHuK1Yaq755qOhxnFsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290403>

Elena Petrashen <elena.petrashen@gmail.com> wrote:
> +void delete_branch_advice(const char *name, const char *ref)
> +{
> +        const char fmt[] =3D
> +        "\nNote: to restore the deleted branch:\n\ngit branch %s %s\=
n";

Shouldn't that be marked for translation, like is done with the other
strings?

Thanks,
R=C3=A9mi
