From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Different Fetch and Push URLs?
Date: Fri, 26 Feb 2010 10:32:30 -0500
Message-ID: <c115fd3c1002260732x79f44d8ft6bff9d9b4f226402@mail.gmail.com>
References: <c115fd3c1002260701u11cf506fq747d7217d31eba59@mail.gmail.com> 
	<20100226152043.GA26963@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl2BW-0006l3-Ba
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 16:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074Ab0BZPcx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 10:32:53 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:55306 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965046Ab0BZPcw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 10:32:52 -0500
Received: by ywh35 with SMTP id 35so92915ywh.4
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=41k1f4ZyZHbLrWwS7MQNk4aGjT9MDM1k+bvwBTEvK34=;
        b=vzX7RRhixWpAfYzx+z+LEJ7Lra1uHFW+Y8uy7WgygSFU4wVVEF1sTaQ64SWWvBtypv
         y+Hiz13R3PatAYqgwOu0yHgPGdaUzumGK0cOvuDfo4HLdy6r9nKxs+NhtYbNA5HEaoUI
         aGA8p3BNxJjlQoFeNCei9L3PgqU5Y4bU/B21o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wKn8A2OF6tEGPvFGTWSw2DDg7viR2NJWJ1FllG8hz6nqejmiOSJvxh2a2TQg9JVUr3
         Of+EJ+8J+Kwo/utwW+nGQVOt3wSnRApOKerXMChzagTFhA6/T4PV02Avg16eR/Jm/glW
         ZjoGDJGm/0Uxu1PVsi52xQxQvxvnO3jXvC9Ro=
Received: by 10.101.155.38 with SMTP id h38mr844133ano.131.1267198371135; Fri, 
	26 Feb 2010 07:32:51 -0800 (PST)
In-Reply-To: <20100226152043.GA26963@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141134>

On Fri, Feb 26, 2010 at 10:20 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 26, 2010 at 10:01:40AM -0500, Tim Visher wrote:
>
>> My work situation leaves me in a situation where I can clone from my
>> central repo but I can't push there. =C2=A0Is it possible and does i=
t make
>> any sense to have a single remote with one URL that I pull from and
>> another than I push to? =C2=A0I only ask because I was looking at th=
e
>> output of `git remote show` and noticed that there are 2 URLs. =C2=A0=
If it
>> is possible, how do I do it? =C2=A0I looked in `.git/config` and the=
re's
>> only 1 URL there.
>
> Try "remote.*.pushurl". It's in git-config(1) and in git-push(1) unde=
r
> "Named remote in configuration file".

Thanks, both of you.  That worked like a charm.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
