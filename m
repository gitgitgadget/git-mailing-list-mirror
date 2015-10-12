From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 0/8] fetch submodules in parallel
Date: Mon, 12 Oct 2015 12:32:12 -0700
Message-ID: <xmqqr3kzlw77.fsf@gitster.mtv.corp.google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:32:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlipX-0007d9-EN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbbJLTcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:32:15 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34754 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbJLTcO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:32:14 -0400
Received: by padhy16 with SMTP id hy16so161371885pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w+zsaZTronYuxot094uTA9ZDKcsy7l5IR4LKcFst//4=;
        b=gQ7ciaL+BMzAL70SEGM5OUABkEPQbqlWkjGuBSo7e8woSJ17Jp4rq6fCBqLw9S30EA
         gZqoHJ9n+yW0ApuwHV6QTrdhY9je+4zOusx1DIoMWMTKDezwdYH7lNy6X5SFdoGEvFst
         4gWzT+cZXrD5T0btH22+1IWupYerp/3b33eO5jQ/hac/TqRo6vAlRSL/JyGCDpazLz2k
         krZJMJ2b24/FhTbA+yhIr3Urp6fmnqaKakEF9+rm15wcujYXFs9fcH1YwyFd3VnZ5E38
         ScXRfmKLQUurblw3IF/lwpGYvnefg724GPJSvNnFHjEUUkC/V+UZPR8GSV1iFAVJy70n
         Cjeg==
X-Received: by 10.68.217.8 with SMTP id ou8mr36477435pbc.164.1444678334395;
        Mon, 12 Oct 2015 12:32:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id tp6sm19747581pbc.81.2015.10.12.12.32.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 12:32:13 -0700 (PDT)
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 12 Oct 2015 11:47:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279406>

Thanks; will replace.
