From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] Infinite loop in git send-email if ran non-interactively.
Date: Wed, 25 Mar 2009 12:23:56 -0400
Message-ID: <76718490903250923u5f7a84e8ma6093b1434b36172@mail.gmail.com>
References: <vpqiqlyj64o.fsf@bauges.imag.fr>
	 <76718490903250903t530983abi8a641e6b7aee6c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVv5-0000Lg-IK
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbZCYQYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbZCYQYD
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:24:03 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:32786 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZCYQYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:24:00 -0400
Received: by gxk4 with SMTP id 4so268946gxk.13
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0PaoPGKDWo4R6mhZW29gJvzOQsSzU3aNO0TiFHTWeYI=;
        b=svEKJQV6yqDkIkXWfvqiFPqr2VYfS95jSgxWEWwlFFiSL3Yinlfqiiz9y52Sn7USMU
         8pposw246KOGLY2MI/K2Q8iUaWmRfOCc+Xu5r6dOp1QgRfhfu3wbxAV/+ThcTicgTWQy
         5Fi9tBQbcniHJqWCNP3PmeBFxOePuLAu87TJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gq9xpXJ6UCkJ0L9Fp7V+zw+j6ikqhKXG2/9i9dEk2e1yc/na0cDbgp9LymvZBNF5AW
         PbxryRi2TFNJXPbMBfmJJTLuJOy2RD14ZPqsbEpcv6n7n9+EahjGUpg8xXZDLgL+eW81
         19mRbA2FbrYJ3PHgkON0XKbqAECir6WiF/xdk=
Received: by 10.151.48.20 with SMTP id a20mr139110ybk.197.1237998236917; Wed, 
	25 Mar 2009 09:23:56 -0700 (PDT)
In-Reply-To: <76718490903250903t530983abi8a641e6b7aee6c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114618>

On Wed, Mar 25, 2009 at 12:03 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Actually, FakeTerm is only triggered if Term::ReadLine is not
> available. The "going non-interactive" message is misleading in this
> case, as it has nothing to do with whether stdin is a tty or not.

Sorry, that's not true. Apparently the non-interactive test is not
working properly in this case.

j.
