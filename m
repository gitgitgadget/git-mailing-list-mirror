From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 06/18] rerere: drop want_sp parameter from is_cmarker()
Date: Sat, 18 Jul 2015 04:47:24 -0400
Message-ID: <CAPig+cSwH_+htWqNphHsoP+SX8YCVS=PgN03m5z3ksSdeJE0kw@mail.gmail.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-7-git-send-email-gitster@pobox.com>
	<3AAC96959AB14E61B7711B914D963B7F@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Jul 18 10:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGNmQ-0002mM-MV
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 10:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbGRIr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 04:47:27 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36690 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbGRIrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 04:47:24 -0400
Received: by ykay190 with SMTP id y190so106734747yka.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pC3Y94QtRZzT/DuoDpPxzSPbBW75xSxxDOCfoOz0ni8=;
        b=pwoqqyvrY3HafAyhhescIGtsYSckkb9pOzMAT2UU44aN1czMVlHAivCnqaboWYySz9
         ewptcFxppjIqbSEtn1HgIcrqIN8iLJYQ+/A4ij2ZN/o2RE8PULPisK2zce+fvaGejuIN
         1XoxzJ7vje/vXNltqzMeR7puJOSVraAaXP07hDuAVxV2K7eivUGP8hoRUaGPF1FjEvY/
         Om8RpnJDqEmEBdsimRNvsOPWQiON0ZfNwdwwvSSq3cuIlQg0E2oApXG7l0FJVWWuVbaj
         gTniWSe9P//rWvEdPYajk1tBzyNluBSSUYPqD/B9Hu33RVk/5nU2tKQRzE5tE2diHclJ
         UdMg==
X-Received: by 10.170.97.9 with SMTP id o9mr19225948yka.84.1437209244345; Sat,
 18 Jul 2015 01:47:24 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 01:47:24 -0700 (PDT)
In-Reply-To: <3AAC96959AB14E61B7711B914D963B7F@PhilipOakley>
X-Google-Sender-Auth: T-WAXtrOTLaycGii2UhYfXZrcqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274159>

On Sat, Jul 18, 2015 at 4:24 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
>> As the nature of the conflict marker line determies if there should
>
> "should be a"?
> i.e. s/a /be a /    below

Also: s/determies/determines/
