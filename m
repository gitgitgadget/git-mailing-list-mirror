From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Sun, 8 Mar 2009 22:23:36 -0400
Message-ID: <76718490903081923w3779d6aeu4081022a6630eb73@mail.gmail.com>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
	 <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 03:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgVAx-0008LR-78
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 03:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbZCICXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 22:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbZCICXj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 22:23:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:29147 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZCICXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 22:23:39 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1420241rvb.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 19:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M/poH6S2X+zWJE+LwDML0xeeNbUKDhxEbVnuUV3BlIM=;
        b=xIgdilFO6side9JisaHAOqmqkOKMXjU5a8i+MuepA98p1u8AtOCncAeg9XoxhtdyV7
         OoIW2ic+nJ3kL/Ubm+ObYTAtFR9w00ZPqNbCP8pNQPlItFryacofuhE2+3xZI4u8RK29
         fdF1GQK1R0UIyW0CbO/vl7/BQE6nvCVIrdshU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JSDpf8E/jNRf37tW8ewxhRUEvwdNYJopOnp1D9DpwUKXoM53bu+pJJOxJ6AfLeAp+7
         3YnLri4gSb9GJ8UhXA+smDh/LWCb0/7WyXmNutQhMYs2zmixPxHJS0xZkWV1sCcaZBNh
         FBqrZqDmxgOQUtCZDRDf1qmF88lxsRCMXHaIY=
Received: by 10.141.12.18 with SMTP id p18mr1940067rvi.208.1236565416985; Sun, 
	08 Mar 2009 19:23:36 -0700 (PDT)
In-Reply-To: <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112671>

On Sun, Mar 8, 2009 at 10:22 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> foo32: Mach-O 64-bit executable x86_64
> foo64: Mach-O executable i386

Okay, so I may be brain-damaged in my naming, but that doesn't
invalidate the results. :-)

j.
