From: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 14:58:51 +0100
Message-ID: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
	<AANLkTinvM6OhLdeKt5MqEeNhZJx63X+KzOy_ngEsy0A2@mail.gmail.com>
	<AANLkTi=G1ZpiaRN8vWYBJ33_ZOXo1t616X5gQU+jNda_@mail.gmail.com>
	<AANLkTinu+Wq84x2H0vB3rUSXbwreumrDC7k2dr5nOfjC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 23 14:59:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKtOi-00065U-VH
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab0KWN66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 08:58:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41798 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0KWN65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 08:58:57 -0500
Received: by bwz15 with SMTP id 15so7116216bwz.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8LM3Jk93Rt3vhsG8a5YxWisOrBrTjjPiRlM0iWPQUig=;
        b=m1/u/CaUK5Kjid6zDpMQ5Deihme+lWrE6IBxVaPz0v1D6j7llIFuYCgOpudp/t1blS
         +dHTvNmZxyD+q9HToSHILBA1a53H4NOFB9lg7NbQjSZzdhRK4ZSxewanc2r+cUwlnbnE
         ndVBSRo73F4YXnwslHtpUTToTaR5Bg6McUjFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wGqSnZJUQP+GVGNZnWGT5+bYl9jqkvB1nr8btIp6wWsMuJJEaXOY9ZPoNi0fF5i6PI
         ihEYHzRwab79e51HmGsPdzruKKr5kTa11I2erNHC8pk4yJT5DAp5lLst9MxoEpaNBIOz
         IC5R8ujvuRZYvjMH6rpEP7lF5KCYdPsgTd7rA=
Received: by 10.204.54.147 with SMTP id q19mr3469374bkg.69.1290520732275; Tue,
 23 Nov 2010 05:58:52 -0800 (PST)
Received: by 10.204.54.207 with HTTP; Tue, 23 Nov 2010 05:58:51 -0800 (PST)
In-Reply-To: <AANLkTinu+Wq84x2H0vB3rUSXbwreumrDC7k2dr5nOfjC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161964>

On Tue, Nov 23, 2010 at 2:56 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
..
> I experimented a bit around, and the last idea I played around with
> was to keep the Levenshtein-suggestions as-is, but to add all common
> commands that had the entered command as a prefix. That's a bit more
> generic than what you suggested, but also not as flexible as it would
> have to be a strict prefix.

+1. That would improve it a lot
