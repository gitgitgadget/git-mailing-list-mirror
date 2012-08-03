From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [RFC] l10n: de.po: translate 76 new messages
Date: Fri, 3 Aug 2012 18:26:43 +0200
Message-ID: <CAN0XMOKWv2_zNBq8y1QGOjG5_+xk1CXvkpPue9Dg5V4OXQCPkg@mail.gmail.com>
References: <1343927525-3338-1-git-send-email-ralf.thielow@gmail.com>
	<87y5lw73m8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	worldhello.net@gmail.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxKiA-0003pA-JV
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 18:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab2HCQ0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 12:26:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61941 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab2HCQ0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 12:26:44 -0400
Received: by eaac11 with SMTP id c11so282355eaa.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XiKXFebLYWiES2NNr31D9wFcZUwEURp/VpGSAe3glk8=;
        b=DVuBik5GL7OzWVbM4w7Spz4VvneMNs2/1dBYjPX+URblHIcAh3RZNsUkLs6O/RJqBZ
         9RbJZoMd2q9wrR0ymgG1rABN9bkTQ0PFHrAkOoyjeiHYZoyuk+e3rbxO+5Tvz4Vz/9ME
         mSpsqPfRGtg77Z3RJGwSqyrhOx0FnLYyVSO/idgGxpjCmFgoYvrc1Ed3k9MW8mdUhaKx
         CCXGvT6a49IcidO/C/AIYgli0tzxMARlKdOAB5fwjvZczoUoIhG1CtvsYePcf29eIcbn
         qzaYKUq1nfpWo7DhhsV1aMgz41HKRI1cCs2w27cidomz2pEbTVzhqCFIF+RBcZ8YTEB8
         lEZg==
Received: by 10.14.208.133 with SMTP id q5mr2863653eeo.9.1344011203762; Fri,
 03 Aug 2012 09:26:43 -0700 (PDT)
Received: by 10.14.176.70 with HTTP; Fri, 3 Aug 2012 09:26:43 -0700 (PDT)
In-Reply-To: <87y5lw73m8.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202841>

On Fri, Aug 3, 2012 at 10:59 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>  #: merge-recursive.c:1918
>>  #, c-format
>>  msgid "found %u common ancestor(s):"
>> -msgstr ""
>> +msgstr "%u gemeinsame Vorg=C3=A4nger gefunden"
>

Another TODO is to make two different messages in case
that %u is one and bigger than one as it's done in diff.c
like "Q_(" %d file changed", " %d files changed", files)".

Based on your suggestions it would be now translated as
"%u gemeinsame(n) Vorfahren gefunden"
It would be nicer to have two messages like
"%u gemeinsamen Vorfahren gefunden"
"%u gemeinsame Vorfahren gefunden"
