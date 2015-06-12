From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv3 0/4] git-p4: fixing --changes-block-size handling
Date: Fri, 12 Jun 2015 15:03:14 -0400
Message-ID: <CALM2SnYaNUqaYAs+FKZ2NBG1b3sEwoTwoRueFS=yR6naixwPZg@mail.gmail.com>
References: <1433921459-16555-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:03:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3UEZ-0007bm-L4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 21:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbbFLTDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 15:03:15 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36452 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbbFLTDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 15:03:14 -0400
Received: by pdjm12 with SMTP id m12so29565983pdj.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w3+/EUqDXI3Fq9GiVvHeCauiAxRqVPfFeVXJbhuN/tM=;
        b=nrZtUwgzVJCSXfRLCeJmQCf6cL7i2KdcuKdAoxJilmuG+UIYO33/kKfsNF6uvYnuHL
         A5ZBVFBY3vzm+RLShb72tMOeS1D6e+gN1c3J08iV9X2MbyNoa60ds+C+j1akNl/OhSLm
         UgEL+BZDY2JMXsdgV4vp0YG6VnhWdlyxR2qUHJ3Lp7shr/FvJGU8YKh+TF2jp8r282B6
         4oB15OjuEOe0vQkNYxf18BaVDALawiq/X2EbJLodOW0P52Tl3BwDpqONDNEwSduCQvCw
         nlyj1pxRbWVvy86fuZbIu0D8UET/RLyjTk1UelUmJqbWBotbF+T959ahKLEuaUHQpFn9
         GARQ==
X-Received: by 10.70.135.168 with SMTP id pt8mr25718010pdb.8.1434135794168;
 Fri, 12 Jun 2015 12:03:14 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Fri, 12 Jun 2015 12:03:14 -0700 (PDT)
In-Reply-To: <1433921459-16555-1-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: OiO_GnIYAmYULaBgujJT4cyE7Rs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271514>

The latest patch series LGTM. It's a pity about the more complicated
structure with two different ways to query the changes list, but it
does look hard to make it any simpler.

Lex Spoon
