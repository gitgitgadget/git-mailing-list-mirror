From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 21:11:26 +0200
Message-ID: <CABNEGjy8M-pFTOs504Q1+G_DtocJwvzDyOAsJp9cn4BOSkv1TQ@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
	<CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
	<CABNEGjyXLnSvjhBewNDsjW=rthRh0HY+KgC05vPNPu5QCaAgXQ@mail.gmail.com>
	<201109042043.01159.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: knittl <knittl89@googlemail.com>,
	"John S. Urban" <urbanjost@comcast.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 04 21:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0I6P-0008MZ-2v
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab1IDTL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 15:11:28 -0400
Received: from mail-iy0-f194.google.com ([209.85.210.194]:33073 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab1IDTL1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 15:11:27 -0400
Received: by iadk27 with SMTP id k27so2014421iad.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rtMRf1NvE/GDzZCgoN+EsJCyi4WBxnEMJh9Wqoyka2Q=;
        b=QYLVSVJN+qy9aoqPUj2goOMgXhrcQG2ZqjN2dsghM8a/F5iAdMIz5N53ZZ0vNGc9aQ
         tNTmHljYlolOCBIwYiBoS4vJefpM+7YkELxa82P21SXkjO9gNIVb1KoV4Q2adeiuVKhm
         nQf9FsFgPXWNVzpuDjUmdY/GjO4MIYa8UjPOg=
Received: by 10.42.135.66 with SMTP id o2mr2869825ict.397.1315163486834; Sun,
 04 Sep 2011 12:11:26 -0700 (PDT)
Received: by 10.231.202.84 with HTTP; Sun, 4 Sep 2011 12:11:26 -0700 (PDT)
In-Reply-To: <201109042043.01159.trast@student.ethz.ch>
X-Google-Sender-Auth: VSdmoHLgEGwQZEsPv3sEiIUpvQ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180696>

On Sun, Sep 4, 2011 at 8:43 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Tor Arntsen wrote:
>> On Sun, Sep 4, 2011 at 4:30 PM, knittl <knittl89@googlemail.com> wro=
te:
>> >
>> > On Sun, Sep 4, 2011 at 3:32 AM, John S. Urban <urbanjost@comcast.n=
et> wrote:
>> > > With my first use of git(1) I =A0created a small project with ab=
out 200
>> > > "commits". =A0When this was complete, I needed to label each com=
mit with
>> > > information pointing it to a section of a document. I used tags =
for this.
>> >
>> > Use git notes[1] to attach additional info to existing commits. Gi=
t
>> > notes will by default be copied when using git rebase or git commi=
t
>> > --amend (cf. notes.rewrite.<command> config)
>>
>> Is that true? I've always lost the notes when rebasing. I just tried
>> that again now (1.7.5.4), and after a rebase the notes attached to a=
ny
>> commit that was rebased just disappeared. I've always had to hunt do=
wn
>> and re-create the notes. It would indeed be much more convenient if
>> the notes would tag along.
>
> Yes, that support has been present since 1.7.1, but it's not enabled
> by default: you need to configure notes.rewriteRef.

Thanks. Got it working. So it's not by default, as was suggested by
knittl, it has to be enabled. BTW, it's not at all obvious from the
manpage what it should be set to, there's no actual example. Found it
by trial&error plus finding a diff for a test.

-Tor
