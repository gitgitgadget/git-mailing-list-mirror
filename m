From: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 14:18:59 +0100
Message-ID: <AANLkTi=FaZ4MhJ2gDFZGiJVHsuY9jtNGgdWxX3Dq4BY6@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
	<AANLkTinFMn4V3c3yV6j72eqj5=v4jW7Uh3fmNDOyYjnT@mail.gmail.com>
	<AANLkTinj3ryChGKV8c6fHSD=aickmz0TMos4k0RYGKvo@mail.gmail.com>
	<AANLkTikxMXRiCYE=ny1tfrS64P0ywAHP_9eLJJzNUG3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:19:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsmE-000355-5K
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab0KWNTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 08:19:03 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63107 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab0KWNTB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:19:01 -0500
Received: by bwz15 with SMTP id 15so7078507bwz.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k2RFCp+DJsEtNJ44V4qwrqt+9hjkBXhIcpv48o/eSms=;
        b=hjik/vQ2XjoNzGz1/DSb3GhUzlE8omO2qhTZB/Cjm5Gtd+X+gLp9Dfkckp3eRJW4a2
         03ErmBe12gRB3cnCBpqVmAdlRfGVtoCPriEUWjWh083voOc8YS0oG/zT/UfVue2OPHsf
         G85oB+isXqLPZFB7kEB5bDtWPrxZRb6ZZYc0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d8ctwEGgU7uOe77bGgVelq/8xu2dpNtBnvEgPjYzokN+32c6YIRb3t+ohpQG5UiML7
         gOScOuNDTM+kHlv8DbhbgIfDNbwntVIAejCel6RxKFRPW2pIWt9/ZHAAZ5OiR8hLCiwV
         e/wG0hEomWm1GgglSdD4Wsp9I3KOEAyjKqyg4=
Received: by 10.204.54.147 with SMTP id q19mr3388755bkg.69.1290518339917; Tue,
 23 Nov 2010 05:18:59 -0800 (PST)
Received: by 10.204.54.207 with HTTP; Tue, 23 Nov 2010 05:18:59 -0800 (PST)
In-Reply-To: <AANLkTikxMXRiCYE=ny1tfrS64P0ywAHP_9eLJJzNUG3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161958>

On Tue, Nov 23, 2010 at 2:08 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
=2E..
>
> There's another command that starts with "st": stripspace (it's a
> lowlevel command by the way). It's going to be a lot more if you type
> "git m" and expect all commands starting with 'm'.

Maybe so yeah. That's how Mercurial does.

$  hg s
hg: command 's' is ambiguous:
    serve showconfig status strip summary


> Personally I would
> do "git help -a|grep st" in that case. Hmm.. "git apropos" could be a
> good idea.

I guess.

>> That's what the tab completion does:
>>
>> $ git st<tab>
>> stage =A0 =A0stash =A0 =A0status
>
> And it does for tab _completion_ (notice stripspace is missing,
> git-completion.sh only lists high level commands). The above case is
> to help mistyping.

Right.  Overall, I guess it's just a cultural thing. Using mainly
Mercurial, "st" means for me "status" so I was surprised not to find
it as a suggestion.

Cheers
Tarek

--=20
Tarek Ziad=E9 | http://ziade.org
