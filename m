From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 0/6] pseudorefs
Date: Tue, 28 Jul 2015 15:07:01 -0400
Organization: Twitter
Message-ID: <1438110421.18134.15.camel@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	 <xmqqlhe0ds2v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:07:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKADX-00016k-CM
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbbG1THE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jul 2015 15:07:04 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34425 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbbG1THD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:07:03 -0400
Received: by qgeu79 with SMTP id u79so81081664qge.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=2gxlZRat480Co+IQdedRDZ6aM9WGfD5pC6mjXTZ/+94=;
        b=MURD47YTqwPxOuVFS2tYUlKqA5uiL2dEpNCC/yIK/7VB7oHypfemYU7xCz4gdumVK1
         34LgiswkJTqtAkgvMpyIKRCv9ZkhqDoD4dXwQqJ5yF2Gqk8bwJrr7OMzsuAKG+1C6+dJ
         aEsjxDwrvXo/JtbswyaclUmJ7ZrBfHi6xGgQgdjda+jQrb/u3EWCzaz1jS0LzpmeTtg5
         xEYqLElfozKf13UM4iTjF4+1B5WAQDKi4C6M8ZyDNGL0+JkHDI7xl7Wagb9DU69f5ZW1
         fzJo55IuoIo/PUZV4aox4phFot5nAl/k2zEn4+IYc6p8cY2+g9F4NMR/MF+Y004xcb0I
         pCXA==
X-Gm-Message-State: ALoCoQnhwnxAX4L9mlB/imkWJ35xbsxmkE8qYAcdqQtC2WRg/i++eeWC6naJcAJwTg5Y3pr38s/0
X-Received: by 10.140.85.85 with SMTP id m79mr52535587qgd.37.1438110422428;
        Tue, 28 Jul 2015 12:07:02 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 10sm11768487qgl.9.2015.07.28.12.07.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2015 12:07:01 -0700 (PDT)
In-Reply-To: <xmqqlhe0ds2v.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274816>

On Tue, 2015-07-28 at 12:01 -0700, Junio C Hamano wrote:
> On top of what work is this series expected to be applied?

I think I started from 'next' as of a few days ago:

commit df7aaa5e3454bbcbb1f142dd6b95b214d0b8efad
Author: Zoe=CC=88 Blade <zoe@bytenoise.co.uk>
Date:   Tue Jul 21 14:22:46 2015 +0100

    userdiff: add support for Fountain documents

Let me know if you need me to rebase on something else.
