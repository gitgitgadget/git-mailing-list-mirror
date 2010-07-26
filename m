From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/24] Documentation: Add variable-substitution script
Date: Mon, 26 Jul 2010 20:27:31 +0000
Message-ID: <AANLkTinv02tPIUObk6SUpAN2WA7BOK9aU73MWXamZRte@mail.gmail.com>
References: <cover.1280169048.git.trast@student.ethz.ch>
	<049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
	<20100726195144.GC1043@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:27:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdUGw-000691-7c
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794Ab0GZU1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 16:27:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44377 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab0GZU1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 16:27:32 -0400
Received: by iwn7 with SMTP id 7so3014762iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L9W8+zIeMd798mmAHNxCuWBoBb+3QDu+ZNU2NEw8eIk=;
        b=gZh5EB5LjYa39w81N2JBHNpd+5hzxEcxLbUdLh5QzeuuIDHe+eojsxvZcf4sXe42Jf
         AK5QjykVDFvYAzg9ns7k9TpoZfNbw72xRFucsAXVoy62f/oWRra54pxUjlx7++2COzeA
         j4IC3pk5H+6HeW1aIZqpJJ3bWe+DBYnL9pKXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AXVVKzW/AVUv3wkIcFg8x0F4feGCsXbOsvp4BifvmHPAGM0mnTN+NudCmCxFz/Kfrf
         V0dz4Me/15oVXIdemh/04JYAfLsU7NMWcZDND8/aiMCF7K+NZ30lCgWmkyTl6A5kvICx
         vxRFlt0eYHXd2mKUZgsNDp+Q507dPlauQL9Gg=
Received: by 10.231.152.143 with SMTP id g15mr9424195ibw.76.1280176052031; 
	Mon, 26 Jul 2010 13:27:32 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 13:27:31 -0700 (PDT)
In-Reply-To: <20100726195144.GC1043@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151892>

On Mon, Jul 26, 2010 at 19:51, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Thomas Rast wrote:

> I would like to make the git-config(1) man page more like the command
> list in git(1) and less like a concatenation of CONFIGURATION
> sections, but regardless, this is a good first step.

Yeah, I think git-config(1) shouldn't have the huge listing either,
but that's something for a later series to tackle.

>> +++ b/Documentation/subst-config.perl
>> @@ -0,0 +1,74 @@
> [...]
>> +if (!$rc or (!-r $varlist or !-r $input)) {
>> + =C2=A0 =C2=A0print "$0 --varlist=3D<varlist> --input=3D<in> --outp=
ut=3D<out>\n";
>> + =C2=A0 =C2=A0exit 1;
>> +}
>
> So the commit message is out of date (the new usage is more clear,
> anyway).

The history makes more sense in Thomas's git repository. I changed the
usage in a later commit, but that commit was squashed.
