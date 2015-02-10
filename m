From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: Gmail Message rejection
Date: Tue, 10 Feb 2015 12:52:43 -0800
Message-ID: <CAPKkNb7Q++LxcDzz-MfGZLLJsqiNC-N=42RfVQ6EZRJBp-_iww@mail.gmail.com>
References: <20150209201408.Horde.2Ts12JtaemmvhMa5RcSg8w1@server.aercontechnologies.net>
	<CALbm-EaxbmajmcbqVMN-Jp-xcrqW=P2DGeyqKPg-YM+zncd5bQ@mail.gmail.com>
	<vpqvbj9acum.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@gmail.com>, erik@aercon.net,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:52:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLHnc-0007yn-SO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 21:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbBJUwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 15:52:44 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34753 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbBJUwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 15:52:43 -0500
Received: by iery20 with SMTP id y20so27905252ier.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 12:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0vKSJhM8EWljamS/cxnAr3hRWBDlFKpGP7udJDlodb0=;
        b=cap0OoJCPs+Ued0cmgSMjlnQBYXRPGuLZIfI+nbTfKLNKRf+tNZstZB72i9JAfZCsc
         1GFtYedC1yskncnB4V3jpjTqeFpw/y3X7K5TrpV2EmN9p5rT2IurUJ4C5F7uGBzoGpXd
         8RFMrwrLaTe+454syljJOseeBJIMTBq6BJZUDZo3yYOx4yvLb/7sHvURUwdiu3S/PqG6
         XbpjIhAoVvWQNBdEWgkCaOM7epqld9zhgS2rlT3pRcdo2FlS+n68gnljICqCUyoOZpK8
         qoZxsYlyptYCOCc6sQ+V5j8vHDQUBiQd3Y6iioQn7psV/3rgr5zFzczm1vqwWYoMdfZa
         PHPw==
X-Received: by 10.50.111.168 with SMTP id ij8mr25836507igb.43.1423601563225;
 Tue, 10 Feb 2015 12:52:43 -0800 (PST)
Received: by 10.36.74.75 with HTTP; Tue, 10 Feb 2015 12:52:43 -0800 (PST)
In-Reply-To: <vpqvbj9acum.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263647>

On 10 February 2015 at 09:35, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> If you want email to send via gmail, you can do so by enabling "text
>> only" mode for sending mails.
>
> Unfortunately, it is also a known "bug" that the Android Gmail client
> doesn't have this option (or didn't last time I checked).

Don't use it, then!

We should not design our infrastructure to the lowest common
denominator like that.  Especially if it's just a question of
supporting broken brand new implementations, those which couldn't have
been bothered to adhere to the best practices.

C.
