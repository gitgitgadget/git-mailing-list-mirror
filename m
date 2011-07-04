From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 20/20] transport-helper: implement marks location as capability
Date: Mon, 4 Jul 2011 15:43:53 +0200
Message-ID: <CAGdFq_ijB6fNr7favL+J7WeHOvY+MyqgZu-vwfPY3NRZg5mPag@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-21-git-send-email-srabbelier@gmail.com> <20110620012937.GB25836@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 15:44:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdjS3-0000XW-B3
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 15:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823Ab1GDNoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 09:44:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36929 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab1GDNoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 09:44:34 -0400
Received: by pvg12 with SMTP id 12so4377390pvg.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+jdRnafXvnAhsa24hyPpiYXZkMKTYgB+JZY5GZOTO8M=;
        b=YehxSxDYkH/VwOvaK3AU5paYLToAbnMwk5cgH1imfJOU4Fjih325L/mcGM/CuuOvEC
         iXZgCt3XDWQL9VgvFEJJ2gn/Z9y9a7lsDavWd2j8uJhs+dIhisBEQ3dvYDtsfAHQT49L
         1APc1c5KBhqWGIo7UnqsQ1KmrCYNOnf15iMxw=
Received: by 10.68.51.166 with SMTP id l6mr1361131pbo.435.1309787073040; Mon,
 04 Jul 2011 06:44:33 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 06:43:53 -0700 (PDT)
In-Reply-To: <20110620012937.GB25836@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176599>

Heya,

On Mon, Jun 20, 2011 at 03:29, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Why do we use a "gitdir" capability for this at all, instead of
> exporting the GIT_DIR environment variable as Tomas has suggested?
> (Not about this patch, but a separate patch explaining that in the
> documentation would be nice.)

Mainly because I didn't take the time to implement that, will do.

> How does this interact with fast-import's --relative-marks feature
> (if at all)?

They're a supplement to it, the exporter uses all three features (see
git_remote_helpers/git/exporter.py).

-- 
Cheers,

Sverre Rabbelier
