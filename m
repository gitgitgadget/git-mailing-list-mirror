From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 1/3] submodule: implement `list` as a builtin helper
Date: Tue, 1 Sep 2015 16:08:59 -0700
Message-ID: <CAGZ79kasYB7-vOj0UL1JVAb99wc3SjZW0XJDjXTHH7KzwfayeA@mail.gmail.com>
References: <1441148863-9139-1-git-send-email-sbeller@google.com>
	<1441148863-9139-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 01:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWufp-0003ht-6X
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 01:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbIAXJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 19:09:00 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36408 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbIAXJA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 19:09:00 -0400
Received: by ykcf206 with SMTP id f206so6280634ykc.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yPS4lQVi25TBpMWIffsEfJ4Mjm+bnGOUfFt4Ah6EZAA=;
        b=mOtamVztEdiw/qp1VTGF3NgdbYb02bF7tyJ5waxI9jGZYM39JCCQcrwSZChSB9phDe
         VonchXzGazNtemPEY41YHBqN4hP0/OgOFjM7+L6XnAIyHYTunr8oeMfff1ynCIEZnYu3
         aAqi4wSbtXdc9ZaER1b9FgY26gTJMPAR7XQgMd9aMgRQd5Nxn9iFG1SBAk3XHyQnqVcx
         6fF3w0CkUQFzvZ5OZGXYLY+pVbfuyP5Es02V9iKA7rgacP03xZfSWF15tDCaxzO9M+Nt
         VsUUAa423uWZJakuFW/RH+xu1EfF1dHv9eb5srWFW+WPl1VF6o9GKab0ArkGKFfbYRXf
         YeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yPS4lQVi25TBpMWIffsEfJ4Mjm+bnGOUfFt4Ah6EZAA=;
        b=Bi1sjYh/h3NMB3wRmNGDfeO6dojKFg6/GnEI46xvU5jL4sKH+m0J04gZlSbqmsbf+c
         UKpUotVFqVB0yhuLz0DG8O+k0tmS31bQfdM6xHt/iWS0nOkT5z/z/MufXLrrabhtRFI2
         lmemXgQp8yqySr1KtKj6wMLAjJvAWG8MAGMomdzNnHvJxcacVAne4l3Kt4lp512Fit+/
         5T7/JaxmOYOkG3lbEBercGIXVE5x94w0pl95cfBIH/QegYGvUBPZK9prFKH4gaPi2mXn
         4uuRScuw+fqg2RXoPK8BgnoHqYec/mIGSD8HoKVIA+JdDynrGstMzMlnotwPEv4la9Xk
         JGTw==
X-Gm-Message-State: ALoCoQkJjz2HC72sNKTaqrRO15grzshbxqGlSZwdlaLr8NrpSTsrn2bwoSZC6w2iQbL5vq9moOHo
X-Received: by 10.170.190.133 with SMTP id h127mr935516yke.115.1441148939324;
 Tue, 01 Sep 2015 16:08:59 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 16:08:59 -0700 (PDT)
In-Reply-To: <1441148863-9139-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277071>

please ignore.
