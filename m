From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 13:26:33 -0500
Message-ID: <53595759dce2a_3241f112ec9b@nysa.notmuch>
References: <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
 <20140424154717.GB7531@thunk.org>
 <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
 <20140424180204.GL15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:37:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdOWL-0007Ug-7a
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861AbaDXShE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:37:04 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51186 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758455AbaDXShC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:37:02 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so3056126oag.20
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=bU7jf/WcXenmSikKlpCvq8xSG6UFB9wRmxL7AqIVTBs=;
        b=Q8nx6WOpN/4Ps3TVuiivdywPdO2RMS69E62M7JLcuAsLWeaEqrfqhC8Z8QuK+9qWFu
         YOfyaGdr62HyOJkmEC7Dr9jxVvkvruibYo/x1sSHkh1XfWBTClPmi1mvrTlkbf55g6iu
         DVqgtWgQPH5na0+2b0N68/YWO/XY8vmHz3TcmNAH8yGtrG42zoV7hpy//CaPL8TNTzzV
         a0Z3SXwrgxdtWmyhZjtn430sUuo6XfSxMLTb8KNrI932RzL0ntirNutY4YkNWXhZfMt6
         y8MiSFy4sh4HGiwAZ4pgkR8gfQ9bS6SiayFq0zHS+Zhv6Xzxx299VDzUdhLyP5l89J2G
         ycjw==
X-Received: by 10.60.176.39 with SMTP id cf7mr2788715oec.45.1398364621820;
        Thu, 24 Apr 2014 11:37:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm6297728obb.5.2014.04.24.11.36.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Apr 2014 11:37:00 -0700 (PDT)
In-Reply-To: <20140424180204.GL15516@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246990>

Jonathan Nieder wrote:
> Stefan Beller wrote:
> 
> > I may have missunderstood.
> >
> > So today you cannot commit if you don't provide an email address
> > (usually the first time you try to commit, git asks to "git config
> > --global author.email=<you@mail.here>"), if I remember correctly, so
> > there is definitely a valid (i.e. user approved) email address.
> 
> Not true.  But you do get a big wall of text when you make your
> first commit without an EMAIL envvar or configured [user] section,
> including

Only if you don't have a fully qualified hostname.

-- 
Felipe Contreras
