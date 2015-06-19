From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 13:53:01 -0700
Message-ID: <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	<xmqq1th77829.fsf@gitster.dls.corp.google.com>
	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:53:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63Hn-0006MI-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbbFSUxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:53:09 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35910 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbbFSUxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:53:03 -0400
Received: by igbiq7 with SMTP id iq7so22606443igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4oAKJUO+3Lv0KyreCbl+KEKFin7krMGdp5DuwT5ul/k=;
        b=vaVX1OocYAFFgUM96rd8Whz5f1O7aA337/pv3WW4qU74Rycdph5GwLHEMHQbc2Vgrd
         mXYCxTycDycRhlq7iIlqyBCsGlJc1DrjRiJuZm1MMdqR4eBiQq0TteFpnEdLMEm2HZYY
         gphNqzPjQadRJGPfQBkogZBcfBFRPNxgCpCLXmjZ46WnkRmv5gDfsgpVcfUz8+JiNmnI
         Lz09FBw4harhVn+w/Pdf4XkVqtp/a7IyKucWlHb16TKJv0UVmp7/D+Frx/hu4DfaZ4JG
         OjCBMSEajZtkjQXCUo6N1CFM4roESl5Fay56uU6O3TMl1Mk4c15lEPyMG3Wx7vaRkBAq
         JBnA==
X-Received: by 10.50.17.104 with SMTP id n8mr7045968igd.21.1434747183011;
        Fri, 19 Jun 2015 13:53:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id p193sm7780868ioe.34.2015.06.19.13.53.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:53:02 -0700 (PDT)
In-Reply-To: <95e42f21de69ab5299c03ce6ad107037@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 19 Jun 2015 22:42:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272204>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Can you think of a name for the option that is as short as `--quick`
> but means the same as `--connectivity-only`?

No I can't.  I think `--connectivity-only` is a very good name that
is unfortunately a mouthful, I agree that we need a name that is as
short as `--xxxxx` that means the same as `--connectivity-only`.  I
do not think `--quick` is that word; it does not mean such a thing.
