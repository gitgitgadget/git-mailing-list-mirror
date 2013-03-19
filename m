From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/8] Improve git-status --ignored
Date: Tue, 19 Mar 2013 22:58:06 +0700
Message-ID: <CACsJy8BE8mD+-W2miwTMEnrR45zpuPMbPcvV54q_7k0famFjuw@mail.gmail.com>
References: <514778E4.1040607@gmail.com> <7vsj3skp5b.fsf@alter.siamese.dyndns.org>
 <CACsJy8DShce6bXfyWyHk7pqg4PA-cAn1bKh0hgFYX=s486nwaA@mail.gmail.com> <7vehfbla1y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 16:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHywO-0004D3-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 16:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab3CSP6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 11:58:41 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41944 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab3CSP6k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 11:58:40 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so599581obc.32
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CRkVZZR99DNmrtwWP1Q+0PoYPEAwISG+Rnpj9/3KuPg=;
        b=1G2YjSnZljlCPgxGX8xL8XCp4AmtEpC4IikYnrqC8aMzJJOtXh6Co+K7PSspge3zl3
         6ggLhub6dAKcTgvc+7iH4AyG0ZgHPOUExGr6DIclkqsyjv9f/mjBc025zh1FAKY3fVCn
         9Wqo/KNjsTMQLsAXsKIS0UoCJNOFLj/JAKfAtgwOS+z9DK9NYyIhBWwpZ8cghxOTQRhv
         4grSlJmdBOx+XZDMLD1RhWAf5Tc1VKW7Da1f5HXrv1YB6AbQxaiIzyREklAt8R7ER5x/
         rziudCgEAINwocrnKXvzLeLewb/iTpuX2OFXoc8I2Hc5oYhogwyXncbxvNazaTAhC0+K
         XFrA==
X-Received: by 10.60.29.72 with SMTP id i8mr1602318oeh.93.1363708716651; Tue,
 19 Mar 2013 08:58:36 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 08:58:06 -0700 (PDT)
In-Reply-To: <7vehfbla1y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218532>

On Tue, Mar 19, 2013 at 9:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Would we we better off kicking nd/read-directory-recursive-optim
> back to 'pu' (and eventually ejecting it) and replacing it with a
> reroll of Karsten's series when it comes, perhaps?

I have no problem with that. Whatever better should get in.
-- 
Duy
