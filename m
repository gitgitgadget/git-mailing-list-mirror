From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 17/20] transport-helper: change import semantics
Date: Tue, 5 Jul 2011 00:23:14 +0200
Message-ID: <CAGdFq_hFQRTjRZBGZKBejpUqCCzo+wHWG69nM8=57peUBN9yjw@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-18-git-send-email-srabbelier@gmail.com> <20110619233822.GJ23893@elie>
 <CAGdFq_iTojuvVAdB6sC7-Kro9E49q_1Lfh87Yy4nR5BTdZ1eaA@mail.gmail.com> <20110704215859.GA8909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 05 00:24:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdrYi-0008Hn-Jc
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 00:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab1GDWXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 18:23:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61583 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1GDWXy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 18:23:54 -0400
Received: by pvg12 with SMTP id 12so4668276pvg.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 15:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qk+oLoPCXENbRN2uQYeA+epU2/KesdhSTEhz9EyNi2g=;
        b=abCc2gzL3gVOfb2y+56QwvCc559vvOXLG1SGsfi+BM5/9tdXuUjMsmuKfzRsgllR4/
         p/uEcX5Ce1EWNHPrlAI2kD3fHrrJRjTFw0h9xbUctJ4IimrNhpsaLyWDMeksedkFSdQt
         vT1kcQaGxd2VYq1unPoqVPB8oBzYeVc1lz6/0=
Received: by 10.68.22.101 with SMTP id c5mr7502334pbf.502.1309818234056; Mon,
 04 Jul 2011 15:23:54 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 15:23:14 -0700 (PDT)
In-Reply-To: <20110704215859.GA8909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176606>

Heya,

On Mon, Jul 4, 2011 at 23:58, Jonathan Nieder <jrnieder@gmail.com> wrote:
> It would mean no change compared to the current behavior. :)
> disconnect_helper() writes the blank line.
>
> That's why no patch came; sorry, I should have mentioned so.

With the only difference that currently that \n signifies the end of
the entire stream, whereas now it will mean the end of the imports?

-- 
Cheers,

Sverre Rabbelier
